(use-package web-mode
    :ensure t
    :mode (
        ("\\.hbs\\'" . web-mode)
        ("\\.html\\'" . web-mode)
        ("\\.svg\\'" . web-mode)
    )
)

(provide 'elpa-web-mode)
