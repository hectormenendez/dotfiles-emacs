;;; init.el -- Emacs initialization.
;;; -*- lexical-binding: t; -*-

;;; Commentary:
;;; This is weird.

;;; Code:

;; ------------------------------------------------------------------ Minimal Vars & Funcs
;; These are the minimal custom variables and functions needed to startup the config.

(defvar etor/init:flag "_DELME-TO-UPDATE.flag")
(defvar etor/init:index "README.org")
(defvar etor/slash (substring user-emacs-directory -1)); The path separator

;; Path management
;; Contains a list of paths available to get using etor/path:get
(defvar etor/path:list '())

(defun etor/path:get (key)
    "Return a path declared on the etor/paths list.  (KEY)."
    (interactive)
    (cdr (assoc key etor/path:list))
)
(defun etor/path:put (key val)
    "Set a new path to the etor/paths list.  (KEY, VAL)."
    (interactive)
    (let ((parts (split-string val ":")))
        (if (= (length parts) 1)
            ;; an identifier couldn't be found, insert the predicate as is.
            (push (cons key (file-name-as-directory val)) etor/path:list)
            (let*
                (
                    (target (etor/path:get (car parts)))
                    (route (file-name-as-directory (mapconcat 'identity (cdr parts) "/")))
                )
                (push (cons key (concat target route)) etor/path:list)
            )
        )
    )
)

(defun etor/path:print ()
    "Output to Messages the contents of the path variable."
    (interactive)
    (let (( list etor/path:list ))
        (while
            (print (car list))
            (setq list (cdr list))
        )
    )
)

(etor/path:put "emacs" (expand-file-name user-emacs-directory))
(etor/path:put "autosave" "emacs:_autosave")
(etor/path:put "sections" "emacs:sections")
(etor/path:put "packages" "emacs:_packages")
(etor/path:put "packages-elpa" "packages:_melpa")
(etor/path:put "packages-quelpa" "packages:_quelpa")

;; ------------------------------------------------------------------------------- Startup

;; C Source code
;; these are the absolute first thing that should be setup.
(setq
    create-lockfiles nil; Don't create ".#" files
    ring-bell-function 'ignore; don't run any function when alerting
    visible-bell nil; don't show the visual que when alerting
    message-log-max 10000; max number of lines to keep in logfile.
    load-prefer-newer t; Don't load outdated byte code
    max-mini-window-height 0.5; Use up to 50% of frame height for mini-buffer window.
)

;; startup.el
;; Basic settings setup while loading Emacs.
(setq
    inhibit-startup-screen 1; Don't show the welcome screen
    initial-scratch-message nil; Don't show a message on *scratch* mode
    ; the location for auto-save files
    auto-save-list-file-prefix (etor/path:get "autosave")
)

;; TODO: These should be set on custom.el
(setq-default
    tab-width 4; Use 4 spaces for indentation
    fill-column 90; word-wrap after the 90th character
    line-spacing 1; The spacing between lines vertically
)

; Ask for just one letter when confirmation needed
(defalias 'yes-or-no-p 'y-or-n-p)

;; -------------------------------------------------------------------- Package Management

(require 'package)

(setq
    package-enable-at-startup nil; Disable the default packaage-manager at startup
    package-user-dir (etor/path:get "packages-elpa")
)
(setq-default quelpa-dir (etor/path:get "packages-quelpa"))

;; The repositories to fetch packages-from.
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; This will be added to this file no matter what, so, add it.
(package-initialize)

;; if quelpa not present, download and install it so packages can be compiled from source.
;; Also, install quelpa-use-package so those packages can be loaded using "use-package"
;; (use-package is a dependecy so it won't be necessary to explicitly install it)

(let ((file (concat (etor/path:get "emacs") etor/init:flag)))
    (unless (file-exists-p file) (progn
        ; make sure packages are up-to-date
        (package-refresh-contents)
        ; Install quelpa for additional packages
        (if (require 'quelpa nil t)
            ;; only upgrade if already fetched
            (quelpa-self-upgrade)
            ;; not installed, fetch and install.
            (with-temp-buffer
                (url-insert-file-contents
                    "https://framagit.org/steckerhalter/quelpa/raw/master/bootstrap.el")
                (eval-buffer)
            )
        )
        ;; Add use-package with quelpa support
        (quelpa '(quelpa-use-package
            :fetcher git
            :url "https://framagit.org/steckerhalter/quelpa-use-package.git"
        ))
        ;; Write file so this doesn't run again until the file is deleted
        (write-region "" nil file)
    ))
)

;; initialize use-package with quelpa support
(require 'quelpa-use-package)

(use-package bind-key :ensure t); Enables :bind (key binding) on use-package
(use-package delight :ensure t); Enables :delight (custom mode name) on use-package

;; ------------------------------------------------------------------------------ ORG MODE
;; Use orgmode to load the rest of the configuration for a better reading experience.

;; The rest of the configuration will be loaded using literate elisp.
;; (org-babel-load-file (concat (etor/path:get "emacs") etor/init:index))

;; ---------------------------------------------------------------------------------- DONE
(defun display-startup-echo-area-message ()
    "Overwritten startup message."
    (message (concat "Emacs took " (emacs-init-time) " to load."))
)

(provide 'init)
;;; init.el ends here
