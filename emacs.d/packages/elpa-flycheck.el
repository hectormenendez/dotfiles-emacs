;;; elpa-flycheck.el --- Enable syntax checking

;;; Commentary:

;;; Code:
(use-package flycheck
    :ensure t
    :config (progn
        (setq
            flycheck-disabled-checkers (append '(
                javascript-jshint
                javascript-jscs
                javascript-standard
            ))
            flycheck-temp-prefix ".flycheck"
            flycheck-mode-line-prefix " ✖︎"
        )
        (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
        (flycheck-add-mode 'javascript-eslint 'js2-mode)
        (global-flycheck-mode 1)
    )
)

(provide 'elpa-flycheck)
;;; elpa-flycheck.el ends here
