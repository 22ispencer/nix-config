(use-package emacs
  :custom
  ;; enable tab completion
  (frame-resize-pixelwise t)
  (tab-always-indent 'complete)
  (display-line-numbers 'relative)
  (text-mode-ispell-word-completion nil)
  (inhibit-startup-screen t)
  (fill-column 80)
  :hook
  (prog-mode . display-line-numbers-mode)
  :config
  (electric-pair-mode +1))

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

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

(use-package envrc
  :ensure t
  :hook
  (after-init . envrc-global-mode))

(defconst leader "SPC")

(use-package general
  :ensure t)

(defun me/reload-config ()
  "Reload init file"
  (interactive)
  (load "~/.emacs.d/init.el")
  (message "reloaded config"))

(general-def
  :states 'normal
  "SPC q Q" 'kill-emacs
  "SPC q r" 'me/reload-config)

(setq me/system (system-name))
(setq me/font-size (cond ((string= me/system "garp") 20)
			 ((string= me/system "ace") 16)
			 (t 14)))
(setq me/font-name (format "Monaspace Argon-%d" me/font-size))

(add-to-list 'default-frame-alist `(font . ,me/font-name))
(set-fontset-font t nil (font-spec :size 20 :name "Symbols Nerd Font"))
; (set-face-attribute 'default nil :font "Monaspace Argon" :height me/font-size)


(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)


(use-package doom-themes
  :ensure t
  :custom
  (custom-safe-themes t)
  :config
  (load-theme 'doom-palenight))

;(use-package doom-modeline
;  :ensure t
;  :init (doom-modeline-mode 1))

(setq evil-want-keybinding nil)

(use-package evil
  :ensure t
  :custom
  (evil-undo-system 'undo-redo)
  (evil-want-C-u-delete t)
  (evil-want-C-u-scroll t)
  (evil-want-Y-yank-to-eol t)
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

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

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
  (global-corfu-mode)
  :config
  (define-key corfu-map (kbd "<RET>") nil))

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

(use-package format-all
  :ensure t
  :hook ((prog-mode . format-all-mode)
	 format-all-ensure-formatter)
  :config
  (setq-default format-all-formatters
		'(("C" (clang-format "--fallback-style=gnu"))
		  ("C++" (clang-format "--fallback-style=gnu"))
		  ("Nix" (nixfmt)))))

(use-package web-mode
  :ensure
  t
  :mode
  (("\\.phtml\\'" . web-mode)
   ("\\.php\\'" . web-mode)
   ("\\.tpl\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.cshtml?\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode))
  :custom
  (web-mode-engines-alist
   '(("razor" . "\\.cshtml\\"))))

(use-package rust-mode
  :ensure t
  :custom
  (rust-mode-treesitter-derive t))

(use-package meson-mode
  :ensure t)

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package svelte-mode
  :ensure t)

(use-package org
  :custom
  (org-babel-load-languages '((emacs-lisp . t)
			      (python . t)
			      (octave . t)))
  :hook
  (org-mode . org-indent-mode)
  (org-babel-after-execute org-redisplay-inline-images))

(use-package org-bullets
  :ensure t
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(use-package engrave-faces
  :ensure t
  :custom
  (org-latex-src-block-backend 'engraved))
(setq org-preview-latex-default-process 'dvisvgm)
(plist-put org-format-latex-options :scale 2)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/org/roam")
  :general
  (:states 'normal :prefix "SPC n"
	   "f" 'org-roam-node-find
	   "i" 'org-roam-node-insert
	   "c" 'org-roam-capture
	   "t" 'org-roam-tag-add
	   "T" 'org-roam-tag-remove
	   "a" 'org-roam-alias-add
	   "a" 'org-roam-alias-remove)
  :config
  (org-roam-db-autosync-mode))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-loader-install))

(use-package auctex
  :ensure t)

(use-package magit
  :ensure t
  :general
  (:states 'normal
	   :prefix leader
	   "g" 'magit))

(use-package vterm
  :ensure t
  :general
  (:states 'normal
	   "SPC v" 'vterm))
