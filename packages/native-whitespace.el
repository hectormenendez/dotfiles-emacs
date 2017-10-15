;; Show invalid whitespaces
(use-package whitespace
    :demand t
    :delight (global-whitespace-mode)
    :config (progn
        (setq-default ;; These are core & indent vars
            ; Use 4 spaces for indentation
            tab-width 4
            c-basic-offset 4
            cperl-indent-level 4

            fill-column 90
            indent-tabs-mode nil; Use spaces for tabs
            tab-always-indent t; The tab key will always indent (duh)
            tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84)
            indent-line-function 'indent-relative
            whitespace-style '(face tabs tab-mark trailing lines-tail); Highlight these
            whitespace-line-column fill-column; Use the fill-column to mark overflowed
            whitespace-display-mappings '(; Customize the look of these character
                (tab-mark ?\t [?› ?\t])
                (newline-mark 10  [36 10])
            )
        )
        ;; I don't follow Lisp indenting guidelines, so the default indentation breaks 4me
        (add-hook 'emacs-lisp-mode-hook (lambda ()
            (setq-local indent-line-function 'indent-relative)
            (setq lisp-body-indent tab-width)
        ))
        (global-whitespace-mode 1)
    )
)

(defun etor/backspace-to-tab-stop ()
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
