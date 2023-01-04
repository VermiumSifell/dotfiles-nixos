(add-to-list 'exec-path "~/.local/bin/") 
(add-to-list 'exec-path "/home/vermium/.emacs.d/.cache/lsp/npm/vscode-langservers-extracted/bin/")
(add-to-list 'exec-path "/usr/bin/") 
(add-to-list 'exec-path "/home/vermium/.cargo/bin")

(setq auto-save-default nil) ; stop creating #autosave# files
(setq make-backup-files nil) ; stop creating backup~ files

(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell nil)


;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha '(98 . 98))
(add-to-list 'default-frame-alist '(alpha . (98 . 98)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized)) 

;; Line Numbers.
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes.
(dolist (mode '(org-mode-hook
                term-mode-hook
                treemacs-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Highlight cursor line.
(global-hl-line-mode t)

;; Set the font
(set-face-attribute 'default nil :font "Fira Code Retina" :height 110)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 100)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Fira Code Retina" :height 120 :weight 'regular)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(package-initialize)

;; Configure use-package to use straight.el by default
(use-package straight
  :custom (straight-use-package-by-default t))

(straight-use-package 'org)

(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

;; A log for the commands i run.
(use-package command-log-mode)

(defun vs/minibuffer-backward-kill (arg)
  (interactive "p")
  (cond
   ;; When minibuffer has ~/
   ((and minibuffer-completing-file-name
         (string= (minibuffer-contents-no-properties) "~/"))
    (delete-minibuffer-contents)
    (insert "/home/"))

   ;; When minibuffer has some file and folder names
   ((and minibuffer-completing-file-name
         (not (string= (minibuffer-contents-no-properties) "/"))
         (= (preceding-char) ?/))
    (delete-char (- arg))
    (zap-up-to-char (- arg) ?/))

   ;; All other cases
   (t
    (delete-char (- arg)))))

(use-package vertico
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word)
              ("" . vs/minibuffer-backward-kill))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("C-s" . consult-line)
         ("C-S-s" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))
)

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package consult-org-roam
 :ensure t
 :after org-roam consult
 :init
 (require 'consult-org-roam)
 ;; Activate the minor mode
 (consult-org-roam-mode 1)
 :custom
 ;; Use `ripgrep' for searching with `consult-org-roam-search'
 (consult-org-roam-grep-func #'consult-ripgrep)
 ;; Configure a custom narrow key for `consult-buffer'
 (consult-org-roam-buffer-narrow-key ?r)
 ;; Display org-roam buffers right after non-org-roam buffers
 ;; in consult-buffer (and not down at the bottom)
 (consult-org-roam-buffer-after-buffers t)
 :config
 ;; Eventually suppress previewing for certain functions
 (consult-customize
  consult-org-roam-forward-links
  :preview-key (kbd "M-."))
 :bind
 ;; Define some convenient keybindings as an addition
 ("C-c n e" . consult-org-roam-file-find)
 ("C-c n b" . consult-org-roam-backlinks)
 ("C-c n l" . consult-org-roam-forward-links)
 ("C-c n r" . consult-org-roam-search))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult-yasnippet)

(use-package affe
  :config
  ;; Manual preview key for `affe-grep'
  (consult-customize affe-grep :preview-key (kbd "M-.")))

(defun affe-orderless-regexp-compiler (input _type _ignorecase)
  (setq input (orderless-pattern-compiler input))
  (cons input (lambda (str) (orderless--highlight input str))))
(setq affe-regexp-compiler #'affe-orderless-regexp-compiler)

(use-package all-the-icons-completion
  :init
  (all-the-icons-completion-mode)
  :hook
  (marginalia-mode . all-the-icons-completion-marginalia-setup))

;; Use the package ivy for completion.
;;(use-package ivy
;;  :diminish
;;  :bind (("C-s" . swiper)
;;         :map ivy-minibuffer-map
;;         ("TAB" . ivy-alt-done)	
;;         ("C-l" . ivy-alt-done)
;;         ("C-j" . ivy-next-line)
;;         ("C-k" . ivy-previous-line)
;;         :map ivy-switch-buffer-map
;;         ("C-k" . ivy-previous-line)
;;         ("C-l" . ivy-done)
;;         ("C-d" . ivy-switch-buffer-kill)
;;         :map ivy-reverse-i-search-map
;;         ("C-k" . ivy-previous-line)
;;         ("C-d" . ivy-reverse-i-search-kill))
;;  :config
;;  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 30)))

(use-package all-the-icons
  :ensure t)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))

;;(use-package ivy-rich
;;  :init
;;  (ivy-rich-mode 1))

;;(use-package counsel
;;  :bind (("M-x" . counsel-M-x)
;;         ("C-x b" . counsel-ibuffer)
;;         ("C-x C-f" . counsel-find-file)
;;         :map minibuffer-local-map
;;         ("C-r" . 'counsel-minibuffer-history))
;;  :config
;;         (setq ivy-initial-inputs-alist nil) ;; Don't start searches with ^. 
;;  )

(use-package dmenu)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-create-definer vs/exwm-keyboard
    :keymaps '(normal insert visual emacs)
    :prefix "s"
    :global-prefix "s")
  (general-create-definer vs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package restclient)

(use-package hydra)

(use-package mu4e
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 20 ; Wait until 20 seconds after startup
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")

  (setq mu4e-contexts
        (list
         ;; Work account
         (make-mu4e-context
          :name "Private"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/Karabro" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "vermium@zyner.org")
                  (user-full-name    . "Vermium Sifell")
                  (mu4e-drafts-folder  . "/Karabaro/Drafts")
                  (mu4e-sent-folder  . "/Karabro/Sent Mail")
                  (mu4e-refile-folder  . "/Karabro/All Mail")
                  (mu4e-trash-folder  . "/Karabro/Trash")))))

  (setq mu4e-maildir-shortcuts
        '(("/Inbox"     . ?i)
          ("/Sent Mail" . ?s)
          ("/Trash"     . ?t)
          ("/Drafts"    . ?d)
          ("/All Mail"  . ?a))))

(use-package org-mime
  :ensure t
  :bind
  ("C-<return>" . org-mime-htmlize))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Set the title
(setq dashboard-banner-logo-title "Hey!")

;; Set the banner
(setq dashboard-startup-banner [VALUE])

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(use-package ssh
  :hook
  (ssh-mode-hook . (lambda ()
                     (setq ssh-directory-tracking-mode t)
                     (shell-dirtrack-mode t)
                     (setq dirtrackp nil))))

(use-package google-this
  :config
  (google-this-mode 1))

(use-package sx
  :config
  (bind-keys :prefix "C-c s"
             :prefix-map my-sx-map
             :prefix-docstring "Global keymap for SX."
             ("q" . sx-tab-all-questions)
             ("i" . sx-inbox)
             ("o" . sx-open-link)
             ("u" . sx-tab-unanswered-my-tags)
             ("a" . sx-ask)
             ("s" . sx-search)))

(use-package elcord
  :init
  (elcord-mode)
  :config
  (setq elcord-quite t))

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-ö" . flyspell-correct-wrapper)))

(use-package flyspell-correct-ivy
  :after flyspell-correct)

(use-package elfeed)
(setq elfeed-feeds
      '("https://reddit.com/r/emacs.rss"
        "https://reddit.com/r/minecraft.rss"
        "https://reddit.com/r/scrapmechanic.rss"))

(use-package 2048-game)

(use-package quiz)

(use-package typing-game)

(use-package sudoku)

(use-package steam
  :config
  (setq steam-username "swegamerhere"))

(use-package typit)

(use-package emms
  :config
  (emms-all))

(use-package doom-themes)
(use-package modus-themes)

(use-package crdt)

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package simple-httpd
  :ensure t)

(use-package emojify
  :hook (after-init . global-emojify-mode))

;; Configure Tempel
(use-package tempel
  ;; Require trigger prefix before template name when completing.
  ;; :custom
  ;; (tempel-trigger-prefix "<")

  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))

  :init


  ;; Setup completion at point
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; `tempel-expand' only triggers on exact matches. Alternatively use
    ;; `tempel-complete' if you want to see all matches, but then you
    ;; should also configure `tempel-trigger-prefix', such that Tempel
    ;; does not trigger too often when you don't expect it. NOTE: We add
    ;; `tempel-expand' *before* the main programming mode Capf, such
    ;; that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  ;; (global-tempel-abbrev-mode)
  )

(straight-use-package '(tab-bookmark :host github :repo "minad/tab-bookmark"))

(use-package goggles
  :ensure t
  :hook ((prog-mode text-mode) . goggles-mode)
  :config
  (setq-default goggles-pulse t))

(straight-use-package '(smudge :host github :repo "danielfm/smudge"))

(straight-use-package '(matrix-client :host github :repo "alphapapa/matrix-client.el"))

(use-package multiple-cursors
  :bind
  (("H-SPC" . set-rectangular-region-anchor)
   ("C-M-SPC" . set-rectangular-region-anchor)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C->" . mc/mark-all-like-this)
   ("C-c C-SPC" . mc/edit-lines)
   ))

(use-package chezmoi
  :bind
  ("C-c C f" . chezmoi-find)
  ("C-c C s" . chezmoi-write)
  :hook
  (org-babel-post-tangle . chezmoi-write))

(electric-pair-mode 1)

(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "M-{") 'insert-pair)
(global-set-key (kbd "M-\"") 'insert-pair)

(use-package evil-nerd-commenter
:bind ("C-'" . evilnc-comment-or-uncomment-lines))

(use-package lsp-mode
  :straight t
  :commands lsp
  :hook ((typescript-mode js2-mode web-mode) . lsp)
  :bind (:map lsp-mode-map
              ("C-M-i" . completion-at-point))
  :custom (lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ui
  :straight t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-show))

(use-package eglot)

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  :after lsp-mode
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  :config
  (dap-ui-mode 1)

  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed

  (require 'dap-java)

  ;; dap for c++
  (require 'dap-lldb)

  ;; set the debugger executable (c++)
  (setq dap-lldb-debug-program '("/usr/bin/lldb-vscode"))

  ;; ask user for executable to debug if not specified explicitly (c++)
  (setq dap-lldb-debugged-program-function (lambda () (read-file-name "Select file to debug.")))

  ;; default debug template for (c++)
  (dap-register-debug-template
   "C++ LLDB dap"
   (list :type "lldb-vscode"
         :cwd nil
         :args nil
         :request "launch"
         :program nil))

  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
   :keymaps 'lsp-mode-map
   :prefix lsp-keymap-prefix
   "d" '(dap-hydra t :wk "debugger")))

(use-package typescript-mode
  :straight t
  :mode ("\\.ts\\'")
  :hook
  (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(add-hook 'javascript-mode-hook 'lsp-deferred)
(add-hook 'javascript-mode-hook 'prettier-js-mode)

(use-package js-imports

  :init
  (setq-default js-imports-completion-system 'ivy-completing-read)
  (setq-default js-imports-modules-default-names '(("ramda" . "R")
                                                   ("react" . "React")))
  :straight (js-imports
             :type git
             :host github
             :repo "KarimAziev/js-imports")
  :hook ((js-mode . js-imports-mode)
         (js2-mode . js-imports-mode)
         (typescript-mode . js-imports-mode)
         (web-mode . js-imports-mode)
         (js-imports-mode .
                          (lambda ()
                            (add-hook
                             'before-save-hook
                             'js-imports-transform-relative-imports-to-aliases
                             nil t))))
  :bind ((:map js-imports-mode-map
               ("C-c C-i" . js-imports)
               ("C-c C-j" . js-imports-jump-to-definition)
               ("C-c C-f" . js-imports-find-file-at-point)
               ("C-c C-." . js-imports-symbols-menu)
               ("C->" . js-imports-transform-import-path-at-point))
         (:map js-imports-file-map
               ("C-." . js-imports-select-next-alias)
               ("C-," . js-imports-select-prev-alias))))


(use-package prettier-js
  :hook
  (typescript-mode-hook . prettier-js-mode))

(use-package ivy-xref)

(use-package rjsx-mode
  :bind
  ("<f9>" . rjsx-mode))

(use-package lsp-java
  :hook
  (java-mode-hook . lsp-deferred))

;; (add-to-list 'lsp-language-id-configuration '(html-mode . "html"))
(add-hook 'html-mode 'lsp-deferred)

(use-package haskell-mode
  :hook
  (haskell-mode . lsp-deferred))

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  (python-shell-interpreter "python"))

(use-package csharp-mode
 :ensure t
 :hook (csharp-mode . lsp-deferred))

(use-package cc-mode
  :mode ("\\.cpp\\'" . cc-mode)
  :ensure t
  :hook (cc-mode . eglot))

(use-package css-mode
  :hook
  (css-mode-hook . lsp-deferred))

(use-package lua-mode
  :hook (lua-mode . lsp-deferred))

(use-package rust-mode
  :hook
  (rust-mode . lsp-deferred)
  (before-save-hook . lsp-format-buffer))

(use-package dockerfile-mode
  :hook
  (docker-filemode . lsp-deferred))
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(use-package paredit)

(use-package nasm-mode
    :hook
    (asm-mode-hook . nasm-mode)
    (nasm-mode . lsp-deferred)
    :custom
    (nasm-basic-offset 4))

;;  (add-to-list 'lsp-language-id-configuration '(nasm-mode . "nasm"))

;;  (lsp-register-client
  ;; (make-lsp-client :new-connection (lsp-stdio-connection "asm-lsp")
    ;;                :activation-fn (lsp-activate-on "nasm")
      ;;              :server-id 'asm-lsp))

(use-package prisma-mode
  :straight '(prisma-mode
              :host github
              :repo "pimeys/emacs-prisma-mode"
              :branch "main"))

(use-package nginx-mode)

;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-echo-documentation nil)
  :init
  (global-corfu-mode))

;; Disable auto completion-at-point for some modes.
(dolist (mode '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                lsp-mode-hook))
  (add-hook mode (lambda () (setq-local corfu-auto nil))))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c c p" . completion-at-point) ;; capf
         ("C-c c t" . complete-tag)        ;; etags
         ("C-c c d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c c h" . cape-history)
         ("C-c c f" . cape-file)
         ("C-c c k" . cape-keyword)
         ("C-c c s" . cape-symbol)
         ("C-c c a" . cape-abbrev)
         ("C-c c i" . cape-ispell)
         ("C-c c l" . cape-line)
         ("C-c c w" . cape-dict)
         ("C-c c \\" . cape-tex)
         ("C-c c _" . cape-tex)
         ("C-c c ^" . cape-tex)
         ("C-c c &" . cape-sgml)
         ("C-c c r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'default))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))


;;  (use-package counsel-projectile
;;    :config (counsel-projectile-mode))
(use-package consult-projectile
  :straight (consult-projectile :type git :host gitlab :repo "OlMon/consult-projectile" :branch "master"))

(use-package avy
  :bind ("C-:" . avy-goto-char))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge)

(defun vs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'vs/display-startup-time)

(defun vs/lookup-password (&rest keys)
  (let ((result (apply #'auth-source-search keys)))
    (if result
        (funcall (plist-get (car result) :secret))
      nil)))

;; Make ESC quit prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Eval buffer
(global-set-key (kbd "<f4>") 'eval-buffer)



(defun vs/run-program (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(defun vs/list-complete-run-program (programs)
    (vs/run-program
     (completing-read
      "Choose a program to run: "
      programs
      nil
      t)))

(defun vs/list-complete-run-program-all-programs ()
  (interactive)
  (vs/list-complete-run-program (list-directory "/usr/bin")))

(straight-use-package 'org)

(defun vs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Fira Code Retina" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(defun vs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . vs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-clock-sound "~/.emacs.d/timer-stop.wav")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/OrgFiles/Calendar.org"))

  (setq org-image-actual-width nil)

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Calendar.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@school" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work-email")

          ;; Low-effort next actions
          ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            (org-agenda-max-todos 20)
            (org-agenda-files org-agenda-files)))

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")
                   (org-agenda-files org-agenda-files)))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")
                   (org-agenda-files org-agenda-files)))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Project Backlog")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready for Work")
                   (org-agenda-files org-agenda-files)))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled Projects")
                   (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
        `(("t" "Tasks / Projects")
          ("tt" "Task" entry (file+olp "~/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

          ("j" "Journal Entries")
          ("jj" "Journal" entry
           (file+olp+datetree "~/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
          ("jm" "Meeting" entry
           (file+olp+datetree "~/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

          ("w" "Workflows")
          ("we" "Checking Email" entry (file+olp+datetree "~/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

          ("m" "Metrics Capture")
          ("mw" "Weight" table-line (file+headline "~/OrgFiles/Metrics.org" "Weight")
           "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

        (define-key global-map (kbd "C-c j")
          (lambda () (interactive) (org-capture nil "jj")))

        (vs/org-font-setup))

  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    :custom
    (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

  (defun vs/org-mode-visual-fill ()
    (setq visual-fill-column-width 100
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

  (use-package visual-fill-column
    :hook (org-mode . vs/org-mode-visual-fill))

  (setq org-startup-folded t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)))

;; Automatically tangle our Emacs.org config file when we save it
(defun vs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name "~/.my-emacs/"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'vs/org-babel-tangle-config)))

(use-package org-roam
  :custom
  (org-roam-directory "~/Notes")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("l" "programming language" plain
      "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n\n")
      :unnarrowed t)
     ("b" "book notes" plain
      (file "~/Notes/Templates/BookNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
      :unnarrowed t)
     ))
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%H:%M>: %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode)
  (org-roam-setup))

(use-package org-tree-slide
  :after org
  :config
  (define-key org-tree-slide-mode-map (kbd "<f5>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f6>") 'org-tree-slide-move-next-tree))
(global-set-key (kbd "<f8>") 'org-tree-slide-mode)
(global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)

;; Load theme.
(add-to-list 'custom-theme-load-path (expand-file-name "~/.my-emacs/themes/"))
(setq theme-file "~/.my-emacs/theme.el")
(when (file-exists-p theme-file)
  (load theme-file))

(use-package server
  :ensure nil
  :config
  (unless (server-running-p)
    (server-start)))

(use-package counsel-spotify)
(setq counsel-spotify-client-id (vs/lookup-password :host "spotify-emacs-id"))
(setq counsel-spotify-client-secret (vs/lookup-password :host "spotify-emacs-secret"))

(tab-bar-mode)

(defun vs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package exec-path-from-shell)

(use-package eshell
  :hook (eshell-first-time-mode . vs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim" "glances"))))

(use-package vterm
  :ensure t)

(vs/leader-keys
  "t"  '(:ignore t :which-key "Toggles")
  "tt" '(counsel-load-theme :which-key "Choose Theme")
  "o" '(:ignore t :which-key "Org")
  "oa" '(org-agenda-list :which-key "List Org Agenda")
  "ob" '(:ignore t :which-key "Bable")
  "obt" '(org-babel-tangle :which-key "Tangle")
  "b" '(:ignore t :which-key "Buffer")
  "bs" '(consult-buffer :which-key "Switch Buffer")
  "w" '(:ignore :which-key "EXWM")
  "wr" '(exwm-reset)
  "ww" '(exwm-workspace-switch :which-key "Switch workspace")
  "wh" '(windmove-left :which-key "Focus the window to the left")
  "wj" '(windmove-down :which-key "Focus the window down") 
  "wk" '(windmove-up :which-key "Focus the window up")
  "wl" '(windmove-right :which-key "Focus the window to the right")
  "w&" '(lambda (command)
          (interactive (list (read-shell-command "$ ")))
          (start-process-shell-command command nil command))
  "wf" '(exwm-layout-toggle-fullscreen)
  "e" '(:ignore t :which-key "ERC")
  "ej" '(lambda () (interactive)
          (insert "/join #") :which-key "Join")
  "eq" '(lambda () (interactive)
          (insert "/quit")
          (erc-send-current-line) :which-key "Quit")
  "s" '(:ignore t :which-key "Spotify")
  "sP" '(counsel-spotify-toggle-play-pause :which-key "Play/Pause")
  "sn" '(counsel-spotify-next :which-key "Next")
  "sp" '(counsel-spotify-previous :which-key "Previuos")
  "sst" '(counsel-spotify-search-track :which-key "Search Track"))
