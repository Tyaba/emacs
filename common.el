;; default char encoding system as utf-8
(set-default-coding-systems 'utf-8)
 
;; enable 'package' and add package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
 
; region coloer enable
(global-font-lock-mode t)
 
;; C-c c to compile
;; C-c n to next-error 
(define-key mode-specific-map "c" 'compile)
(define-key mode-specific-map "n" 'next-error)
 
;; C-c n to find file
(define-key mode-specific-map "n" 'find-name-dired)
 
;; C-c g to goto line
(define-key mode-specific-map "g" 'goto-line)
 
;; do not show startup-message
(setq inhibit-startup-message t)
 
;; C-k to remove all of the line
(setq kill-whole-line t)
 
;; C-h to type "backspace" key
(keyboard-translate ?\C-h ?\C-?)
 
;; do not make backup file (name starts with "#")
(setq make-backup-files nil)
(setq auto-save-default nil)
 
;;BEEP disable
(setq ring-bell-function 'ignore)
 
;; scroll each line
(setq vertical-centering-font-regexp ".*")
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)
 
;; set tab width  4
(setq-default tab-width 4)
(setq default-tab-width 4)
 
;; display corresponding parens
(show-paren-mode 1)
 
;;quickly key stroke
(setq echo-keystroke 0.1)
 
;; yes-no -&gt; y-n
(defalias 'yes-or-no-p 'y-or-n-p)
 
;; show current time in the mode line
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-string-forms '(24-hours ":" minutes))
(display-time-mode t)
 
;; always enable region color
(setq transient-mark-mode t)
 
;; delete old back up files automatically
(setq delete-old-versions t)
 
;; open *.emacs files as elisp-mode
(setq auto-mode-alist (cons '("\\.emacs" . emacs-lisp-mode) auto-mode-alist))
 
 
;; show functions name where the cursor is
(which-function-mode 1)
 
;; do not distingish letter case
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
 
;; display batery status
(require 'battery)
(display-battery-mode t)
 
;; enter fullscreen mode with "Alt+RET"
(global-set-key (kbd "M-RET") 'toggle-frame-fullscreen)
 
;; indenting switch
(c-set-offset 'case-label '+)
 
(require 'helm-config)
(helm-mode 1)
 
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "C-c f") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "M-r")     'helm-resume)
(define-key global-map (kbd "C-M-h")   'helm-apropos)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
 
; enable migemo wher package is installed
(when (require 'migemo nil t)
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))
 
;; enable dired-alternate-file
(put 'dired-find-alternate-file 'disabled nil)
 
;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
 
;; open the file in another buffer, but directory
(defun dired-open-in-accordance-with-situation ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (dired-find-alternate-file)
      (dired-find-file))))
 
;; use dired-find-alternate-file
(define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)
(define-key dired-mode-map (kbd "a") 'dired-find-file)
 
;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
 
; auto-complete
(require 'auto-complete-config)
(ac-config-default)
; global auto-complete
(global-auto-complete-mode t)
 
 
;; shell pop
(require 'shell-pop)
(custom-set-variables
 '(shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
 '(shell-pop-term-shell "/bin/bash")
; '(shell-pop-universal-key "C-t")
 '(shell-pop-window-height 60)
 '(shell-pop-window-position "bottom"))
;; C-c t to use terminal
(define-key mode-specific-map "t" 'shell-pop)
 
;; move to trash instead of remove
(setq delete-by-moving-to-trash t)
 
;; byte-complie automatically
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "~/tmp/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
 
;; open-junk-file
(require 'open-junk-file)
(define-key mode-specific-map "o" 'open-junk-file)
 
 
; add newline to bottom of file
(setq require-final-newline t)
; do not add newline with "C-n"
(setq next-line-add-newlines nil)
 
(setq c-mode-hook
      '(lambda ()
         (c-set-style "java")))
 
