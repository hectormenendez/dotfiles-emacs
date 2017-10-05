;;; elpa-dtrt-indent.el --- Guess file indentation and set emacs to follow it
;;; Commentary:

;;; Code:
(use-package dtrt-indent
    :ensure t
    :delight dtrt-indent-mode " [dtrt] "
    :config (add-hook 'prog-mode-hook '(lambda ()
        (dtrt-indent-mode 1)
    ))
)

(provide 'elpa-dtrt-indent)
;;; elpa-dtrt-indent.el ends here
