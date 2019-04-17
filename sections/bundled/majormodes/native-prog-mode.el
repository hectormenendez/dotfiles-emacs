;; ;; Don't knwo why, but the indent.el package is not available to require, and I'm not
;; ;; sure how to import it, so instead these will be set on initialization.
;; (use-package indent
;;     :init
;;     ;; TODO: this should be declared on the lisp-mode section.
;;     ;; I don't follow Lisp indenting guidelines, so the default indentation breaks for me.
;;     (add-hook 'emacs-lisp-mode-hook '(lambda ()
;;         (setq-local
;;             ;; indent-line-function 'indent-relative
;;             lisp-body-indent tab-width
;;         )
;;     ))
;;     :config
;;     (setq-default indent-tabs-mode nil); Use spaces for tabs
;;     (setq
;;         indent-line-function 'indent-relative
;;         tab-always-indent t; The tab key will always indent (duh)
;;         tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84)
;;     )
;; )

;; Settings for programming modes
(use-package prog-mode
    :config (progn
        ;; Normally prettify-symbols makes a good work replacing symbols, sadly,
        ;; this breaks the ligature functionallity of fonts that have it (like Fira Code).
        (global-prettify-symbols-mode 0)
        ;; Setup ligatures
        (let
            ((alist '(
                (33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
                (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
                (36 . ".\\(?:>\\)")
                (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
                (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
                (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
                (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
                (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
                (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
                (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
                (48 . ".\\(?:x[a-zA-Z]\\)")
                (58 . ".\\(?:::\\|[:=]\\)")
                (59 . ".\\(?:;;\\|;\\)")
                (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
                (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
                (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
                (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
                (91 . ".\\(?:]\\)")
                (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
                (94 . ".\\(?:=\\)")
                (119 . ".\\(?:ww\\)")
                (123 . ".\\(?:-\\)")
                (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
                (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
            )))
            (dolist
                (char-regexp alist)
                (set-char-table-range composition-function-table
                    (car char-regexp)
                    `([,(cdr char-regexp) 0 font-shape-gstring])
                )
            )
        )
    )
)

(provide 'native-prog-mode)
