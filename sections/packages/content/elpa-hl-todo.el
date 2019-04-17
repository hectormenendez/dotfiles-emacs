;;; elpa-hl-todo.el --- Highlights:
;;; HOLD PROG OKAY NOTE KLUDGE TODO NEXT THEM DONT DONE HACK FIXME XXX XXXX ???

;;; Commentary:

;;; Code:
(use-package hl-todo
    :ensure t
    :config (add-hook 'prog-mode-hook (lambda ()
        (hl-todo-mode 1)
        ;; TODO: Set evil leader bindings for this.

        ;; :bind (
        ;;     ("C-c t n" . hl-todo-next)
        ;;     ("C-c t p" . hl-todo-previous)
        ;;     ("C-c C-t" . hl-todo-occur)
        ;; )
    ))
)

(provide 'elpa-hl-todo)
;;; elpa-hl-todo.el ends here
