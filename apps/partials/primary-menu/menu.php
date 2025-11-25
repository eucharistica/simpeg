<!--begin::Nav-->
<ul class="nav flex-column w-100" id="kt_aside_nav_tabs">
    <!--begin::Nav item-->
    <li class="nav-item mb-2" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="right"
        data-bs-dismiss="click" title="Dashboard">
        <!--begin::Nav link-->
        <a class="nav-link btn btn-icon btn-active-color-primary btn-color-gray-500 btn-active-light <?= rootActive('dashboards',$activeRoot) ?>"
             href="/apps/dashboards">
            <i class="ki-duotone ki-briefcase fs-2x">
                <span class="path1"></span>
                <span class="path2"></span>
            </i>
        </a>
        <!--end::Nav link-->
    </li>
    <!--end::Nav item-->
    <!--begin::Nav item-->
    <?php if (can('simrs:view')): ?>
    <li class="nav-item mb-2" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="right"
        data-bs-dismiss="click" title="SIMRS">
        <!--begin::Nav link-->
        <a class="nav-link btn btn-icon btn-active-color-primary btn-color-gray-500 btn-active-light <?= rootActive('simrs',$activeRoot) ?>"
             href="/apps/simrs">
            <i class="ki-duotone ki-abstract fs-2x">
                <span class="path1"></span>
                <span class="path2"></span>
                <span class="path3"></span>
                <span class="path4"></span>
            </i>
        </a>
        <!--end::Nav link-->
    </li>
    <?php endif; ?>
    <!--end::Nav item-->
</ul>
<!--end::Tabs-->