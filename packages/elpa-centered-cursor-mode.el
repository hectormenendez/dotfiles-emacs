;; Keeps current line always vertically centered to the screen
(use-package centered-cursor-mode
    :ensure t
    :delight centered-cursor-mode
    :config (progn
        (define-key ccm-map [(meta v)] nil); disable keymap so it can be used elsewhere
        (centered-cursor-mode 1)
    )
)

(provide 'elpa-centered-cursor-mode)
