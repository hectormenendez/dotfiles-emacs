;; Log working time on wakatime.com
(if (file-exists-p "/usr/local/bin/wakatime") (use-package wakatime-mode
    :ensure t
    :delight wakatime-mode " Ϣ"
    :config (progn
        (let
            (
                (path (replace-regexp-in-string
                    "\n$"
                    ""
                    (shell-command-to-string "which wakatime")
                ))
            )
            (setq
                wakatime-cli-path path
                wakatime-python-bin path
            )
        )

        (global-wakatime-mode 1)
    )
))

(provide 'elpa-wakatime-mode)
