;;; elpa-highlight-quoted.el --- Highlight lisp-quotes

;;; Commentary:
;;; What? no highlighted quotes for Lisp? c'mon man!

;;; Code:
(use-package highlight-quoted
    :ensure t
    :delight highlight-quoted-mode
    :config (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode)
)

(provide 'elpa-highlight-quoted)
;;; elpa-highlight-quoted.el  ends here
