(defvar dennisf/default-font-size 130)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code" :height dennisf/default-font-size)
;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code" :height dennisf/default-font-size)
;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Fira Code" :height 130 :weight 'regular)


;(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)
	 ("C-c c" . counsel-compile)
	 ("C-c g" . counsel-git)
	 ("C-c j" . counsel-git-grep)
	 ("C-c L" . counsel-git-log)
	 :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  )

(use-package command-log-mode)

(use-package swiper :ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-g" . ivy-alt-done)
         ("C-n" . ivy-next-line)
         ("C-p" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-p" . ivy-previous-line)
         ("C-g" . ivy-done)
         ("C-k" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-p" . ivy-previous-line)
         ("C-k" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package all-the-icons)
(use-package nerd-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))

;; prog-mode is the base mode of all programming language modes.
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package avy)

(use-package origami)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'python-mode)
              (origami-mode 1))))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "ot" '(origami-toggle-node :which-key "origami toggle node")
    "ou" '(origami-undo :which-key "origami undo")
    "jc" '(avy-goto-char-timer :which-key "type search letter for avy")
    "jw" '(avy-goto-word-1 :which-key "type search letter for avy")
    "jl" '(avy-goto-line :which-key "type search letter for avy")))

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

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
 "ts" '(hydra-text-scale/body :which-key "scale text"))

(defun rune/dont-arrow-me-bro ()
  (interactive)
  (message "Arrow keys are bad, you know?"))

;; Disable arrow keys in normal and visual modes
(define-key evil-normal-state-map (kbd "<left>") 'rune/dont-arrow-me-bro)
(define-key evil-normal-state-map (kbd "<right>") 'rune/dont-arrow-me-bro)
(define-key evil-normal-state-map (kbd "<down>") 'rune/dont-arrow-me-bro)
(define-key evil-normal-state-map (kbd "<up>") 'rune/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<left>") 'rune/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<right>") 'rune/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<down>") 'rune/dont-arrow-me-bro)
(evil-global-set-key 'motion (kbd "<up>") 'rune/dont-arrow-me-bro)

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (
	 (lsp-mode . efs/lsp-mode-setup)
         ;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c++-mode . lsp)
         (c-mode . lsp)
         (python-mode . lsp)
  )
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :hook
   (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
   (c++-mode . lsp)
   (python-mode . lsp)
   ;; if you want which-key integration
   (lsp-mode . lsp-enable-which-key-integration)
   )
  :config
  ;; Arguments given to clangd server. See https://emacs-lsp.github.io/lsp-mode/lsp-mode.html#lsp-clangd
  (setq lsp-clients-clangd-args '(
                                  ;; If set to true, code completion will include index symbols that are not defined in the scopes
                                  ;; (e.g. namespaces) visible from the code completion point. Such completions can insert scope qualifiers
                                  "--all-scopes-completion"
                                  ;; Index project code in the background and persist index on disk.
                                  "--background-index"
                                  ;; Enable clang-tidy diagnostics
                                  "--clang-tidy"
                                  ;; Whether the clang-parser is used for code-completion
                                  ;;   Use text-based completion if the parser is not ready (auto)
                                  "--completion-parse=auto"
                                  ;; Granularity of code completion suggestions
                                  ;;   One completion item for each semantically distinct completion, with full type information (detailed)
                                  "--completion-style=detailed"
                                  ;; clang-format style to apply by default when no .clang-format file is found
                                  "--fallback-style=Chromium"
                                  ;; When disabled, completions contain only parentheses for function calls.
                                  ;; When enabled, completions also contain placeholders for method parameters
                                  "--function-arg-placeholders"
                                  ;; Add #include directives when accepting code completions
                                  ;;   Include what you use. Insert the owning header for top-level symbols, unless the
                                  ;;   header is already directly included or the symbol is forward-declared
                                  "--header-insertion=iwyu"
                                  ;; Prepend a circular dot or space before the completion label, depending on whether an include line will be inserted or not
                                  "--header-insertion-decorators"
                                  ;; Enable index-based features. By default, clangd maintains an index built from symbols in opened files.
                                  ;; Global index support needs to enabled separatedly
                                  "--index"
                                  ;; Attempts to fix diagnostic errors caused by missing includes using index
                                  "--suggest-missing-includes"
                                  ;; Number of async workers used by clangd. Background index also uses this many workers.
                                  "-j=4"
                                  ))
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
         (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/devel")
    (setq projectile-project-search-path '("~/devel")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Org Mode Configuration ------------------------------------------------------

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(defun efs/org-font-setup ()
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
    (set-face-attribute (car face) nil :font "Fira Code" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

;; Merged with evil-collection
;;(use-package evil-magit
;;  :after magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(hydra evil-collection evil general cmake-mode which-key use-package rainbow-delimiters ivy-rich helpful doom-themes doom-modeline counsel command-log-mode all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
