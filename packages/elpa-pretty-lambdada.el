;;; elpa-pretty-lambdada.el --- Replace the word lambda with a symbol.

;;; Commentary:

;;; Code:
(use-package pretty-lambdada
    :ensure t
    :config (add-hook 'prog-mode-hook (lambda ()
        (pretty-lambda-mode t)
    ))
)

(provide 'elpa-pretty-lambdada)
;;; elpa-pretty-lambdada.el ends here

