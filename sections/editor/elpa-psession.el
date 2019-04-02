;; Allows easier movement from window to window
(use-package psession
    :ensure t
    :config (add-hook 'after-init-hook (lambda ()
        (setq
            psession-autosave-mode t
            psession-savehist-mode t; Save minibuffer variables as well
            ;; psession-save-buffers-unwanted-buffers-regexp; TODO ignore fundamentals
            psession-elisp-objects-default-directory (
                expand-file-name "_psession" user-emacs-directory
            )
        )
        (psession-mode 1)
    ))
)

(provide 'elpa-psession)
