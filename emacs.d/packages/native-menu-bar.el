;;; native-menu-bar.el --- Customise the shortcuts on the menubar.

;;; Commentary:

;;; Code:

(use-package menu-bar
    :demand t
    :config (progn

        ;; File > Close
        (define-key global-map (kbd "M-w") 'kill-this-buffer)

        ;; File > Save
        (define-key global-map (kbd "C-x C-s") nil)
        (define-key global-map (kbd "M-s") 'save-buffer); orig: isearch prefix

        ;; File > Save As ...
        (define-key global-map (kbd "C-x C-w") nil)
        (define-key global-map (kbd "M-S") 'write-file); orig: same as M-s

        ;; File > Quit
        (define-key global-map (kbd "C-x C-c") nil)
        (define-key global-map (kbd "M-q") 'save-buffers-kill-terminal); orig: fill-paragraph

        ;; Edit > Undo
        (define-key global-map (kbd "C-_") nil)
        (define-key global-map (kbd "M-z") 'undo-tree-undo); orig: zap-to-char

        ;; Edit > Undo
        (define-key global-map (kbd "M-_") nil)
        (define-key global-map (kbd "M-Z") 'undo-tree-redo); orig: same as M-z
    )
)

(provide 'native-menu-bar)

;;; native-menu-bar.el ends here
