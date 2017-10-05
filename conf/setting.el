(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq ruby-insert-encoding-magic-comment nil)
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
;; highlight correnponding parents
(show-paren-mode 1)
(global-set-key "\C-xj" 'goto-line)
(global-hl-line-mode)
(column-number-mode t)
(line-number-mode t)

;; デフォルトのインデント幅を4にし，tabを使用しない
(setq-default tab-width 4 indent-tabs-mode nil)

;; 保存後に行末尾の空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq max-specpdl-size 10000)
(setq max-lisp-eval-depth 10000)

;; フォント
(set-face-attribute 'default nil
                    :family "Cica"
                    :height 140)

(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Cica"))

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

;; C-m is RET
(global-set-key "\C-m" 'newline-and-indent)

;; C-t to other window
(global-set-key "\C-t" 'other-window)

;; C-h is BS, C-d is DEL
(load-library "term/bobcat")
(terminal-init-bobcat)
(setq normal-erase-is-backspace nil)

;; C-zh or C-? to help
(global-unset-key "\C-z")
(global-set-key "\C-zh" 'help)
(global-set-key "\C-z\C-z" 'suspend-emacs)

(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))

;; バッファを再読込
(defun revert-buffer-no-confirm (&optional force-reverting)
  "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
  (interactive "P")
  (message "reverting buffer")
  (if (or force-reverting (not (buffer-modified-p)))
      (revert-buffer :ignore-auto :noconfirm)
    (error "The buffer has been modified")))

(global-set-key (kbd "M-r") 'revert-buffer-no-confirm)

;;; Macのみに有効な設定
(when (eq system-type 'darwin)
  ;; 右のCommandキーをMetaキーとして使用
  (setq mac-right-command-modifier 'meta))

;; make backup files and autosave files to backups dir
(setq backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backups/" t)))

;; mouse wheel control

;; one line at a time
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; don't accelerate scrolling
(setq mouse-wheel-progressive-speed nil)

;; Don't ring the bell when mouse-wheel scrolling

(setq ring-bell-function 'my-ring-bell-function)

(defun my-ring-bell-function ()
  (if (eq last-command 'mwheel-scroll)
      () ;; ignore
    (ding)))

;; for debug
;; (defun my-ring-bell-function ()
;;   (message (format "last-command-event: %s" last-command-event)))
