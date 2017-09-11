;; Autocompletion
(use-package company
    :ensure t
    :delight company-mode
    :config (add-hook 'after-init-hook 'global-company-mode)
)

(provide 'elpa-company)
