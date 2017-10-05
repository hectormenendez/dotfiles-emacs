;; Show invalid whitespaces
(use-package whitespace
    :demand t
    :delight (global-whitespace-mode)
    :config (progn
        (setq-default ;; These are core & indent vars
            fill-column 90
            tab-width 4; Use 4 spaces for indentation
            indent-tabs-mode nil; Use spaces for tabs
            tab-always-indent t; The tab key will always indent (duh)
            tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84)
            indent-line-function 'insert-tab; insert a tab after each RET
            whitespace-style '(face tabs tab-mark trailing lines-tail); Highlight these
            whitespace-line-column fill-column; Use the fill-column to mark overflowed
            whitespace-display-mappings '(; Customize the look of these character
                (tab-mark ?\t [?› ?\t])
                (newline-mark 10  [36 10])
            )
        )
        (defvaralias 'c-basic-offset 'tab-width)
        (defvaralias 'cperl-indent-level 'tab-width)
        ;; I don't like the default indent funtion for elisp, disable it.
        (add-hook 'emacs-lisp-mode-hook '(lambda ()
            (setq-local indent-line-function 'indent-relative)
        ))
        (global-whitespace-mode 1)
    )
)

(defun my/backspace-to-tab-stop ()
    "Delete whitespace backwards to the next tab-stop, otherwise delete one character."
    (interactive)
    (if
        (or indent-tabs-mode
            (region-active-p)
            (save-excursion
                (> (point) (progn (back-to-indentation) (point)))
            ))
        (call-interactively 'backward-delete-char-untabify)
        (let
            ((movement (% (current-column) tab-width)) (p (point)))
            (when (= movement 0) (setq movement tab-width))
            ;; Account for edge case near beginning of buffer
            (setq movement (min (- p 1) movement))
            (save-match-data
                (if
                    (string-match "[^\t ]*\\([\t ]+\\)$"
                        (buffer-substring-no-properties (- p movement) p)
                    )
                    (backward-delete-char (- (match-end 1) (match-beginning 1)))
                    (call-interactively 'backward-delete-char)
                )
            )
        )
    )
)

(provide 'native-whitespace)
