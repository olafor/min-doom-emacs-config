;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Carl Ola Fornander")
(setq user-email-address "o.fornander@gmail.com")
(setq calendar-location-name "Lund")

(after! org
; AGENDA/KALENDER
(load! "sv-kalender.el")
(require 'sv-kalender)
(setq org-agenda-span 8)
(setq org-agenda-start-on-weekday nil)
(setq org-deadline-warning-days 0)
(setq calendar-week-start-day 1)

(setq org-agenda-files '(
  "~/org/inkorg.org"
  "~/org/gtd.org"
  "~/org/notifierare.org"
  "~/org/vanor.org"))

(setq org-refile-targets '(("~/org/gtd.org" :maxlevel . 3)
    ("~/org/eventuellt.org" :level . 1)
    ("~/org/notifierare.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-custom-commands
    '(("o" "På kontoret" tags-todo "@kontoret"
       ((org-agenda-overriding-header "Kontoret")))))

(setq org-log-done 'time)
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

(setq org-default-notes-file (concat org-directory "~/org/anteckningar.org"))
) ; after! org

(after! org-capture
; GTP-specifikt
(setq org-capture-templates '(
("a" "Anteckning"
    entry
    (file+datetree "~/org/anteckningar.org")
    "* %?\nEntered on %U\n  %i\n\n")

("t" "Todo [inkorg]"
    entry
    (file+headline "~/org/inkorg.org" "Tasks")
    "* TODO %?\n  %iEntered on %U\n")

("i" "Idéer"
    entry (file+headline "~/org/anteckningar.org" "Idéer")
    "* %?\n  %iEntered on %U\n")

("n" "Notifierare"
        entry
    (file+headline "~/org/notifierare.org" "Tasks")
    "* TODO %?\n  %iEntered on %U\n")

("j" "Journal"
    entry
    (file+datetree "~/org/journal.org")
    "* Entered on %U%i\n%?")

("m" "Mat"
    table-line
    (file+headline "~/org/fysik.org" "Matschema")
    "|%U| 0 %? | 0 | 0 |")

("f" "Fysik"
    table-line
    (file+headline "~/org/fysik.org" "Fysik")
    "|%U| %? |  |  | |")

("c" "Cloud"
    entry
    (file+headline "~/org/moln.org" "Ofiltrerat")
    "*  %? %i\n")

("M" "Musik"
    entry
    (file+headline "~/org/musik.org" "Musik")
    "* %?\nEntered on %U\n  %i\n")

("b" "Bokmärke"
    entry
    (file+datetree "~/org/bokmarken.org")
    "* %?\nEntered on %U\n  %i\n")

("B" "Bok färdigläst"
    entry
    (file+headline "~/org/libros.org" "Böcker")
    "* %^{Titel} -- %^{Författare}\n%t\n")

("p" "Finished paper"
    entry
    (file+headline "~/org/papers-read.org" "Papers")
    "* %^{Title} -- %^{Author}\n%t\n")
))) ; after! org-capture

;; Org-habit
(use-package! org-habit
  :after org
  :config
  (setq org-habit-following-days 7
        org-habit-preceding-days 35
        org-habit-show-habits t))

(setq org-export-with-sub-superscripts nil)

(set-face-attribute 'default nil :height 200)

;(setq doom-font (font-spec :family "Fira Mono" :size 12))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
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
