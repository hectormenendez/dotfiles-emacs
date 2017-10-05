;; Autocompletion
(use-package company
    :ensure t
    :delight company-mode
    :config (progn
        (setq
            ;; Whenever you type two letters show a possible completion
            company-idle-delay 0
            company-minimum-prefix-length 2

            company-auto-complete nil; Don't automatically auto-complete.
            company-tooltip-limit 20; The max number of candidates to show
            company-tooltip-align-annotations t; Align  annotations to the right side
        )
        (add-hook 'after-init-hook 'global-company-mode)
    )
)

(provide 'elpa-company)
