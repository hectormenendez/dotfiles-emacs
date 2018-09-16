;; Customisations (mostly themes)
(use-package custom
    :demand t
    :init (defvar etor/themes-dir
        (expand-file-name "_themes" user-emacs-directory)
    )
    :config (progn
        (setq
            custom-safe-themes t; Don't ask for confirmations when loading themes
            ;; Save customisations to this file
            custom-file (expand-file-name "_custom.el" user-emacs-directory)
        )

        ;; If the theme folder doesn't exist, create it and then enable it.
        (unless
            (file-exists-p etor/themes-dir)
            (make-directory etor/themes-dir)
        )
        (add-to-list 'custom-theme-load-path etor/themes-dir)

        ;; if the custom file doesn't exist, create it.
        (unless (file-exists-p custom-file) (write-region "" nil custom-file))
        (load custom-file)


    )
)

(provide 'native-custom)
