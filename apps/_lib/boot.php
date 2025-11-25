<?php
// apps/_lib/boot.php
declare(strict_types=1);

require_once __DIR__ . '/../../api/_lib/session.php';
require_once __DIR__ . '/../../api/_lib/auth.php';

if (!function_exists('rsud_str_starts_with')) {
    function rsud_str_starts_with(string $haystack, string $needle): bool {
        return $needle === '' || strncmp($haystack, $needle, strlen($needle)) === 0;
    }
}

function guard_or_redirect(string $signin = '/authentication/sign-in.html'): void {
    $s = session_get();
    if (!$s) {
        header('Location: ' . $signin);
        exit;
    }
}

function current_user(): ?array {
    $s = session_get();
    if (!$s) return null;
    return [
        'id'        => (int)$s['user_id2'],
        'email'     => $s['email'],
        'username'  => $s['username'],
        'full_name' => $s['full_name'],
        'status'    => $s['status'],
    ];
}

function current_permissions(): array {
    $s = session_get();
    if (!$s) return [];
    return user_effective_permissions((int)$s['user_id2']);
}

function can(string $code): bool {
    static $permSet = null;
    if ($permSet === null) {
        $permSet = array_flip(current_permissions()); // fast lookup
    }
    return isset($permSet[$code]);
}

function is_current(string $pathPrefix): bool {
    $uri = strtok($_SERVER['REQUEST_URI'] ?? '/', '?') ?: '/';
    return rsud_str_starts_with($uri, $pathPrefix);
}
