<?php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/util.php';

$s = session_get();
if (!$s) json_out(401, ['ok'=>false,'error'=>'unauthorized']);

json_out(200, ['ok'=>true, 'csrf_token' => $s['csrf_token']]);
