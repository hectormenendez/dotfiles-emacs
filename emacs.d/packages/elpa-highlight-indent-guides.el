;;; elpa-highlight-indent-guides.el --- Show a line on indentation

;;; Commentary:

;;; Code:
(use-package highlight-indent-guides
    :ensure t
    :delight highlight-indent-guides-mode
    :config (progn
        (setq
            highlight-indent-guides-method 'character
            ;; My theme is setting the color, don't calculate it.
            highlight-indent-guides-auto-enabled nil
        )
        (highlight-indent-guides-mode 1)
    )
)

(provide 'elpa-highlight-indent-guides)
;;; elpa-highlight-indent-guides.el ends here
