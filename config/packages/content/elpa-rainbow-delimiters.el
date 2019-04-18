;;; elpa-rainbow-delimiters.el --- Use different colors for parenthesis to ease matching

;;; Commentary:

;;; Code:

(use-package rainbow-delimiters
    :ensure t
    :config (add-hook 'prog-mode-hook (lambda ()
        (rainbow-delimiters-mode 1)
    ))
)

(provide 'elpa-rainbow-delimiters)
;;; elpa-rainbow-delimiters.el  ends here
