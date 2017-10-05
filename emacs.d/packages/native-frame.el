;;; native-frame.el --- Customize frame behaviour (only when in GUI mode)

;;; Commentary:
;;; TODO: framesave load and save should be a plugin

;;; Code:
(use-package frame
    :if window-system
    :bind (
        ("M-RET" . toggle-frame-fullscreen)
    )
    :config (progn

        (add-hook 'after-init-hook (lambda ()
            "Load last frame geometry from a a file."
            (let
                (
                    (framesave-file (expand-file-name "_framesave" user-emacs-directory))
                )
                (when (file-readable-p framesave-file) (load-file framesave-file))
            )
        ))

        (add-hook 'kill-emacs-hook (lambda ()
            "Save current frame geometry to a file."
            (let
                (
                    (framesave-left (frame-parameter (selected-frame) 'left))
                    (framesave-top (frame-parameter (selected-frame) 'top))
                    (framesave-width (frame-parameter (selected-frame) 'width))
                    (framesave-height (frame-parameter (selected-frame) 'height))
                    (framesave-file (expand-file-name "_framesave" user-emacs-directory))
                )
                (when (not (number-or-marker-p framesave-left)) (setq framesave-left 0))
                (when (not (number-or-marker-p framesave-top)) (setq framesave-top 0))
                (when (not (number-or-marker-p framesave-width)) (setq framesave-width 0))
                (when (not (number-or-marker-p framesave-height)) (setq framesave-height 0))
                (with-temp-buffer
                    (insert
                        "(setq initial-frame-alist '(\n"
                        (format "    (top . %d)\n" (max framesave-top 0))
                        (format "    (left . %d)\n" (max framesave-left 0))
                        (format "    (width . %d)\n" (max framesave-width 0))
                        (format "    (height . %d)\n" (max framesave-height 0))
                        "))\n"
                    )
                    (when (file-writable-p framesave-file) (write-file framesave-file))
                )
            )
        ))
        (setq frame-title-format "emacs")
        (tool-bar-mode -1); Don't show the toolbar
        (scroll-bar-mode -1); Don't show the scrollbar
    )
)

(provide 'native-frame)
;;; native-frame.el ends here
