;;; elpa-rainbow-mode.el --- Show actual colors on color names.

;;; Commentary:

;;; Code:
(use-package rainbow-mode
    :ensure t
    :delight rainbow-mode
    :if window-system
    :config (add-hook 'prog-mode-hook '(lambda ()
        (rainbow-mode 1)
    ))
)

(provide 'elpa-rainbow-mode)
;;; elpa-rainbow-mode.el  ends here
