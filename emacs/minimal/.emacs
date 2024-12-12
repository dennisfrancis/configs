; Disable the menu bar
(menu-bar-mode -1)

;; Set up the visible bell
(setq visible-bell t)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Install these packages
;; helm avy clang-format lsp-mode lsp-ui flycheck treemacs lsp-treemacs

;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(global-set-key [remap list-buffers] 'ibuffer)
(global-set-key (kbd "M-o") 'other-window)
(windmove-default-keybindings)

(global-set-key (kbd "C-x t <left>") 'tab-bar-history-back)
(global-set-key (kbd "C-x t <right>") 'tab-bar-history-forward)

(global-set-key (kbd "M-g l") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)

(global-set-key (kbd "M-i") 'imenu)

(ido-mode 1)
;; (setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(helm-mode 1)


(defun my-c-mode-common-hook ()
 ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
 (c-set-offset 'substatement-open 0)
 ;; other customizations can go here

 (setq c++-tab-always-indent t)
 (setq c-basic-offset 4)                  ;; Default is 2
 (setq c-indent-level 4)                  ;; Default is 2

 (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
 (setq tab-width 4)
 (setq indent-tabs-mode t)  ; use spaces only if nil
 )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(require 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp)
(define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
(add-hook 'c-mode-common-hook
          (lambda () (local-set-key (kbd "C-\\") #'completion-at-point)))

(global-set-key (kbd "M-L") 'kill-whole-line)

(global-set-key (kbd "C-x /") 'comment-line)
(global-set-key (kbd "M-j") 'comment-indent-new-line)

(global-set-key (kbd "C-x M-%") 'query-replace-regexp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(global-display-line-numbers-mode t)
 '(indent-tabs-mode nil)
 '(isearch-allow-motion t)
 '(lsp-diagnostics-provider :flycheck)
 '(lsp-ui-sideline-show-code-actions t)
 '(package-selected-packages
   '(lsp-treemacs treemacs flycheck lsp-ui lsp-mode clang-format helm avy))
 '(tab-bar-history-mode t)
 '(tab-bar-mode t)
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
