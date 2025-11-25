<?php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/util.php';
require_once __DIR__ . '/../_lib/db.php';

require_post();     
require_csrf();     

$s = session_get(); 
$userId = (int)$s['user_id2'];

$full_name = trim($_POST['full_name'] ?? '');
if ($full_name === '') {
  json_out(422, ['ok'=>false,'error'=>'validation','fields'=>['full_name'=>'required']]);
}

$pdo = db();
$st = $pdo->prepare("UPDATE auth_users SET full_name=?, updated_at=NOW() WHERE id=?");
$st->execute([$full_name, $userId]);

json_out(200, ['ok'=>true]);
