(set-face-attribute 'default nil :font "Monaspace Argon" :height 180)

(tool-bar-mode -1)

(use-package doom-themes
  :ensure t
  :custom
  (custom-safe-themes t)
  :config
  (load-theme 'doom-palenight))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package emacs
  :custom
  ;; enable tab completion
  (tab-always-indent 'complete)
  (display-line-numbers 'relative)
  (text-mode-ispell-word-completion nil)
  :hook
  (prog-mode . display-line-numbers-mode))

;; Setup backup directory
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

(use-package org-auto-tangle
  :ensure t
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(defconst leader "SPC")

(use-package general
  :ensure t)

(setq evil-want-keybinding nil)

(use-package evil
  :ensure t
  :custom
  (evil-undo-system 'undo-redo)
  (evil-want-C-u-delete t)
  (evil-want-C-u-scroll t)
  (evil-want-minibuffer t)
  :config
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-snipe
  :ensure t
  :custom
  (evil-snipe-scope 'buffer)
  (evil-snipe-spillover-scope 'buffer)
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init))

(use-package vimish-fold
  :ensure t
  :after evil)

;(use-package evil-vimish-fold
;  :ensure t
;  :after vimish-fold
;  :hook ((prog-mode conf-mode text-mode) . evil-vimish-foldn-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package corfu
  :ensure t
  :general
  (:states 'insert :keymaps 'corfu-mode-map
	   "TAB" 'corfu-next
	   "S-TAB" 'corfu-previous
	   "C-SPC" 'corfu-complete)
  :custom
  (corfu-auto t)
  :init
  (global-corfu-mode))

(use-package vertico
  :ensure t
  :general
  (:keymaps 'vertico-map
	   "TAB" 'vertico-next
	   "S-TAB" 'vertico-previous
	   "C-SPC" 'vertico-insert)
  :init
  (vertico-mode))

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

(use-package rust-mode
  :ensure t
  :custom
  (rust-mode-treesitter-derive t))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package magit
  :ensure t
  :general
  (:states 'normal
	   :prefix leader
	   "g" 'magit))
