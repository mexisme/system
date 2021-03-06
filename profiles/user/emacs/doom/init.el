;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom!

 :completion
 company
 (ivy
  ;; +fuzzy
  +prescient
  ;; +childframe ; TODO: https://github.com/hlissner/doom-emacs/labels/%3Acompletion%20ivy
  +icons)

 :ui
 deft
 doom
 doom-dashboard
 doom-quit
 fill-column
 hl-todo
 modeline
 nav-flash
 ophints
 (popup
  +defaults)
 ;;tabs
 treemacs
 unicode
 vc-gutter
 vi-tilde-fringe
 window-select
 workspaces
 zen

 :editor
 (evil +everywhere)
 file-templates
 fold
 (format +onsave)
 lispy
 multiple-cursors
 rotate-text
 snippets

 :emacs
 (dired
  +icons)
 electric
 ibuffer
 undo
 vc

 :term
 eshell
 vterm

 :checkers
 syntax
 ;;spell
 ;;grammar

 :tools
 (debugger +lsp)
 direnv
 editorconfig
 (eval +overlay)
 (lookup
  +docsets)
 (lsp +peek)
 magit
 pdf
 rgb
 ;;upload

 :lang
 assembly
 (cc +lsp)
 data
 emacs-lisp
 (go +lsp)
 (javascript +lsp)
 (latex +latexmk +lsp)
 markdown
 nix
 (org
  +dragndrop
  +hugo
  +noter
  +pandoc
  +pomodoro
  +present
  +roam
  )
 ;;raku
 (python +lsp)
 (sh +fish)
 web
 yaml

 :email
 notmuch

 :app
 irc
 (rss +org)

 :config
 ;;literate
 (default +bindings +smartparens))
