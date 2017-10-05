;;; elpa-dumb-jump.el --- Simple jump-to-definition

;;; Commentary:

;;; Code:
(use-package dumb-jump
    :ensure t
    :init (add-hook 'evil-local-mode-hook (lambda ()
        ;; Key bindings for evil-mode
        (evil-leader/set-key "jj" 'dumb-jump-go)
        (evil-leader/set-key "jJ" 'dumb-jump-back)
    ))
    :config (add-hook 'prog-mode-hook (lambda ()
        (setq-default
            dumb-jump-prefer-searcher 'ag
            dumb-jump-selector 'helm
        )
        (dumb-jump-mode 1)
    ))
)

(provide 'elpa-dumb-jump)
;;; elpa-dumb-jump.el ends here
