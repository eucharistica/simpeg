<?php
// api/simrs/schedule.php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/util.php';
require_once __DIR__ . '/../_lib/db_sik.php';

$s = session_get();
if (!$s) json_out(401, ['ok'=>false,'error'=>'unauthorized']);

$kd_poli = trim($_GET['kd_poli'] ?? '');
$hari    = trim($_GET['hari'] ?? '');

$pdo = db_sik();

$sql = "SELECT j.kd_poli, p.nm_poli, j.kd_dokter, d.nm_dokter, j.hari_kerja, j.jam_mulai, j.jam_selesai, j.kuota
        FROM jadwal j
        JOIN poliklinik p ON p.kd_poli=j.kd_poli
        JOIN dokter d ON d.kd_dokter=j.kd_dokter
        WHERE 1=1";
$params = [];
if ($kd_poli !== '') { $sql .= " AND j.kd_poli = ?"; $params[] = $kd_poli; }
if ($hari !== '')    { $sql .= " AND j.hari_kerja = ?"; $params[] = $hari; }
$sql .= " ORDER BY p.nm_poli, d.nm_dokter";

$st = $pdo->prepare($sql);
$st->execute($params);
$rows = $st->fetchAll();
json_out(200, ['ok'=>true, 'data'=>$rows]);
