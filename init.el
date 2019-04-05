;;; init.el --- Hector Menendez' Emacs configuration.

;;; Commentary:
;;; Hey, don't judge, this is a work in progresss!

;;; Code:

;; ------------------------------------------------------------------------- Core settings

(defvar etor/path (expand-file-name (file-name-as-directory "sections") user-emacs-directory))
(defvar etor/path/bundled (concat etor/path (file-name-as-directory "bundled")))
(defvar etor/path/system (concat etor/path (file-name-as-directory "system")))
(defvar etor/path/editor (concat etor/path (file-name-as-directory "editor")))
(defvar etor/path/content (concat etor/path (file-name-as-directory "content")))
(defvar etor/path/deltofetch (expand-file-name "_deltofetch" user-emacs-directory))

; set GC to something big to optimize loading time, restore it after load.
(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook #'(lambda () (setq gc-cons-threshold 800000)))

;; C Source code
;; these are the absolute first thing that should be setup.
(setq
    create-lockfiles nil; Don't create ".#" files
    ring-bell-function 'ignore; don't run any function when alerting
    visible-bell nil; don't show the visual que when alerting
    message-log-max 10000; max number of lines to keep in logfile.
    load-prefer-newer t; Don't load outdated byte code
    max-mini-window-height 0.5; Use up to 50% of frame height for mini-buffer window.
    line-spacing 1; The spacing between lines vertically
)

;; Startup.el
;; This file parses the command line and gets Emacs running.
(setq
    inhibit-startup-screen 1; Don't show the welcome screen
    initial-scratch-message nil; Don't show a message on *scratch* mode
)

; Ask for just one letter when confirmation needed
(defalias 'yes-or-no-p 'y-or-n-p)

;; ----------------------------------------------------------------------- Package Manager

(require 'package)

(setq
    package-enable-at-startup nil; Disable the default packaage-manager at startup
    package-user-dir (expand-file-name "_elpa" user-emacs-directory); packages dir
)
(setq-default
    quelpa-dir (expand-file-name "_quelpa" user-emacs-directory)
)

;; The repositories to fetch packages-from.
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; This will be added to this file no matter what, so, add it.
(package-initialize)

;; if quelpa not present, download and install it so packages can be compiled from source.
;; Also, install quelpa-use-package so those packages can be loaded using "use-package"
;; (use-package is a dependecy so it won't be necessary to explicitly install it)
(unless (file-exists-p etor/path/deltofetch) (progn
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
        :url "https://framagit.org/steckerhalter/quelpa-use-package.git")
    ))
    (write-region "" nil etor/path/deltofetch)
)

;; initialize use-package with quelpa support
(require 'quelpa-use-package)

(use-package bind-key :demand t); Enables :bind (key binding) on use-package
(use-package delight :ensure t); Enables :delight (custom mode name) on use-package

;; ------------------------------------------------------------------------------ ORG Mode

(use-package org :ensure org-plus-contrib); Use the latest contrib version of org.
(org-babel-load-file (expand-file-name "README.org" user-emacs-directory))

;; ---------------------------------------------------------------------------------- DONE
(switch-to-buffer "*Messages*")
(message (concat "Emacs took " (emacs-init-time) " to load."))

(provide 'init)
;;; init.el ends here
