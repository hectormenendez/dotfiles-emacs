;; Automate behaviour
(use-package aggressive-indent
    :ensure t
    :init (setq-default electric-indent-mode 1)
    :config (progn
        (setq aggressive-indent-excluded-modes (append '(
            emacs-lisp-mode
        )))
        (add-hook 'prog-mode-hook 'aggressive-indent-mode)
        (add-hook 'emacs-lisp-mode-hook (lambda () (aggressive-indent-mode -1)))
    )
)

(provide 'elpa-aggressive-indent)
