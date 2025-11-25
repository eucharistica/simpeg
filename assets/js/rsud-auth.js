"use strict";

var RSUDSignin = (function () {
  var form, submitBtn, fv;

  // helper: ambil nilai redirect dari hidden input / attr data-kt-redirect-url
  function getRedirect() {
    const hidden = form.querySelector('input[name="redirect"]');
    if (hidden && hidden.value) return hidden.value;
    const attr = form.getAttribute("data-kt-redirect-url");
    return attr && attr.length ? attr : "/apps/dashboards/";
  }

  // map error API -> field error + swal text
  function applyApiError(code) {
    // tentukan field identifier yang dipakai (username/email/identifier)
    const identifierEl =
      form.querySelector('input[name="username"]') ||
      form.querySelector('input[name="email"]') ||
      form.querySelector('input[name="identifier"]');

    const passwordEl = form.querySelector('input[name="password"]');

    // helper tampilkan error per kolom
    const setInvalid = (el, msg) => {
      if (!el) return;
      el.classList.remove("is-valid");
      el.classList.add("is-invalid");
      let fb = el.parentElement.querySelector(".invalid-feedback");
      if (!fb) {
        fb = document.createElement("div");
        fb.className = "invalid-feedback";
        el.parentElement.appendChild(fb);
      }
      fb.style.display = "block";
      fb.textContent = msg;
    };

    let swalText = "Sorry, looks like there are some errors detected, please try again.";

    switch (code) {
      case "empty_fields":
        setInvalid(identifierEl, "This field is required");
        setInvalid(passwordEl, "The password is required");
        swalText = "Please complete the form.";
        break;
      case "invalid_credentials":
        setInvalid(identifierEl, "The email/username or password is incorrect");
        setInvalid(passwordEl, "The email/username or password is incorrect");
        swalText = "Sorry, the email/username or password is incorrect. Please try again.";
        break;
      case "too_many_attempts":
        setInvalid(identifierEl, "Too many attempts. Please try again in a few minutes.");
        swalText = "Too many attempts. Please try again later.";
        break;
      case "user_not_active":
        setInvalid(identifierEl, "This account is not active. Please contact administrator.");
        swalText = "This account is not active.";
        break;
      case "server_error":
      case "invalid_json":
      case "method_not_allowed":
      default:
        setInvalid(passwordEl, "An unexpected error occurred. Please try again.");
        swalText = "Sorry, looks like there are some errors detected, please try again.";
    }

    Swal.fire({
      text: swalText,
      icon: "error",
      buttonsStyling: false,
      confirmButtonText: "Ok, got it!",
      customClass: { confirmButton: "btn btn-primary" },
    });
  }

  return {
    init: function () {
      form = document.querySelector("#kt_sign_in_form") || document.querySelector('form[data-rsud-signin]');
      if (!form) return;

      submitBtn =
        form.querySelector("#kt_sign_in_submit") || form.querySelector('[type="submit"]');

      // tentukan field identifier: username ATAU email ATAU identifier
      const hasUsername = !!form.querySelector('input[name="username"]');
      const hasEmail = !!form.querySelector('input[name="email"]');

      // siapkan rules FormValidation seperti general.js
      var fieldsCfg = {
        password: {
          validators: {
            notEmpty: { message: "The password is required" },
          },
        },
      };

      if (hasEmail && !hasUsername) {
        // login via email saja (ikut contoh general.js)
        fieldsCfg.email = {
          validators: {
            regexp: {
              regexp: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
              message: "The value is not a valid email address",
            },
            notEmpty: { message: "Email address is required" },
          },
        };
      } else {
        // login via username (atau identifier umum)
        fieldsCfg.username = {
          validators: {
            notEmpty: { message: "Username is required" },
          },
        };
      }

      fv = FormValidation.formValidation(form, {
        fields: fieldsCfg,
        plugins: {
          trigger: new FormValidation.plugins.Trigger(),
          bootstrap: new FormValidation.plugins.Bootstrap5({
            rowSelector: ".fv-row",
            eleInvalidClass: "", // biar Metronic yang styling
            eleValidClass: "",
          }),
        },
      });

      // submit handler ala general.js (gunakan fetch ke API kita)
      submitBtn.addEventListener("click", function (ev) {
        ev.preventDefault();

        fv.validate().then(function (status) {
          if (status === "Valid") {
            // tampilkan spinner & disable tombol
            submitBtn.setAttribute("data-kt-indicator", "on");
            submitBtn.disabled = true;

            // siapkan payload
            const identifierVal =
              (form.querySelector('input[name="email"]')?.value ||
               form.querySelector('input[name="username"]')?.value ||
               form.querySelector('input[name="identifier"]')?.value || ""
              ).trim();
            const passVal = form.querySelector('input[name="password"]')?.value || "";
            const redirect = getRedirect();

            fetch("/api/auth/login.php", {
              method: "POST",
              headers: { "Content-Type": "application/x-www-form-urlencoded" },
              credentials: "include",
              body: new URLSearchParams({
                identifier: identifierVal,
                password: passVal,
                redirect: redirect,
              }),
            })
              .then((r) => r.json().catch(() => ({ ok: false, error: "invalid_json" })))
              .then((js) => {
                // matikan spinner
                submitBtn.removeAttribute("data-kt-indicator");
                submitBtn.disabled = false;

                if (js && js.ok) {
                  // reset form ala general.js + swal success
                  try { form.reset(); } catch (_) {}
                  Swal.fire({
                    text: "You have successfully logged in!",
                    icon: "success",
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: { confirmButton: "btn btn-primary" },
                  }).then(function (res) {
                    if (res.isConfirmed) {
                      window.location.href = js.redirect || redirect;
                    }
                  });
                } else {
                  applyApiError(js && js.error ? js.error : "server_error");
                }
              })
              .catch(function () {
                // matikan spinner
                submitBtn.removeAttribute("data-kt-indicator");
                submitBtn.disabled = false;
                applyApiError("server_error");
              });
          } else {
            // invalid → swal error (ngikut general.js)
            Swal.fire({
              text: "Sorry, looks like there are some errors detected, please try again.",
              icon: "error",
              buttonsStyling: false,
              confirmButtonText: "Ok, got it!",
              customClass: { confirmButton: "btn btn-primary" },
            });
          }
        });
      });
    },
  };
})();

// init saat DOM siap (ngikut pola Metronic)
KTUtil.onDOMContentLoaded(function () {
  RSUDSignin.init();
});
