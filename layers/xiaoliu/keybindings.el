;;; keybindings.el --- zilongshanren Layer packages File for Spacemacs
;;
;; Copyright (c) 2015-2016 zilongshanren 
;;
;; Author: zilongshanren <guanghui8827@gmail.com>
;; URL: https://github.com/zilongshanren/spacemacs-private
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(global-set-key (kbd "s-/") 'hippie-expand) ;; hippie-expand, funny...

;; A complementary binding to the apropos-command (C-h a)
;; (define-key 'help-command "A" 'apropos)

(define-key global-map (kbd "<f1>") 'zilongshanren/hotspots)
;; (define-key global-map (kbd "C-c y") 'youdao-dictionary-search-at-point+)

;; (global-set-key (kbd "C-.") 'company-capf)


;; some easy functions for navigate functions
;;C-M-a beginning-of-defun
;;C-M-e end-of-defun
;;C-M-h mark-defun
;;
;; (global-set-key (kbd "C-s-h") 'mark-defun)

(bind-key* "C-c /" 'company-files)


(bind-key* "s-;" 'zilongshanren/insert-semicolon-at-the-end-of-this-line)
(bind-key* "C-s-;" 'zilongshanren/delete-semicolon-at-the-end-of-this-line)

(bind-key* "s-," 'zilongshanren/insert-comma-at-the-end-of-this-line)
(bind-key* "C-s-," 'zilongshanren/delete-comma-at-the-end-of-this-line)

(spacemacs/set-leader-keys "ols" 'zilongshanren/load-my-layout)
