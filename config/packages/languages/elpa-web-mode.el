(use-package web-mode
    :ensure t
    :mode (
        ("\\.hbs\\'" . web-mode)
        ("\\.html\\'" . web-mode)
        ("\\.svg\\'" . web-mode)
    )
    :config (add-hook 'web-mode-hook (lambda ()
        (setq-default indent-tabs-mode nil);; fixes issues with whitespaces
        (setq
            ;; highlight JSX inline
            ;; web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))
            ;; make sure indentation inherits
            web-mode-attr-indent-offset standard-indent
            web-mode-attr-value-indent-offset standard-indent
            web-mode-markup-indent-offset standard-indent
            web-mode-css-indent-offset standard-indent
            web-mode-code-indent-offset standard-indent
            web-mode-sql-font-lock-keywords standard-indent
            web-mode-enable-engine-detection t
            web-mode-enable-css-colorization t
            web-mode-enable-comment-interpolation t; highlight keywords like TODO
            web-mode-enable-comment-annotation nil
            web-mode-enable-current-element-highlight t
            web-mode-enable-current-column-highlight t

            web-mode-enable-control-block-indentation t
            web-mode-enable-auto-indentation t
            web-mode-enable-auto-closing t
            web-mode-enable-auto-pairing t
            web-mode-enable-auto-opening t
            web-mode-enable-auto-quoting t
            web-mode-enable-auto-expanding nil; if true, type s/ -> <spand></spand>

            web-mode-comment-style 1

            web-mode-block-padding standard-indent
            web-mode-part-padding standard-indent
            web-mode-script-padding standard-indent
            web-mode-style-padding standard-indent
        )
    ))
)

(provide 'elpa-web-mode)
