;;; elpa-fill-column-indicator.el --- Show a line on the fill-column character.

;;; Commentary:

;;; Code:
(use-package fill-column-indicator
    :ensure t
    :delight fci-mode
    :config (add-hook 'prog-mode-hook (lambda ()
        (setq fci-rule-width 1)
        (turn-on-fci-mode)
    )
))

(provide 'elpa-fill-column-indicator)
;;; elpa-fill-column-indicator ends here
