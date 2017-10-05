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
    :config (progn

        (add-hook 'after-init-hook (lambda ()
            ;; Enable helm-projectile
            (define-key global-map [(meta f)] 'helm-projectile); forward-word
            ;; Enable finding directories
            (define-key global-map [(meta shift f)] 'helm-projectile-find-dir)
            ;; Enable finding buffers
            (define-key global-map (kbd "M-b") 'helm-projectile-switch-to-buffer); orig: backward-char
            ;; Enable finding projects
            (define-key global-map (kbd "M-p") 'helm-projectile-switch-project);
        ))

        (eval-after-load 'evil-maps (lambda ()
            (define-key evil-normal-state-map (kbd "C-f") nil)
            (define-key evil-emacs-state-map (kbd "C-f") nil)
            (define-key evil-motion-state-map (kbd "C-f") nil)
            (define-key evil-operator-state-map (kbd "C-f") nil)
            (define-key evil-visual-state-map (kbd "C-f") nil)
            (define-key evil-replace-state-map (kbd "C-f") nil)
            (define-key global-map [(ctrl f)] 'helm-projectile-ag)
            (define-key global-map [(ctrl shift f)] 'projectile-replace-regexp)
        ))
    )
)

(provide 'elpa-projectile)

