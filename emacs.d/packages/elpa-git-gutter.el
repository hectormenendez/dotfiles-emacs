;;; elpa-git-gitter.el --- Adds a gutter with the git status of each line

;;; Commentary:

;;; Code:
(use-package git-gutter
    :ensure t
    :delight git-gutter-mode
    :config (add-hook 'prog-mode-hook (lambda ()
        (setq
            git-gutter:update-interval 2; Update git gutter after n secs idle
            git-gutter:ask-p nil; Don't ask confirmation when committing or reverting
        )
        (add-to-list 'git-gutter:update-hooks 'git-gutter-mode-hook)
        (add-to-list 'git-gutter:update-hooks 'git-gutter:post-command-hook)
        (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
        (add-to-list 'git-gutter:update-hooks 'magit-post-display-buffer-hook)
        (add-to-list 'git-gutter:update-hooks 'magit-post-refresh-hook)
        (add-to-list 'git-gutter:update-hooks 'after-save-hook)
        (git-gutter:linum-setup); play along with linum-mode
        (global-git-gutter-mode 1)
    ))
)

(provide 'elpa-git-gutter)
;;; elpa-git-gutter.el ends here
