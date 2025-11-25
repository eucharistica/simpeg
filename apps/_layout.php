<?php
declare(strict_types=1);
require_once __DIR__ . '/_lib/boot.php';
guard_or_redirect('/authentication/sign-in.html');

$user = current_user();
$perms = current_permissions();
$page_title = $page_title ?? 'Dashboard';
$view = $view ?? null;
?><!DOCTYPE html>
<html lang="en">

<head><?php include __DIR__ . '/partials/head.php'; ?></head>

<body id="kt_body" style="background-image: url()"
  class="header-fixed header-tablet-and-mobile-fixed aside-fixed aside-secondary-enabled">
  <script>var defaultThemeMode = "light"; var themeMode; if (document.documentElement) { if (document.documentElement.hasAttribute("data-bs-theme-mode")) { themeMode = document.documentElement.getAttribute("data-bs-theme-mode"); } else { if (localStorage.getItem("data-bs-theme") !== null) { themeMode = localStorage.getItem("data-bs-theme"); } else { themeMode = defaultThemeMode; } } if (themeMode === "system") { themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"; } document.documentElement.setAttribute("data-bs-theme", themeMode); }</script>
  <div class="d-flex flex-column flex-root">
    <div class="page d-flex flex-row flex-column-fluid">

      <?php include __DIR__ . '/partials/aside.php'; ?>

      <div class="wrapper d-flex flex-column flex-row-fluid" id="kt_wrapper">
        <?php include __DIR__ . '/partials/header.php'; ?>
        <div class="content d-flex flex-column flex-column-fluid" id="kt_content">
          <!--begin::Container-->
          <div class="container-xxl" id="kt_content_container">
            <?php if ($view) {
              include $view;
            } ?>
          </div>
          <!--end::Container-->
        </div>
        <?php include __DIR__ . '/partials/footer.php'; ?>
      </div>

    </div>
  </div>
  <?php include __DIR__ . '/partials/drawers/layout_drawers.php'; ?>
  <?php include __DIR__ . '/partials/scripts.php'; ?>
</body>
</html>