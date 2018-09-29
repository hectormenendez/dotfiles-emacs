;; Workspace management via perspectives
(use-package persp-mode
    :ensure t
    :delight persp-mode
    :config (progn

        (setq
            persp-autokill-buffer-on-remove 'kill ; kill the buffer when closed
            persp-kill-foreign-buffer-behaviour 'kill ; don't ask for confirmation
            persp-remove-buffers-from-nil-persp-behaviour 'kill
            persp-nil-name "none"; The name of the default perspective
            persp-save-dir (expand-file-name "_persp/" user-emacs-directory)
            persp-switch-to-added-buffer nil; don't switch window when new buffers added
            persp-auto-save-opt 1; Auto save only if persp-mode is active when exiting.
            persp-auto-resume-time 1; how many secs to wait before resuming? <=0 no resume
            persp-nil-hidden nil; set to true to hide the "nil" perspective
            persp-set-last-persp-for-new-frames t; always use current persp on new frames
        )

        (add-hook 'evil-leader-mode-hook (lambda ()
            (evil-leader/set-key "TAB" 'persp-switch);; quick perspective switch
            ;; always kill buffer using persp-mode
            (define-key global-map (kbd "M-B") 'persp-kill-buffer)
            (substitute-key-definition 'kill-buffer 'persp-kill-buffer global-map)
        ))

        (add-hook 'after-init-hook (lambda ()
            (persp-mode 1)
            ;; Load the last-saved perspective state
            ;; NOTE: The persp-auto-resume-time, not always work, this does.
            (persp-load-state-from-file
                (expand-file-name persp-auto-save-fname persp-save-dir)
            )
        ))

    )
)

(provide 'elpa-persp-mode)
