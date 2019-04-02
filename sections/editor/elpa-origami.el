;; Smart region seletion
(use-package origami
    :ensure t
    :config (add-hook 'prog-mode-hook 'origami-mode)
)

;; Enable folding
(use-package evil-vimish-fold
    :ensure t
    :after origami
    :config (progn
        (add-hook 'origami-mode-hook 'evil-vimish-fold-mode)
        (setq vimish-fold-dir (expand-file-name "_vimish-fold/" user-emacs-directory))
    )
)

(provide 'elpa-origami)
