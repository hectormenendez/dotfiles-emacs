;; Enable better handling of xml files (not need of ensuring, it's already included)
(use-package nxml-mode
    :defer t
    :mode (
        ("\\.plist\\'" . nxml-mode)
        ("\\.svg\\'" . nxml-mode)
        ("\\.xml\\'" . nxml-mode)
        ("\\.xslt\\'" . nxml-mode)
        ("\\.html\\'" . nxml-mode)
    )
    :config (progn
        (add-hook 'nxml-mode-hook (lambda ()
            (linum-mode 1)
        ))
        (setq
            magic-mode-alist (cons '("<\\?xml " . nxml-mode) magic-mode-alist)
            nxml-slash-auto-complete-flag t
            nxml-auto-insert-xml-declaration-flag t
            nxml-child-indent 4
        )
        (fset 'xml-mode 'nxml-mode)
    )
)

(provide 'elpa-nxml-mode)
