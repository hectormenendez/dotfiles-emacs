;;; elpa-multiple-cursors.el --- Enable multiple cursors handling

;;; Commentary:

;;; Code:
(use-package multiple-cursors
    :ensure t
    :config (progn

        (add-hook 'evil-leader-mode-hook '(lambda ()
            (evil-leader/set-key "c*" 'mc/mark-all-like-this)
            (evil-leader/set-key "cc" 'mc/edit-lines)
            (evil-leader/set-key "c$" 'mc/edit-ends-of-lines)
            (evil-leader/set-key "cn" 'mc/mark-next-like-this-symbol)
            (evil-leader/set-key "cp" 'mc/mark-previous-like-this-word)
            (evil-leader/set-key "c{" 'mc/cycle-backward)
            (evil-leader/set-key "c}" 'mc/cycle-forward)
            (evil-leader/set-key "cx" 'mc/skip-to-next-like-this)
            (evil-leader/set-key "cX" 'mc/skip-to-previous-like-this)
        ))

        (eval-after-load 'evil-maps '(lambda ()
            ;; <C-n> & <C-p> are in the evil-keymap.
            ;; - First, remove them, otherwise the global map wouldn't override it.
            ;; - Overrride the global map withe the correct command.
            (define-key evil-normal-state-map (kbd "C-n") nil)
            (define-key evil-normal-state-map (kbd "C-p") nil)
            (define-key global-map (kbd "C-n") 'mc/mark-next-like-this-symbol)
            (define-key global-map (kbd "C-p") 'mc/mark-previous-like-this-symbol)
        ))

        (add-hook 'after-init-hook '(lambda ()
            ;; New global keymaps
            (define-key global-map (kbd "<C-down>") 'mc/mark-next-like-this)
            (define-key global-map (kbd "<C-up>") 'mc/mark-previous-like-this)
            (define-key global-map (kbd "<C-right>") 'mc/edit-ends-of-lines)
            (define-key global-map (kbd "<C-left>") 'mc/edit-beginnings-of-lines)
        ))

        ;; Set an *ignorable* path for the mc list file.
        (setq mc/list-file (expand-file-name "_mclist" user-emacs-directory))

        ;; Don't ask for confirmation on the following commands
        (setq mc/cmds-to-run-for-all '(
            evil-insert
            evil-change
            evil-normal-state
            evil-append-line
            evil-delete-line
            evil-forward-WORD-begin
            evil-forward-WORD-end
            evil-forward-word-begin
            evil-forward-word-end
            evil-backward-WORD-begin
            evil-backward-WORD-end
            evil-backward-word-begin
            evil-backward-word-end
            evil-end-of-line
            evil-first-non-blank
            evil-find-char
            evil-find-char-backward
            evil-find-char-to
            evil-find-char-to-backward
            evil-next-line
            evil-previous-line
            evil-delete-char
            yank-rectagle
            copy-region-as-kill; used for multiple selection copy
        ))

        ;; Replace the default keymap
        (define-key mc/keymap (kbd "C-g") 'mc/keyboard-quit); originally C-g
        (define-key mc/keymap (kbd "C-v") 'mc/cycle-forward); originally C-v
        (define-key mc/keymap (kbd "M-v") 'mc/cycle-backward); originally M-v
        (define-key mc/keymap (kbd "C-:") 'mc/repeat-command); originally C-:
        (define-key mc/keymap (kbd "C-'") 'mc-hide-unmatched-lines-mode); originally C-v
        (define-key mc/keymap (kbd "<return>") nil); originally: 'multiple-cursor-mode
    )
)

(provide 'elpa-multiple-cursors)
;;; elpa-multiple-cursors.el ends here
