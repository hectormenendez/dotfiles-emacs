;; Workspace management via perspectives
(use-package persp-mode
    :ensure t
    :delight persp-mode
    :config (progn

        (add-hook 'evil-leader-mode-hook (lambda ()
            (evil-leader/set-key "TAB" 'persp-switch);; quick perspective switch
        ))

        (add-hook 'after-init-hook (lambda ()
            (define-key global-map (kbd "M-B") 'persp-kill-buffer)
            ;; always kill buffer using persp-mode
            (substitute-key-definition 'kill-buffer 'persp-kill-buffer global-map)
            ;; Load the last-saved perspective state
            ;; NOTE: The persp-auto-resume-time, not always work, this does.
            (persp-load-state-from-file
                (expand-file-name persp-auto-save-fname persp-save-dir)
            )
        ))

        (setq
            persp-autokill-buffer-on-remove 'kill ; kill the buffer when closed
            persp-nil-name "nil"; The name of the default perspective
            persp-save-dir (expand-file-name "_perspectives/" user-emacs-directory)
            persp-auto-save-fname "persp-autosave"
            persp-set-last-persp-for-new-frames nil; don't use last persp for new frames
            persp-switch-to-added-buffer nil; don't switch window to new buffers
            persp-auto-save-opt 1; Auto-save perspective on buffer kill
            persp-auto-resume-time -1; Don't auto resume perspective on startup
            persp-nil-hidden t; hide the nil perspective
        )

        (persp-mode 1)
    )
)

(provide 'elpa-persp-mode)
