;;; elpa-hl-todo.el --- Highlight TODO and NOTE in code.

;;; Commentary:

;;; Code:
(use-package hl-todo
    :ensure t
    :bind (
        ("C-c t n" . hl-todo-next)
        ("C-c t p" . hl-todo-previous)
        ("C-c C-t" . hl-todo-occur)
    )
    :config (hl-todo-mode 1)
)

(provide 'elpa-hl-todo)
;;; elpa-hl-todo.el ends here
