;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq +zen-prose-mode nil)
(setq doom-variable-pitch-font (font-spec :family "Atkinson Hyperlegible" :size 16))
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq display-line-numbers-type 'relative)
(setq org-roam-directory "~/Documents/EilifHLVault/BIDATA/org-roam/")


;; ==========================================================================
;; Custom fonts for Org mode files ONLY
;;
;; This code does two things when an org file is opened:
;; 1. Increases the base font size for better readability.
;; 2. Sets custom, scaled sizes for headlines.
;; ==========================================================================
(defun my-org-font-setup ()
  "Applies buffer-local font settings for Org mode."

  ;; 1. Increase the overall font size for this buffer.
  ;;    The number '2' increases the font by two steps. Adjust as needed.
  ;;    Use a value of '1' for a smaller increase, '0' for no change.
  (text-scale-increase 2)

  ;; 2. Set the font size for headings.
  ;;    The :height property is a multiplier of the base font size.
  ;;    For example, 1.5 means 150% of the (newly increased) base size.
  ;;    This makes the headings proportional to your text.
  (set-face-attribute 'org-level-1 nil :height 1.5 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.3 :weight 'bold)
  (set-face-attribute 'org-level-3 nil :height 1.2 :weight 'bold)
  (set-face-attribute 'org-level-4 nil :height 1.1 :weight 'semi-bold)
  (set-face-attribute 'org-level-5 nil :height 1.0 :weight 'semi-bold)
  ;; You can continue for org-level-6, org-level-7, etc. if you use them.
  )

;; This is the hook that runs the function `my-org-font-setup` every time
;; you open a file in Org mode. The `add-hook!` macro is provided by Doom Emacs.
(add-hook! 'org-mode-hook #'my-org-font-setup)


;; Toggle writing mode
(map! :leader
      :desc "Toggle writeroom-mode"
      "z z" #'writeroom-mode)


(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(setq +latex-viewers '(pdf-tools))

(add-hook 'org-mode-hook 'org-fragtog-mode)


(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.5))
