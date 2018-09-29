;;; init.el --- Personal emac configuration of Héctor Menéndez

;;; Commentary:
;;; Hey, don't judge, this is a work in progresss!

;;; Code:

;; ------------------------------------------------------------------------- Core settings
(setq
    ; don't show the big-ass notification that appears on MacOS
    ring-bell-function 'ignore
    visible-bell nil
    message-log-max 10000
    load-prefer-newer t; Don't load outdated byte code
    gc-cons-threshold 2000000; no need of garbage collect that often
    max-mini-window-height 0.5; Use up to 50% of frame height for mini-buffer window.
    ;; Startup
    inhibit-startup-screen 1; Don't show the welcome screen
    initial-scratch-message nil; Don't show a message on *scratch* mode
    create-lockfiles nil; Don't create ".#" files
)
(setq-default
    line-spacing 1; The spacing between lines vertically
)

; Ask for just one letter when confirmation needed
(defalias 'yes-or-no-p 'y-or-n-p)

;; ----------------------------------------------------------------------- Package Manager

(require 'package)

(setq
    package-enable-at-startup nil; Disable the default packaage-manager at startup
    package-user-dir (expand-file-name "_elpa" user-emacs-directory); packages dir
)

;; The repositories to fetch packages-from.
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; This will be added to this file no matter what, so, add it.
(package-initialize)

;; if quelpa not present, download and install it so packages can be compiled from source.
;; Also, install quelpa-use-package so those packages can be loaded using "use-package"
;; (use-package is a dependecy so it won't be necessary to explicitly install it)
(setq-default
    quelpa-dir (expand-file-name "_quelpa" user-emacs-directory)
)
(unless (package-installed-p 'quelpa)
    (package-refresh-contents)
    (package-install 'quelpa)
    (quelpa '(quelpa-use-package
        :fetcher github
        :repo "https://framagit.org/steckerhalter/quelpa-use-package.git"
    ))
)

;; Enable use-package with quelpa support.
(require 'quelpa-use-package)

;; ------------------------------------------------------------------------------ Packages
(add-to-list 'load-path (expand-file-name "packages" user-emacs-directory))
(use-package bind-key :demand t); Allows the  use of :bind
(use-package delight :ensure t); Diminish alternative, allows to rename mode names

;; ---------------------------------------------------------------------- Packages» Native
(require 'native-simple)
(require 'native-server)
(require 'native-files)
(require 'native-recentf)
(require 'native-savehist)
(require 'native-saveplace)
(require 'native-autorevert)
(require 'native-custom)
(require 'native-mule)
(require 'native-whitespace)
(require 'native-paren)
(require 'native-prog-mode)
(require 'native-frame)
(require 'native-menu-bar)
(require 'native-register)
(require 'native-electric)
(require 'native-line-numbers)

;; --------------------------------------------------- Packages» Editor» SystemIntegration
(require 'elpa-exec-path-from-shell)
(require 'elpa-nvm)
(require 'elpa-wakatime-mode); Disabled it because issues with local python installation

;; ----------------------------------------------------------- Packages» Editor» Behaviour
(require 'elpa-try)
(require 'elpa-restart-emacs)
(require 'elpa-evil)
(require 'elpa-web-beautify)

;; ------------------------------------------------------- Packages» Editor» ExtraFeatures
(require 'elpa-magit)

;; ---------------------------------------------------------- Packages» Editor» Navigation
(require 'elpa-ace-window)
(require 'elpa-psession)
(require 'elpa-helm)
(require 'elpa-projectile)
(require 'elpa-neotree)
(require 'elpa-dired+)

;; --------------------------------------------------------- Packages» Content» Navigation
(require 'elpa-multiple-cursors)
(require 'elpa-expand-region)
(require 'elpa-origami)

;; --------------------------------------------------------- Packages» Content» VisualAids
(require 'elpa-which-key)
(require 'elpa-telephone-line)
(require 'elpa-company)
(require 'elpa-centered-cursor-mode)

;; ----------------------------------------------------------------------- Packages» Modes
(require 'elpa-web-mode)
(require 'elpa-json-mode)
(require 'elpa-ecmascript)
(require 'elpa-markdown-mode)
(require 'elpa-nxml-mode)
(require 'elpa-elixir-mode)
(require 'elpa-graphql-mode)

;; -------------------------------------------------------- Packages» ProgMode» Navigation
(require 'elpa-dumb-jump)

;; ------------------------------------------------ Packages» ProgMode» Behaviour» Content
(require 'elpa-dtrt-indent)

;; ------------------------------------------------ Packages» ProgMode» VisualAids» Editor
(require 'elpa-git-gutter)
(require 'elpa-highlight-indent-guides)
(require 'elpa-fill-column-indicator)
(require 'elpa-flycheck)

; ;; --------------------------------------------- Packages» ProgMode» VisualAids» Content
(require 'elpa-hl-todo)
(require 'elpa-smartparens)
(require 'elpa-rainbow-delimiters)
(require 'elpa-rainbow-mode)
(require 'elpa-highlight-numbers)
(require 'elpa-highlight-quoted)

