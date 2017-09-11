;;; elpa-smartparens.el --- Automatically open pairs of parens

;;; Commentary:

;;; Code:
(use-package smartparens
    :ensure t
    :delight smartparens-mode
    :config (progn
        (require 'smartparens-config); Enable the default config
        (smartparens-mode 1)
    )
)

(provide 'elpa-smartparens)
;;; elpa-smartparens.el ends here
