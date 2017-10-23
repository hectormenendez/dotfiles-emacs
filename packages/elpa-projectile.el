;; Quick switching files
(use-package projectile
    :ensure t
    :delight projectile-mode
    :init (defvar etor/projectile-dir
        (expand-file-name "_projectile/" user-emacs-directory)
    )
    :config (progn

        ;; If the projectile folder doesn't exist, create it.
        (unless
            (file-exists-p etor/projectile-dir)
            (make-directory etor/projectile-dir)
        )

        (setq
            ;; use external tools for indexing for speed
            projectile-indexing-method 'alien
            ;; Setup custom filenames for autosaving.
            projectile-cache-file
                (expand-file-name "cache" etor/projectile-dir)
            projectile-known-projects-file
                (expand-file-name "known_projects" etor/projectile-dir)
        )
        (setq projectile-project-root-files-functions '(
            projectile-root-local
            projectile-root-top-down
            projectile-root-bottom-up
        ))


        ;; TODO: These aren't working grea,t, how about moving the to persp-mode hooks?
        ;; Everytime the project is changed, remove/restore projects
        (add-hook 'projectile-before-switch-project-hook (lambda ()
            (etor/projectile-buffers-save)
        ))
        (add-hook 'projectile-after-switch-project-hook (lambda ()
            (etor/projectile-buffers-load)
            (etor/projectile-buffers-kill)
        ))

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

        ;; work along with projectile
        (setq projectile-switch-project-action 'projectile-find-file)
    )
)


(defun etor/projectile-buffers-savefile ()
    "Retrieve the location for the sevefile."
    (expand-file-name
        (replace-regexp-in-string "/" "#" (projectile-project-root))
        etor/projectile-dir
    )
)

(defun etor/projectile-buffers-load ()
    "Load previously open buffers from a file."
    (interactive)
    (let
        (
            (savefile (etor/projectile-buffers-savefile))
        )
        (when
            (file-exists-p savefile)
            (with-temp-buffer
                (insert-file-contents savefile)
                (let
                    (
                        (paths (read (buffer-string)))
                        (buffers (remove nil (mapcar
                            (lambda (buffer) (buffer-file-name buffer))
                            (buffer-list (selected-frame))
                        )))
                    )
                    (dolist
                        (path paths)
                        (when
                            (and
                                (file-exists-p path)
                                (not (member path buffers))
                            )
                            (find-file path)
                        )
                    )
                )
            )
        )
    )
)

(defun etor/projectile-buffers-save ()
    "Save currently open buffers to a file."
    (interactive)
    (let
        (
            (savefile (etor/projectile-buffers-savefile))
            (buffers (buffer-list (selected-frame)))
            (results '())
        )
        (dolist
            (buffer buffers)
            (let
                (
                    (path (buffer-file-name buffer))
                )
                (unless (not path) (add-to-list 'results path))
            )
        )
        (when
            (file-writable-p savefile)
            (with-temp-file savefile
                (insert (let (print-length) (prin1-to-string results)))
                (write-file savefile)
            )
        )
    )
)

(defun etor/projectile-buffers-kill ()
    "Kill buffers that don't belong to a projectile project."
    (interactive)
    (let
        (
            (buffers (buffer-list (selected-frame)))
            (curproj (projectile-project-p))
        )
        (dolist (buffer buffers) (with-current-buffer buffer
            (let
                (
                    (name (buffer-name buffer))
                )
                (when
                    (not (eq curproj (projectile-project-p)))
                    (unless (string-match "^\s*\\*\\\(Messages\\|scratch\\\)" name)
                        (message "projectile-buffers-kill: %s" name)
                        (kill-buffer name)
                    )
                )
            )
        ))
    )
)
(provide 'elpa-projectile)

