(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
;; (push '(dired-mode :position top) popwin:special-display-config)
(push '("*Buffer List*" :height 20) popwin:special-display-config)
(push '("*Help*" :height 20) popwin:special-display-config)

;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)

;; minimapaa
;; (require 'minimap)

;; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; helm-swoop
(require 'helm)
(require 'helm-swoop)

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; isearch実行中にhelm-swoopに移行
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; helm-swoop実行中にhelm-multi-swoop-allに移行
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; 値がtの場合はウィンドウ内に分割、nilなら別のウィンドウを使用
(setq helm-swoop-split-with-multiple-windows nil)

;; ウィンドウ分割方向 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; smooth-scroll
(require 'smooth-scroll)
(smooth-scroll-mode t)
(setq smooth-scroll/vscroll-step-size 3)

;; volatile-highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; point-undo
(require 'point-undo)
(define-key global-map (kbd "M-[") 'point-undo)
(define-key global-map (kbd "M-]") 'point-redo)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

;; region-bindings-mode
(require 'region-bindings-mode)
(region-bindings-mode-enable)

(global-set-key (kbd "<C-return>") 'rectangle-mark-mode)
(define-key region-bindings-mode-map "c" 'kill-ring-save)
(define-key region-bindings-mode-map "x" 'kill-region)
(define-key region-bindings-mode-map "v" 'yank)
(define-key region-bindings-mode-map "y" 'yank)
(define-key region-bindings-mode-map "d" 'delete-rectangle)
(define-key region-bindings-mode-map "g" 'keyboard-quit) ;; for quit
(define-key region-bindings-mode-map "q" 'region-bindings-mode-off)
(define-key region-bindings-mode-map "i" 'string-insert-rectangle)
(define-key region-bindings-mode-map "n" 'rectangle-number-lines)

;; load themes
(load-theme 'solarized t)

;; woman
(setq woman-manpath '("/usr/local/jman/share/man/ja_JP.UTF-8/"
                      "/opt/local/share/man"
                      "/usr/local/share/"
                      "/usr/share/man"
                      "/usr/X11/man"))

;; Create cache for woman. C-u M-x woman is for update.
(setq woman-cache-filename (expand-file-name "~/.emacs.d/woman_cache.el"))

;; C-x C-c割り当てる(好にみに応じて)
(global-set-key (kbd "C-x C-c") 'server-edit)

;; M-x exitでEmacsを終了できるようにする
(defalias 'exit 'save-buffers-kill-emacs)

(add-to-load-path "elisp" "conf" "public_repos")

;; for mysettings
(load "setting")
;; (load "test")

(setq org-latex-classes '(("jsarticle"
            "\\documentclass{jsarticle}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage{url}
\\usepackage{atbegshi}
\\AtBeginShipoutFirst{\\special{pdf:tounicode EUC-UCS2}}
\\usepackage[dvipdfmx,setpagesize=false]{hyperref}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
               ("jsbook"
            "\\documentclass{jsbook}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage{url}
\\usepackage{atbegshi}
\\AtBeginShipoutFirst{\\special{pdf:tounicode EUC-UCS2}}
\\usepackage[dvipdfmx,setpagesize=false]{hyperref}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
            ("\\chapter{%s}" . "\\chapter*{%s}")
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
               ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-mode nil)
 '(minimap-window-location (quote right))
 '(volatile-highlights-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vhl/default-face ((t (:inherit region)))))
