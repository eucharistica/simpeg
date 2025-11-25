<?php
// api/simrs/clinics.php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/util.php';
require_once __DIR__ . '/../_lib/db_sik.php';

$s = session_get();
if (!$s) json_out(401, ['ok'=>false,'error'=>'unauthorized']);

$pdo = db_sik();
$q = $pdo->query("SELECT kd_poli, nm_poli, IFNULL(status,'1') AS status FROM poliklinik where status ='1' ORDER BY nm_poli");
$rows = $q->fetchAll();
json_out(200, ['ok'=>true, 'data'=>$rows]);
