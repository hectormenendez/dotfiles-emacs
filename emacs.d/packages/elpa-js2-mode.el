;;; elpa-js2-mode.el --- Javascript bindings

;;; Commentary:

;;; Code:

;; Enable tern
(use-package tern
    :ensure t
    :config (add-hook 'js2-mode-hook '(lambda ()
        (setq tern-flash-timeout 30); Wait 30 seconds before removing the function helper
        (tern-mode 1)
    ))
)

;; Add tern to copany backends.
(use-package company-tern
    :ensure t
    :after tern
    :config (add-hook 'company-mode-hook '(lambda ()
        (add-to-list 'company-backends 'company-tern)
    ))
)

(use-package js2-mode
    :ensure t
    :interpreter "node"
    :mode (("\\.js\\'" . js2-mode))
    :after company-tern
    :config (add-hook 'js2-mode-hook '(lambda ()
        ;; Indent lines using this function.
        (setq-local indent-line-function 'js-indent-line)
        (setq
            js2-basic-offset 4
            js2-highlight-level 3
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
            ;; Enable only eslint on flycheck
            flycheck-disabled-checkers (append '(
                javascript-jshint
                javascript-jscs
                javascript-standard
            ))
            flycheck-enabled-checkers (append '(
                javascript-eslint
            ))
        )
    ))
)

(use-package rjsx-mode
    :ensure t
    :after js2-mode
    :mode (("\\.jsx\\'" . rjsx-mode))
    :config (add-hook 'rjsx-mode-hook '(lambda ()
        (define-key rjsx-mode-map "<" nil); This behaviour made emacs hang, so disabled it
        (setq-local indent-line-function 'js2-jsx-indent-line)
        (setq
            sgml-basic-offset tab-width; Indent tags like everything else
            sgml-attribute-offset 0; use the same spacing as the basic offset
        )
    ))
)

(provide 'elpa-js2-mode)
;;; elpa-js2-mode.el ends here

