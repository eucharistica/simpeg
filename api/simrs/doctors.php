<?php
// api/simrs/doctors.php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/util.php';
require_once __DIR__ . '/../_lib/db_sik.php';

$s = session_get();
if (!$s) json_out(401, ['ok'=>false,'error'=>'unauthorized']);

$pdo = db_sik();
$q = $pdo->query("SELECT kd_dokter, nm_dokter, jk FROM dokter WHERE status = '1' ORDER BY nm_dokter");
$rows = $q->fetchAll();
json_out(200, ['ok'=>true, 'data'=>$rows]);
