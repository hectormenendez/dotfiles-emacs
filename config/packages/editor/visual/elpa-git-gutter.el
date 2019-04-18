;;; elpa-git-gitter.el --- Adds a gutter with the git status of each line

;;; Commentary:

;;; Code:
(use-package git-gutter
    :ensure t
    :delight git-gutter-mode
    :config (add-hook 'display-line-numbers-mode-hook (lambda ()
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
        (global-git-gutter-mode t)
        ;; TODO: this should be set on evil leader mode hook
        ;; (evil-leader/set-key "g+" 'git-gutter:stage-hunk)
        ;; (evil-leader/set-key "g-" 'git-gutter:revert-hunk)
        ;; (evil-leader/set-key "g}" 'git-gutter:next-hunk)
        ;; (evil-leader/set-key "g{" 'git-gutter:previous-hunk)
    ))
)

(provide 'elpa-git-gutter)
;;; elpa-git-gutter.el ends here
