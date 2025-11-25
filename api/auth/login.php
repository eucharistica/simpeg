<?php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/db.php';
require_once __DIR__ . '/../_lib/util.php';
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/auth.php';

header('Content-Type: application/json');
header('Cache-Control: no-store');

try {
    require_post();

    $identifier = trim($_POST['identifier'] ?? '');
    $password = (string) ($_POST['password'] ?? '');

    if ($identifier === '' || $password === '') {
        json_out(422, ['ok' => false, 'error' => 'empty_fields']);
    }

    if (too_many_attempts($identifier)) {
        log_attempt($identifier, false, 'rate_limited');
        json_out(429, ['ok' => false, 'error' => 'too_many_attempts']);
    }

    $u = find_user_by_identifier($identifier);
    if (!$u) {
        log_attempt($identifier, false, 'user_not_found');
        json_out(401, ['ok' => false, 'error' => 'invalid_credentials']);
    }
    if (($u['status'] ?? 'active') !== 'active') {
        log_attempt($identifier, false, 'user_not_active');
        json_out(403, ['ok' => false, 'error' => 'user_not_active']);
    }

    $ok = password_verify($password, $u['password_hash']);
    if (!$ok) {
        log_attempt($identifier, false, 'invalid_password');
        json_out(401, ['ok' => false, 'error' => 'invalid_credentials']);
    }

    log_attempt($identifier, true, 'ok');

    session_create((int) $u['id']);
    $pdo = db();
    $st = $pdo->prepare("UPDATE auth_users SET last_login_at = NOW(), last_login_ip = ?, last_login_ua = ? WHERE id = ?");
    $st->execute([client_ip_bin(), ua_trim(), (int) $u['id']]);

    // konsisten dengan "apps/dashboards/"
    json_out(200, ['ok' => true, 'redirect' => '/apps/dashboards/']);

} catch (Throwable $e) {
    // TODO: log ke file jika perlu
    json_out(500, ['ok' => false, 'error' => 'server_error']);
}