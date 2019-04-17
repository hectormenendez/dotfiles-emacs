;; Quick switching files

(defun etor/projectile-buffers-get-filename ()
    "Retrieve the location for the sevefile."
    (expand-file-name
        (replace-regexp-in-string "/" "#" (projectile-project-root))
        etor/projectile-dir
    )
)

(defun etor/projectile-buffers-save-and-kill ()
    "Save currently open buffers to a file."
    (interactive)
    (let
        (
            (_savefile (etor/projectile-buffers-get-filename))
            (_filenames (list (buffer-file-name (current-buffer))))
        )
        (dolist (buffer (buffer-list))
            (let
                (
                    (_path (buffer-file-name buffer))
                    (_name (buffer-name buffer))
                )
                (when (and (not (string-match-p "^\\\s*\\*" _name)) _path)
                    (add-to-list '_filenames _path)
                )
            )
        )
        (if (file-writable-p _savefile)
            (with-temp-file _savefile
                (insert (let (print-length) (prin1-to-string _filenames)))
                (write-file _savefile)
            )
            (error "Could not write to projectile savefile")
        )
        (desktop-clear)
        (print (concat "Saved " (number-to-string (length _filenames)) " buffers."))
    )
)

(defun etor/projectile-buffers-load ()
    "Load previously open buffers from a file."
    (interactive)
    (let
        (
            (_currname (buffer-file-name (current-buffer)))
            (_filename (etor/projectile-buffers-get-filename))
        )
        (when (file-exists-p _filename)
            (with-temp-buffer (insert-file-contents _filename)
                (dolist (_path (read (buffer-string)))
                    (when (file-exists-p _path) (find-file _path))
                )
                (find-file _currname)
            )
        )
    )
)

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
            ;; ignore these folders when trying to add as project
            projectile-ignored-project-function (lambda (project-root)
                (f-descendant-of? project-root (expand-file-name ".git"))
            )
        )
        (setq projectile-project-root-files-functions '(
            projectile-root-local
            projectile-root-top-down
            projectile-root-bottom-up
        ))

        ;; Everytime the project is changed, remove/restore projects
        (add-hook 'projectile-before-switch-project-hook 'etor/projectile-buffers-save-and-kill)
        (add-hook 'projectile-after-switch-project-hook 'etor/projectile-buffers-load)

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
            (define-key global-map [(meta f)] 'helm-projectile-find-file); forward-word
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
            (define-key global-map [(ctrl f)] 'helm-do-ag)
            (define-key global-map [(ctrl shift f)] 'projectile-replace-regexp)
        ))

        ;; work along with projectile
        (setq projectile-switch-project-action 'projectile-find-file)
    )
)

(provide 'elpa-projectile)

