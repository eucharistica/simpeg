(function () {
    const DASH = '/apps/dashboards/';
    const SIGNIN = '/authentication/sign-in.html';
  
    // Helper: ambil query param
    function q(name) {
      return new URLSearchParams(location.search).get(name);
    }
  
    // Panggil ini dari setiap halaman yang Wajib Login
    async function requireAuth(opts) {
      const o = Object.assign({ allowGuests: false, redirectTo: SIGNIN }, opts || {});
      try {
        const res = await fetch('/api/auth/me.php', { credentials: 'include' });
        const js = await res.json().catch(() => ({}));
        if (js && js.ok) {
          // simpan user global utk header/sidebar dsb.
          window.RSUD_USER = js.user;
          window.RSUD_PERMS = js.permissions || [];
          // jika ini halaman sign-in, langsung pindah ke dashboard
          if (location.pathname.endsWith('/authentication/sign-in.html')) {
            location.replace(DASH);
          }
          return true;
        } else {
          if (!o.allowGuests) {
            // redirect ke sign-in, kirim returnTo supaya bisa kembali ke halaman semula
            const returnTo = encodeURIComponent(location.pathname + location.search + location.hash);
            location.replace(`${SIGNIN}?returnTo=${returnTo}`);
          }
          return false;
        }
      } catch {
        if (!o.allowGuests) {
          const returnTo = encodeURIComponent(location.pathname + location.search + location.hash);
          location.replace(`${SIGNIN}?returnTo=${returnTo}`);
        }
        return false;
      }
    }
  
    // Expose global
    window.RSUD = window.RSUD || {};
    window.RSUD.requireAuth = requireAuth;
  
    // Otomatis jalan:
    document.addEventListener('DOMContentLoaded', () => {
      const path = location.pathname;
  
      // Halaman sign-in: allowGuests, tapi kalau sudah login → redirect ke dashboard oleh requireAuth()
      if (path.endsWith('/authentication/sign-in.html')) {
        requireAuth({ allowGuests: true });
        // Set hidden redirect dari ?returnTo=... agar login balik ke halaman asal
        const rt = q('returnTo');
        const form = document.querySelector('#kt_sign_in_form');
        if (form && rt) {
          let h = form.querySelector('input[name="redirect"]');
          if (!h) {
            h = document.createElement('input');
            h.type = 'hidden';
            h.name = 'redirect';
            form.appendChild(h);
          }
          h.value = rt;
        }
        return;
      }
  
      // Default: semua halaman di bawah /apps/ dan /authentication/ selain sign-in wajib login
      const mustAuth =
        path.startsWith('/apps/') || path.startsWith('/utilities/') || (path.startsWith('/authentication/') && !path.endsWith('/authentication/sign-in.html'));
  
      if (mustAuth) requireAuth();
    });
  })();
  