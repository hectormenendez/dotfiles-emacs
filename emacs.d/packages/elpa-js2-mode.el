;;; elpa-js2-mode.el --- Javascript bindings

;;; Commentary:

;;; Code:
(use-package js2-mode
    :ensure t
    :interpreter "node"
    :mode (("\\.js\\'" . js2-mode))
    :config (progn
        (setq-default
            js2-basic-offset 4
            js2-highlight-level 3
            js2-auto-indent-p t
            js2-indent-switch-body t
            js2-indent-on-enter-key t
            js2-include-browser-externs t
            js2-include-node-externs t
            js2-warn-about-unused-function-arguments t
            ;; let flycheck handle parse errors
            js2-mode-show-parse-errors nil
            js2-strict-missing-semi-warning nil
            js2-strict-trailing-comma-warning nil
            js2-strict-cond-assign-warning nil
            js2-strict-inconsistent-return-warning nil
            js2-strict-var-hides-function-arg-warning nil
            js2-strict-var-redeclaration-warning nil
        )
        (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))
    )
)

;; Packages dependent on js2-mode
(add-hook 'js2-mode-hook (lambda ()

    ;; TODO: Why do I needed this again?
    (use-package simple-httpd :ensure t)

    ;; TODO: And this one too?
    (use-package skewer-mode
        :ensure t
        :delight skewer-mode
        :config (skewer-mode 1)
    )

    ;; TODO: Shit, this one too!
    (use-package ac-js2
        :ensure t
        :config (progn
            (setq ac-js2-evaluate-calls t)
            (ac-js2-mode 1)
        )
    )

    ;; Enable tern
    (use-package tern
        :ensure t
        :config (progn
            (setq tern-command (append tern-command '("--no-port-file")))
            (tern-mode 1)
        )
    )

))

            ;; Add tern to copany backends.
            ;; (use-package company-tern
            ;;     :ensure t
            ;;     :init (add-to-list 'company-backends 'company-tern)
            ;;     :config (setq company-tern-property-marker nil)
            ;; )

(provide 'elpa-js2-mode)
;;; elpa-js2-mode.el ends here

