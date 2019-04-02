;;; native-line-numbers.el --- Display line numbers only in progmode.

;;; Commentary:
;;;

;;; Code:
(use-package display-line-numbers
    :demand t
    :config (add-hook 'prog-mode-hook (lambda ()
        (setq
            display-line-numbers "%4d \u2502 "
            display-line-numbers-type 'relative
        )
        (display-line-numbers-mode t)
    ))
)

(provide 'native-line-numbers)

;;; native-line-numbers
