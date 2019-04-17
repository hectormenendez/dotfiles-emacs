(use-package alchemist
    :ensure t
    :after elixir-mode
    :delight alchemist-mode "α"
    :config (add-hook 'elixir-mode-hook (lambda ()
        (setq
            alchemist-mix-command "/usr/local/bin/mix"; Use locally installed mix
            alchemist-key-command-prefix (kbd "C-x x"); Default C-c a
            alchemist-test-display-compilation-output t
            alchemist-test-truncate-lines nil
            alchemist-hooks-test-on-save nil
            alchemist-hooks-compile-on-save nil
        )
    ))
)

(use-package elixir-mode
    :ensure t
    :mode (
        ("\\.ex\\'" . elixir-mode)
        ("\\.exs\\'" . elixir-mode)
    )
)

(provide 'elpa-elixir-mode)
