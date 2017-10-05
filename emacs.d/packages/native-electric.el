;; Automate behaviour
(use-package electric
    :demand t
    :config (progn
        (setq-default electric-indent-mode 1)
        (setq-default electric-quote-mode 1)
        (setq-default electric-pair-mode 1)
    )
)

(provide 'native-electric)
