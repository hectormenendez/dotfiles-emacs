;;; elpa-highlight-numbers.el --- Highlight numerical entities on code.

;;; Commentary:
;;; Wait what? numbers don't get a highlight on Emacs? c'mon man!

;;; Code:
(use-package highlight-numbers
    :ensure t
    :delight highlight-numbers-mode
    :config (add-hook 'prog-mode-hook '(lambda ()
        (highlight-numbers-mode 1)
    ))
)

(provide 'elpa-highlight-numbers)
;;; elpa-highlight-numbers.el  ends here
