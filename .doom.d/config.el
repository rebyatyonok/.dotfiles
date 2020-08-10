;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "ivan petrakov"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-material)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


(setq
  +ivy-project-serach-engine '(rg)
  company-prescient-mode 'nil
  projectile-project-search-path '("~/code/" "~/code/leetcode/" "~/.hammerspoon/" "~/code/haskell/")
  doom-themes-treemacs-theme "Default")

(setq web-mode-ac-sources-alist
  '(("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
    ("css" . (ac-source-css-property ac-source-emmet-css-snippets))))

(use-package emmet-mode
  :custom
  (emmet-indentation 2))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "TAB") 'company-complete-selection))

(use-package web-mode
  :custom
  (web-mode-enable-auto-expanding t)
  (web-mode-enable-auto-closing t)
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-enable-current-column-highlight t)
  (web-mode-enable-current-element-highlight t))

(defun vue-no-indent-style-and-scripts()
  (when (string= (file-name-extension buffer-file-name) "vue")
    (setq web-mode-script-padding 0)
    (setq web-mode-style-padding 0)))

(add-hook! 'web-mode-hook 'vue-no-indent-style-and-scripts)

(after! web-mode
  (setq company-web-html-emmet-enable nil))

(after! js2-mode
  (setq js2-basic-offset 2))

(use-package lsp-vetur
  :custom
  (lsp-vetur-emmet "always"))

(use-package treemacs
  :config (setq treemacs-no-png-images t))

(use-package flycheck
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enable)
        flycheck-rust-clippy-executable "~/.cargo/bin/clippy-driver")
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(use-package lsp-mode
  :config
  (setq company-idle-delay 0.1
        lsp-rust-server 'rls
        lsp-rust-analyzer-display-parameter-hints 't
        lsp-rust-clippy-preference "on"
        lsp-rust-analyzer-proc-macro-enable 't))

(after! lsp-mode
  (lsp-ui-mode t))

(add-hook 'rust-mode-hook
          (lambda () (push 'rustic-clippy 'flycheck-checkers)
            (flycheck-select-checker 'rustic-clippy 'lsp)))

(use-package avy
  :config
  (setq avy-timeout-seconds 0.3
        avy-all-windows t
        avy-background nil
        avy-single-candidate-jump t))

(evil-global-set-key
 'normal (kbd "H")
 (lambda ()
   (interactive)
   (evil-first-non-blank)))

(evil-global-set-key
 'normal (kbd "L")
 (lambda ()
   (interactive)
   (evil-last-non-blank)))
