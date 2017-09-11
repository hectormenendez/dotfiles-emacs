;;; elpa-flycheck.el --- Enable syntax checking

;;; Commentary:

;;; Code:
(use-package flycheck
    :ensure t
    :config (add-hook 'prog-mode-hook (lambda ()
        (setq
            flycheck-disabled-checkers (append '(
                javascript-jshint
                javascript-jscs
                javascript-standard
            ))
            flycheck-temp-prefix ".flycheck"
            flycheck-mode-line-prefix " ✖︎"
        )
        (flycheck-mode 1)
    ))
)

(provide 'elpa-flycheck)
;;; elpa-flycheck.el ends here
