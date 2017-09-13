;; Quick switching files
(use-package projectile
    :ensure t
    :delight projectile-mode
    :config (progn

        (setq projectile-cache-file
            (expand-file-name "_projectile/cache" user-emacs-directory)
        )

        (setq projectile-known-projects-file
            (expand-file-name "_projectile/known_projects" user-emacs-directory)
        )

        (projectile-mode 1)
    )
)

;; Enable helm-projectile-integration
(use-package helm-projectile
    :ensure t
    :after (helm projectile)
    :config (add-hook 'after-init-hook (lambda ()
        ;; make C-/ trigger helm-ag instead of undo-tree's undo
        (define-key global-map (kbd "C-/") 'helm-projectile-ag); undo-tree-undo
        ;; Enable helm-projectile
        (define-key global-map (kbd "M-f") 'helm-projectile); forward-word
        ;; Enable finding directories
        (define-key global-map (kbd "M-F") 'helm-projectile-find-dir)
        ;; Enable finding buffers
        (define-key global-map (kbd "M-b") 'helm-projectile-switch-to-buffer); orig: backward-char
        ;; Enable finding projects
        (define-key global-map (kbd "M-p") 'helm-projectile-switch-project)
    ))
)

(provide 'elpa-projectile)

