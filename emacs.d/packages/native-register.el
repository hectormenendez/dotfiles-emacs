;;; native-register.el --- The most basic editor configuration

;;; Commentary:

;;; Code:
(use-package register
    :demand t
    :config (progn
        ;; Define a function that allows to maximise and restore a window
        (defun etor/window-toggle ()
            "Allows to maximize current buffer"
            (interactive)
            (if (= 1 (length (window-list)))
                (jump-to-register '_)
                (progn
                    (window-configuration-to-register '_)
                    (delete-other-windows)
                )
            )
        )
        (add-hook 'evil-leader-mode-hook '(lambda ()
            (evil-leader/set-key "wW" 'etor/window-toggle)
        ))
    )
)

(provide 'native-register)
;;; native-register.el ends here
