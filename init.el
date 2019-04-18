;;; init.el -- Emacs initialization.
;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;; This is weird.

;;; Code:

(require 'org)
(save-window-excursion (let*
    (
        (gc-cons-threshold most-positive-fixnum)
        (org-babel-src-block-regexp (concat
            ;; (1) indentation                 (2) lang
            "^\\([ \t]*\\)#\\+begin_src[ \t]+\\([^ \f\t\n\r\v]+\\)[ \t]*"
            ;; (3) switches
            "\\([^\":\n]*\"[^\"\n*]*\"[^\":\n]*\\|[^\":\n]*\\)"
            ;; (4) header arguments
            "\\([^\n]*\\)\n"
            ;; (5) body
            "\\([^\000]*?\n\\)??[ \t]*#\\+end_src"
        ))
        (file-org "README.org")
        (file-el  "README.el")
        (contents ())
    )
    (with-temp-buffer
        (insert-file-contents file-org)
        (org-org-export-as-org)
        (goto-char (point-min))
        (while (re-search-forward org-babel-src-block-regexp nil t)
            (let
                (
                    (lang (match-string 2))
                    (args (match-string 4))
                    (body (match-string 5))
                )
                (when
                    (and (string= lang "emacs-lisp")
                         (not (string-match-p ":tangle\\s-+no" args))
                    )
                    (add-to-list 'contents body)
                )
            )
        )
	)
	(kill-buffer "*Org ORG Export*")
    (with-temp-file file-el
        (insert (format ";; Don't edit this file, edit %s instead ...\n\n" file-org))
        (apply 'insert (reverse contents))
    )
    (message "Wrote %s ..." file-el)
))

(provide 'init)
;;; init.el ends here
