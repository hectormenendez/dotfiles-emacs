;; Improve default functionality for dired
(use-package dired-x
    :demand t
)

(use-package ignoramus
    :ensure t
    :config (progn
        (ignoramus-setup)
    )
)

(use-package dired+
    :quelpa (dired+ :fetcher url :url "https://www.emacswiki.org/emacs/download/dired+.el")
    :config (progn

        ;; Open iTerm in current directory using a key
        (global-set-key (kbd "M-¢") (lambda () (interactive)
            (dired-smart-shell-command "open -a iTerm $PWD" nil nil)
        ))

        ;; Add jump to current file's folder
        (add-hook 'evil-local-mode-hook (lambda ()
            (global-set-key (kbd "C-x C-j") nil);original binding
            (evil-leader/set-key "." 'dired-jump)
        ))

        (eval-after-load 'dired (lambda ()
            ;;Use evil on dired mode
            (add-hook 'evil-local-mode-hook (lambda ()
                (evil-make-overriding-map dired-mode-map 'normal t); the standard bindings
                (evil-define-key 'normal dired-mode-map
                    "gg" 'evil-goto-first-line
                    "G" 'evil-goto-line
                    "h" 'evil-backward-char
                    "j" 'evil-next-line
                    "k" 'evil-previous-line
                    "l" 'evil-forward-char
                    "w" 'evil-forward-word-begin
                    "b" 'evil-backward-word-begin
                )
            ))
        ))
        ;; reuse the dired buffer when moving between directories
        (diredp-toggle-find-file-reuse-dir 1)
    )
)

(provide 'elpa-dired+)

