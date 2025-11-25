<?php
declare(strict_types=1);
require_once __DIR__ . '/../_lib/session.php';
require_once __DIR__ . '/../_lib/util.php';

rsud_session_destroy();
json_out(200, ['ok'=>true]);
