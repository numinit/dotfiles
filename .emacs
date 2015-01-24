;; =========
;; LOAD PATH
;; =========

;; Recursively add ~/.emacs.d/lisp to the load path
(let ((default-directory "~/.emacs.d/lisp/"))
      (normal-top-level-add-subdirs-to-load-path))

;; ========
;; REQUIRES
;; ========

;; Require things
(require 'cl)                   ; Some Emacs helper functions
(require 'exec-path-from-shell) ; Get the right $PATH
(require 'auto-complete-config) ; Autocomplete
(require 'ruby-electric)        ; Better Ruby
(require 'markdown-mode)        ; Markdown
(require 'coffee-mode)          ; CoffeeScript
(require 'minimap)              ; Sublime Text-style minimap
(require 'git-emacs)            ; git
(require 'color-theme-oblivion) ; Oblivion theme

;; =====
;; HOOKS
;; =====

; auto-mode-alist for common file extensions
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . rhtml-mode))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

; Ruby-mode hooks
(add-hook 'ruby-mode-hook (lambda ()
			    (add-to-list 'ac-sources 'ac-source-rsense-method)
			    (add-to-list 'ac-sources 'ac-source-rsense-constant)
			    (auto-complete-mode)
			    (ac-complete-rsense)
			    (ruby-electric-mode)))

(add-hook 'el4r-mode-hook (lambda ()
			    (add-to-list 'ac-sources 'ac-source-rsense-method)
			    (add-to-list 'ac-sources 'ac-source-rsense-constant)
			    (auto-complete-mode)
			    (ac-complete-rsense)
			    (ruby-electric-mode)))

; Python-mode hooks
(add-hook 'python-mode-hook
      (lambda ()
        (setq indent-tabs-mode nil)
        (setq tab-width 4)
        (setq python-indent 4)
	(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
	(auto-complete-mode)
	(lambda-mode)))

; ansi-term hooks
(add-hook 'term-mode-hook (lambda ()
			    (setq show-trailing-whitespace nil)
			    (define-key term-raw-map (kbd "C-y") 'term-paste)))

; Don't save backup files in the current directory
(setq backup-directory-alist `(("." . "~/.emacs.d/backup")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(defvar autosave-dir "~/.emacs.d/autosave")
(make-directory autosave-dir t)
(setq auto-save-file-name-transforms
      `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat autosave-dir "\\1") t)))

; Disable the splash screen
(setq inhibit-splash-screen t)

; Oblivion theme
(color-theme-oblivion)

; Tabs
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq js-indent-level 2)
(setq css-indent-level 2)
(setq css-indent-offset 2)

; Custom set variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-for-comint-mode t)
 '(cursor-type t t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(face-font-family-alternatives (quote (("arial black" "arial" "DejaVu Sans") ("arial" "DejaVu Sans") ("verdana" "DejaVu Sans"))))
 '(font-lock-keywords-case-fold-search t t)
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(minimap-always-recenter t)
 '(minimap-buffer-name-prefix "*map*")
 '(minimap-hide-fringes t)
 '(minimap-recenter-type (quote free))
 '(minimap-update-delay 0.05)
 '(minimap-width-fraction 0.15)
 '(show-trailing-whitespace t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 142 :width normal :foundry "apple" :family "Inconsolata"))))
 '(font-lock-comment-face ((t (:foreground "#888a85"))))
 '(minimap-active-region-background ((t (:background "#c41130202020"))))
 '(minimap-font-face ((t (:height 50 :width condensed :family "Monaco")))))

;; ===
;; X11
;; ===

;; Change colors if in an X server
(when (memq window-system '(mac ns))
  (run-with-idle-timer 0.5 nil 'ns-toggle-toolbar)
  (set-frame-parameter (selected-frame) 'alpha '(90 85))
  (add-to-list 'default-frame-alist '(alpha 90 85))
  (scroll-bar-mode -1)
  (exec-path-from-shell-initialize)
)

(when window-system
  (desktop-save-mode 1)

  ;; use only one desktop
  (setq desktop-path '("~/.emacs.d/desktop"))
  (setq desktop-dirname "~/.emacs.d/desktop")
  (setq desktop-base-file-name "emacs-desktop")
)

;; Try to fix a term bug
(defun bug-evil-term-process-coding-system ()
  "Fix a term bug; the `process-coding-system' should always be `binary'."
  (set-buffer-process-coding-system 'binary 'binary))
(add-hook 'term-exec-hook 'bug-evil-term-process-coding-system)

;; ======
;; Macros
;; ======

(defun botsbuildbots () (botsbuildbots))

(defun iwb ()
  "Indents the entire buffer."
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;; ===========
;; Keybindings
;; ===========

(global-set-key (kbd "C-` C-m") 'minimap-toggle)
