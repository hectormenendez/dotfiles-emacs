;;; init.el --- Hector Menendez' Emacs configuration.

;;; Commentary:
;;; This is the main entry point for my Emacs's config, it loads README.org afterwards.

;;; Code:

;; ------------------------------------------------------------------------- Core settings

(defvar etor/init:flag "_DELME-TO-UPDATE.flag")
(defvar etor/init:index "README.org")

(defvar etor/path (expand-file-name (file-name-as-directory "sections") user-emacs-directory))
(defvar etor/path:system (concat etor/path (file-name-as-directory "system")))
(defvar etor/path:custom (concat etor/path (file-name-as-directory "custom")))
(defvar etor/path:editor (concat etor/path (file-name-as-directory "editor")))
(defvar etor/path:content (concat etor/path (file-name-as-directory "content")))

(defvar etor/path:editor-bundled (concat etor/path:editor (file-name-as-directory "bundled")))
(defvar etor/path:editor-package (concat etor/path:editor (file-name-as-directory "package")))
(defvar etor/path:editor-package-visual (concat etor/path:editor-package (file-name-as-directory "visual")))
(defvar etor/path:editor-package-commands (concat etor/path:editor-package (file-name-as-directory "commands")))
(defvar etor/path:editor-package-wrappers (concat etor/path:editor-package (file-name-as-directory "wrappers")))
(defvar etor/path:editor-package-navigation (concat etor/path:editor-package (file-name-as-directory "navigation")))

(defvar etor/path:content-bundled (concat etor/path:content (file-name-as-directory "bundled")))
(defvar etor/path:content-package  (concat etor/path:content (file-name-as-directory "package")))

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
    ;; TODO: this should be set only for GUI
    line-spacing 1; The spacing between lines vertically
)

;; Startup.el
;; Basic settings setup while loading Emacs.
(setq
    inhibit-startup-screen 1; Don't show the welcome screen
    initial-scratch-message nil; Don't show a message on *scratch* mode
    ; the location for auto-save files
    auto-save-list-file-prefix
        (expand-file-name (file-name-as-directory "_auto-save-list") user-emacs-directory)
)

;; TODO: These should be set on custom.el
(setq-default
    tab-width 4; Use 4 spaces for indentation
    fill-column 90; word-wrap after the 90th character
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
(unless (file-exists-p (expand-file-name etor/init:flag user-emacs-directory)) (progn
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
    (write-region "" nil (expand-file-name etor/init:flag user-emacs-directory))
)

;; initialize use-package with quelpa support
(require 'quelpa-use-package)

(use-package bind-key :demand t); Enables :bind (key binding) on use-package
(use-package delight :ensure t); Enables :delight (custom mode name) on use-package

;; ------------------------------------------------------------------------------ ORG Mode

;; Use the latest contrib version of org.
;; TODO: maybe use defer instead of demand? does org-babel-load-file need this?
(use-package org
    :ensure org-plus-contrib
    :demand t
    :config
    (setq
        org-hide-leading-stars nil; Always show stars in headings
        org-startup-folded "children"
    )
)

;; TODO: This is not working for whatever reason.
;; Allows the generation of a Table of Contents for Github
;; (use-package toc-org
;;     :ensure t
;;     :hook org-mode
;;     :commands toc-org-mode
;; )

;; Load the initialization
(org-babel-load-file (expand-file-name etor/init:index user-emacs-directory))

;; ---------------------------------------------------------------------------------- DONE
(defun display-startup-echo-area-message ()
    "Overwritten startup message."
    (message (concat "Emacs took " (emacs-init-time) " to load."))
)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(restart-emacs try toc-org rainbow-mode quelpa-use-package org-plus-contrib delight))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
