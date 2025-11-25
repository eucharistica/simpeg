<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';

function find_user_by_identifier(string $identifier): ?array {
    $pdo = db();
    // Accept email or username
    $stmt = $pdo->prepare("SELECT * FROM auth_users WHERE (email = ? OR username = ?) AND deleted_at IS NULL LIMIT 1");
    $stmt->execute([$identifier, $identifier]);
    $u = $stmt->fetch();
    return $u ?: null;
}

function log_attempt(string $identifier, bool $success, ?string $reason): void {
    $pdo = db();
    $stmt = $pdo->prepare("INSERT INTO auth_login_attempts (user_identifier, ip, success, reason, created_at) VALUES (?, ?, ?, ?, NOW())");
    $stmt->execute([$identifier, client_ip_bin(), $success ? 1 : 0, $reason]);
}

function too_many_attempts(string $identifier, int $windowMin = 10, int $max = 7): bool {
    $pdo = db();
    $stmt = $pdo->prepare("SELECT COUNT(*) c FROM auth_login_attempts WHERE user_identifier = ? AND created_at >= (NOW() - INTERVAL ? MINUTE)");
    $stmt->execute([$identifier, $windowMin]);
    return (int)$stmt->fetchColumn() >= $max;
}

function user_effective_permissions(int $userId): array {
    $pdo = db();

    // 1) explicit deny
    $deny = $pdo->prepare("SELECT p.code FROM auth_user_permissions up JOIN auth_permissions p ON p.id=up.permission_id WHERE up.user_id=? AND up.effect='deny'");
    $deny->execute([$userId]);
    $denySet = array_column($deny->fetchAll(), 'code');

    // 2) explicit allow
    $allow = $pdo->prepare("SELECT p.code FROM auth_user_permissions up JOIN auth_permissions p ON p.id=up.permission_id WHERE up.user_id=? AND up.effect='allow'");
    $allow->execute([$userId]);
    $allowSet = array_column($allow->fetchAll(), 'code');

    // 3) from roles
    $role = $pdo->prepare("SELECT p.code FROM auth_user_roles ur JOIN auth_role_permissions rp ON rp.role_id=ur.role_id JOIN auth_permissions p ON p.id=rp.permission_id WHERE ur.user_id=?");
    $role->execute([$userId]);
    $roleSet = array_column($role->fetchAll(), 'code');

    // compose: deny removes, allow adds
    $perms = array_values(array_unique(array_diff(array_merge($roleSet, $allowSet), $denySet)));
    sort($perms);
    return $perms;
}