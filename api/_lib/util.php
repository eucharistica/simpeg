<?php
// api/_lib/util.php
declare(strict_types=1);

function now(): string { return gmdate('Y-m-d H:i:s'); }

function client_ip_bin(): ?string {
    $ip = $_SERVER['REMOTE_ADDR'] ?? null;
    if (!$ip) return null;
    $bin = @inet_pton($ip);
    return $bin === false ? null : $bin;
}

function ua_trim(): string {
    $ua = $_SERVER['HTTP_USER_AGENT'] ?? '';
    if (strlen($ua) > 255) $ua = substr($ua, 0, 255);
    return $ua;
}

function json_out(int $code, array $data): void {
    http_response_code($code);
    header('Content-Type: application/json');
    header('Cache-Control: no-store');
    echo json_encode($data);
    exit;
}

function require_post(): void {
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
        json_out(405, ['ok'=>false,'error'=>'method_not_allowed']);
    }
}

function same_site_cookie(string $name, string $value, int $ttlSeconds, bool $secure = true): void {
    $params = [
        'expires' => time() + $ttlSeconds,
        'path'    => '/',
        'domain'  => '',      // default current host
        'secure'  => $secure,
        'httponly'=> true,
        'samesite'=> 'Lax',
    ];
    setcookie($name, $value, $params);
}

function random_hex(int $len = 64): string {
    return bin2hex(random_bytes(intval($len/2)));
}
