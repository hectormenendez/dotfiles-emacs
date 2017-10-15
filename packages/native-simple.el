;;; native-simple.el --- The most basic editor configuration

;;; Commentary:

;;; Code:
(use-package simple
    :demand t
    :config (progn

        ;; the location for auto-save files
        (setq auto-save-list-file-prefix
            (expand-file-name "_auto-save-list/" user-emacs-directory)
        )

        (auto-save-mode 1); Enable auto saving files
        (column-number-mode 1); Show the current-column number
        (global-hl-line-mode 1); Highlight the current line
    )
)

(provide 'native-simple)
;;; native-simple.el ends here
