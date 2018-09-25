;; Enable Json mode
(use-package graphql-mode
    :ensure t
    :config (progn
        (setq-default graphql-indent-level 4)
    )
    :mode (
        ("\\.gql\\'" . graphql-mode)
        ("\\.graphql\\'" . graphql-mode)
    )
)

(provide 'elpa-graphql-mode)
