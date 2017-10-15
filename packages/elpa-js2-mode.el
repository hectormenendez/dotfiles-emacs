;;; elpa-js2-mode.el --- Javascript bindings

;;; Commentary:

;;; Code:

(use-package tern
    ;; Enable tern
    :ensure t
    :config (add-hook 'js2-mode-hook (lambda ()

        (setq tern-flash-timeout 30); Wait 30 seconds before removing the function helper
        (tern-mode 1)
    ))
)

(use-package company-tern
    ;; Add tern to copany backends.
    :ensure t
    :after tern
    :config (add-hook 'js2-mode-hook (lambda ()
        (add-to-list 'company-backends 'company-tern)
    ))
)

(use-package js2-highlight-vars
    :ensure t
    :after js2-mode
)

(use-package js2-mode
    :ensure t
    :after company-tern
    :interpreter "node"
    :mode (("\\.js\\'" . js2-mode))
    :config (progn
        (add-hook 'flycheck-mode-hook (lambda () (setq-default
            ;; Enable only eslint on flycheck
            flycheck-disabled-checkers (append '(
                javascript-jshint
                javascript-jscs
                javascript-standard
            ))
            flycheck-enabled-checkers (append '(
                javascript-eslint
            ))
        )))
        (add-hook 'js2-mode-hook (lambda ()
            (setq
                js2-highlight-level 3; Add syntax highlighting to everything
                js2-include-browser-externs t
                js2-include-node-externs t
                js2-mode-show-overlay t

                ;; let flycheck handle warnings and errors
                js2-mode-show-parse-errors nil
                js2-mode-show-strict-warnings nil
                js2-warn-about-unused-function-arguments t
            )

            ;; I don't follow strict rules for indentation so
            ;; until I find a better way to customize the indentation I'll settle with this.
            (electric-indent-local-mode -1)
            (setq-local indent-line-function 'indent-relative-maybe)

            ;; Highlight matching vars
            (js2-highlight-vars-mode 1)
        ))
    )
)

(use-package rjsx-mode
    :ensure t
    :after js2-mode
    :mode (("\\.jsx\\'" . rjsx-mode))
    :config (add-hook 'rjsx-mode-hook (lambda ()
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
