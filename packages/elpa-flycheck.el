;;; elpa-flycheck.el --- Enable syntax checking

;;; Commentary:

;;; Code:
(use-package flycheck
    :ensure t
    :config (progn
        (add-hook 'prog-mode-hook (lambda ()
            (setq
                flycheck-temp-prefix ".flycheck"
                flycheck-mode-line-prefix " ✖︎"
                flycheck-emacs-lisp-load-path 'inherit; let flycheck know Emacs' loadpath
                flycheck-check-syntax-automatically '(save mode-enabled)
            )
            (flycheck-mode 1)
        ))
        (add-hook 'flycheck-mode-hook 'etor/flycheck-eslint-from-project)
    )
)

(defun etor/flycheck-eslint-from-project ()
    "When there's a local eslint available, use it instead of the global one."
    (let*
        (
            (root
                (locate-dominating-file
                    (or (buffer-file-name) default-directory)
                    "node_modules"
                )
            )
            (eslint
                (and root (expand-file-name "node_modules/.bin/eslint" root))
            )
        )
        (when (and eslint (file-executable-p eslint))
            (setq-local flycheck-javascript-eslint-executable eslint)
        )
    )
)

(provide 'elpa-flycheck)
;;; elpa-flycheck.el ends here
