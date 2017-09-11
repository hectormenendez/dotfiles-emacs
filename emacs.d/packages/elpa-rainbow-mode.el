;;; elpa-rainbow-mode.el --- Show actual colors on color names.

;;; Commentary:

;;; Code:
(use-package rainbow-mode
    :ensure t
    :if window-system
    :config (rainbow-mode 1)
)

(provide 'elpa-rainbow-mode)
;;; elpa-rainbow-mode.el  ends here
