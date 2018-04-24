;;; elpa-linum-relative.el --- Show (relative) line numbers in gutter.

;;; Commentary:

;;; Code:
(use-package linum-relative
    :ensure t
    :delight linum-relative-mode
    :config (add-hook 'prog-mode-hook (lambda ()
        (setq
            linum-relative-current-symbol ""; Show the current line-number
            linum-relative-format " %3s"; Add some spaces to numbers
            linum-relative-backend 'display-line-number-mode
        )
        (linum-relative-on)
    ))
)

(provide 'elpa-linum-relative)
;;; elpa-linum-relative.el ends here
