<?php
// api/auth/me.php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/util.php';
require_once __DIR__ . '/../_lib/auth.php';

$s = session_get();
if (!$s) json_out(401, ['ok'=>false,'error'=>'unauthorized']);

$user = [
  'id'        => (int)$s['user_id2'],
  'email'     => $s['email'],
  'username'  => $s['username'],
  'full_name' => $s['full_name'],
  'status'    => $s['status'],
];

$perms = user_effective_permissions((int)$s['user_id2']);

json_out(200, ['ok'=>true, 'user'=>$user, 'permissions'=>$perms]);
