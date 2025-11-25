<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';
require_once __DIR__ . '/util.php';

const SESSION_COOKIE = 'rsud_sid';
const SESSION_TTL    = 60*60*6; // 6 hours

function session_create(int $userId): string {
    $sid = random_hex(64);
    $csrf = random_hex(64);

    $pdo = db();
    $stmt = $pdo->prepare("INSERT INTO auth_sessions (id, user_id, ip, user_agent, csrf_token, created_at, last_activity, expires_at)
                           VALUES (?, ?, ?, ?, ?, NOW(), NOW(), DATE_ADD(NOW(), INTERVAL ? SECOND))");
    $stmt->execute([$sid, $userId, client_ip_bin(), ua_trim(), $csrf, SESSION_TTL]);

    same_site_cookie(SESSION_COOKIE, $sid, SESSION_TTL, isset($_SERVER['HTTPS']));
    return $sid;
}

function session_get(): ?array {
    $sid = $_COOKIE[SESSION_COOKIE] ?? '';
    if (!$sid) return null;
    if (!preg_match('/^[a-f0-9]{64}$/', $sid)) return null;

    $pdo = db();
    $stmt = $pdo->prepare("SELECT s.*, u.id AS user_id2, u.email, u.username, u.full_name, u.status
                           FROM auth_sessions s
                           JOIN auth_users u ON u.id = s.user_id
                           WHERE s.id = ? AND s.expires_at > NOW()");
    $stmt->execute([$sid]);
    $row = $stmt->fetch();
    if (!$row) return null;

    // touch last_activity (lazy update)
    $pdo->prepare("UPDATE auth_sessions SET last_activity = NOW() WHERE id = ?")->execute([$sid]);

    return $row;
}

function rsud_session_destroy(): void {
    $sid = $_COOKIE[SESSION_COOKIE] ?? '';
    if ($sid && preg_match('/^[a-f0-9]{64}$/', $sid)) {
        $pdo = db();
        $pdo->prepare("DELETE FROM auth_sessions WHERE id = ?")->execute([$sid]);
    }
    same_site_cookie(SESSION_COOKIE, '', -3600, isset($_SERVER['HTTPS']));
}

function csrf_token(): ?string {
    $s = session_get();
    return $s['csrf_token'] ?? null;
}

function require_csrf(): void {
    $s = session_get();
    if (!$s) {
        json_out(401, ['ok'=>false,'error'=>'unauthorized']);
    }
    $sent = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? ($_POST['csrf_token'] ?? '');
    if (!$sent || !hash_equals($s['csrf_token'], $sent)) {
        json_out(419, ['ok'=>false,'error'=>'invalid_csrf']);
    }
}