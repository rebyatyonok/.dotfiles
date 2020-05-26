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
  company-prescient-mode 'nil
  projectile-project-search-path '("~/code/" "~/code/leetcode/" "~/.hammerspoon/")
  doom-themes-treemacs-theme "Default")

(setq web-mode-ac-sources-alist
  '(("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
    ("css" . (ac-source-css-property ac-source-emmet-css-snippets))))

(use-package web-mode
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-enable-current-column-highlight t)
  (web-mode-enable-current-element-highlight t))

(use-package treemacs
  :config (setq treemacs-no-png-images t))

(add-hook 'web-mode-hook
  (lambda () (setq js2-basic-offset 2
        default-tab-width 2)))

(use-package flycheck
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enable)
        flycheck-rust-clippy-executable "~/.cargo/bin/clippy-driver")
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(use-package lsp-mode
  :config
  (setq company-idle-delay 0.1
        lsp-rust-analyzer-display-parameter-hints 't
        lsp-rust-clippy-preference "on"
        lsp-rust-analyzer-proc-macro-enable 't))

(add-hook 'rust-mode-hook
          (lambda () (push 'rustic-clippy 'flycheck-checkers)
            (flycheck-select-checker 'rustic-clippy 'lsp)))

;; (after! rustic
;;   (setq rustic-lsp-server 'rust-analyzer))
