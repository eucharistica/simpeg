<?php

$uri = strtok($_SERVER['REQUEST_URI'] ?? '/', '?') ?: '/';

// Tentukan root aktif: dash (default), simrs, atau backoffice
$activeRoot = $_GET['__root'] ?? 'dashboards';
if (strpos($uri, '/apps/office') === 0) {
    $activeRoot = 'office';
} elseif (strpos($uri, '/apps/simrs') === 0) {
    $activeRoot = 'simrs';
}

// Helpers untuk class active/here
function rootActive(string $code, string $active): string
{
    return $code === $active ? 'active' : '';
}
function menuHere(string $pathPrefix): string
{
    $uri = strtok($_SERVER['REQUEST_URI'] ?? '/', '?') ?: '/';
    return (strpos($uri, $pathPrefix) === 0) ? 'here show' : '';
}
?>


<div id="kt_aside" class="aside aside-extended" 
    data-kt-drawer="true" 
    data-kt-drawer-name="aside"
    data-kt-drawer-activate="{default: true, lg: false}" 
    data-kt-drawer-overlay="true" 
    data-kt-drawer-width="auto"
    data-kt-drawer-direction="start" 
    data-kt-drawer-toggle="#kt_aside_mobile_toggle">
    <!--begin::Primary-->
    <div class="aside-primary d-flex flex-column align-items-lg-center flex-row-auto">
        <div class="aside-logo d-none d-lg-flex flex-column align-items-center flex-column-auto py-10"
            id="kt_aside_logo">
            <a href="apps/dashboards/">
                <img alt="Logo" src="/assets/media/logos/demo7.svg" class="h-35px" />
            </a>
        </div>
        <!--begin::Nav-->
        <div class="aside-nav d-flex flex-column align-items-center flex-column-fluid w-100 pt-5 pt-lg-0"
            id="kt_aside_nav">
            <div class="hover-scroll-overlay-y mb-5 scroll-ms px-5" data-kt-scroll="true"
                data-kt-scroll-activate="{default: false, lg: true}" data-kt-scroll-height="auto"
                data-kt-scroll-wrappers="#kt_aside_nav" data-kt-scroll-dependencies="#kt_aside_logo, #kt_aside_footer"
                data-kt-scroll-offset="0px">

                <?php 
                include __DIR__ . '/primary-menu/menu.php'; 
                ?>                
            </div>
        </div>
        <!--end::Nav-->
        <div class="aside-footer d-flex flex-column align-items-center flex-column-auto" id="kt_aside_footer">            
            <?php 
            include __DIR__ . '/footer-primary/user.php'; 
            ?>
        </div>
    </div>
    <!--end::Primary-->

    <!--begin::Secondary-->
    <div class="aside-secondary d-flex flex-row-fluid">
        <div class="aside-workspace my-5 p-5" id="kt_aside_wordspace">
            <div class="d-flex h-100 flex-column">
                <div class="flex-column-fluid hover-scroll-y" data-kt-scroll="true" data-kt-scroll-activate="true"
                    data-kt-scroll-height="auto" data-kt-scroll-wrappers="#kt_aside_wordspace"
                    data-kt-scroll-dependencies="#kt_aside_secondary_footer" data-kt-scroll-offset="0px">

                    <div class="tab-content">
                    <?php 
                    if ($activeRoot==='dashboards'):
                        include __DIR__ . '/secondary-menu/dashboard.php'; 
                    elseif ($activeRoot==='simrs'):
                        include __DIR__ . '/secondary-menu/simrs.php';
                    endif;
                    ?>
                    </div>

                </div>

                <div class="flex-column-auto pt-10 px-5" id="kt_aside_secondary_footer">
                    <a href="https://preview.keenthemes.com/html/metronic/docs"
                        class="btn btn-bg-light btn-color-gray-600 btn-flex btn-active-color-primary flex-center w-100"
                        data-bs-toggle="tooltip" data-bs-custom-class="tooltip-dark" data-bs-trigger="hover"
                        data-bs-offset="0,5" data-bs-dismiss-="click"
                        title="200+ in-house components and 3rd-party plugins">
                        <span class="btn-label">Docs & Components</span>
                        <i class="ki-duotone ki-document btn-icon fs-4 ms-2">
                            <span class="path1"></span>
                            <span class="path2"></span>
                        </i>
                    </a>
                </div>

            </div>
        </div>
    </div>
    <!--end::Secondary-->
    <!--begin::Aside Toggle-->
    <button id="kt_aside_toggle"
        class="aside-toggle btn btn-sm btn-icon bg-body btn-color-gray-700 btn-active-primary position-absolute translate-middle start-100 end-0 bottom-0 shadow-sm d-none d-lg-flex mb-5"
        data-kt-toggle="true" data-kt-toggle-state="active" data-kt-toggle-target="body"
        data-kt-toggle-name="aside-minimize">
        <i class="ki-duotone ki-arrow-left fs-2 rotate-180">
            <span class="path1"></span>
            <span class="path2"></span>
        </i>
    </button>
    <!--end::Aside Toggle-->
</div>