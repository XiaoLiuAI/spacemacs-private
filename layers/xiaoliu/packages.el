;;; packages.el --- xiaoliu Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq xiaoliu-packages
      '(
        find-file-in-project ;; better file finder
        visual-regexp-steroids ;; highlight regex results on the fly
        command-log ;; command history
        ;; ycmd ;; code completion system
        discover-my-major ;; discover key bindings
        ;; not for editing
        ;; elfeed ;; web feed reader
        ;; prodigy ;; manage services
        ;; languages
        ;; lua-mode
        ;; (gulpjs :location (recipe :fetcher github :repo "zilongshanren/emacs-gulpjs"))
        ;; nodejs-repl
        ;; Github
        helm-github-stars;; github stared repositories
        ;; dictionary
        chinese-word-at-point
        osx-dictionary
        ;; youdao-dictionary
        ;; lisp
        ;; lispy
        ;; litable

        pangu-spacing

        ;; text notes
        ox-reveal ;; export org to HTML presentation
        org-mac-link ;; insert a link of/from an open mac application
        org-octopress
        org-jekyll
        org-tree-slide

        (cc-mode :location built-in)
        (org :location built-in)
        projectile
        persp-mode
        org-pomodoro
        org-bullets
        multiple-cursors
        js2-mode
        company-c-headers
        ))

(defun xiaoliu/init-command-log ()
  (use-package command-log
    :config
    (with-eval-after-load 'command-log-mode
      (setq clm/log-command-exceptions* (append clm/log-command-exceptions*
                                                '(evil-next-visual-line
                                                  evil-previous-visual-line))))))
(defun xiaoliu/init-pangu-spacing ()
  (use-package pangu-spacing
    :config
    (progn
      ;; add toggle options
      (spacemacs|add-toggle toggle-pangu-spaceing
        :status pangu-spacing-mode
        :on (global-pangu-spacing-mode)
        :off (global-pangu-spacing-mode -1)
        :documentation "Toggle pangu spacing mode"
        :evil-leader "ots")
      (add-hook 'markdown-mode-hook
                '(lambda ()
                   (set (make-local-variable 'pangu-spacing-real-insert-separtor) t))))))

;; (defun xiaoliu/init-litable ()
;;   (use-package litable
;;     :init))

(defun xiaoliu/init-chinese-word-at-point ()
    (use-package chinese-word-at-point
      :init))

(defun xiaoliu/init-chinese-fonts-setup ()
  (use-package chinese-fonts-setup
    :init))

(defun xiaoliu/init-osx-dictionary ()
  (use-package osx-dictionary
    :init
    (progn
      (evilified-state-evilify osx-dictionary-mode osx-dictionary-mode-map)
      (setq osx-dictionary-use-chinese-text-segmentation t)
      (global-set-key (kbd "C-c d") 'osx-dictionary-search-pointer)
      )))

;; (defun xiaoliu/init-gulpjs ()
;;   (use-package gulpjs
;;     :init
;;     (progn
;;       (spacemacs/set-leader-keys "ags" 'gulpjs-start-task)
;;       (spacemacs/set-leader-keys "agr" 'gulpjs-restart-task))))

;; git clone https://github.com/hakimel/reveal.js.git to the right location that can be loaded
(defun xiaoliu/init-ox-reveal ()
  (use-package ox-reveal
    :defer t
    :init
    (progn
      (setq org-reveal-root "reveal.js"))))

(defun xiaoliu/init-org-mac-link ()
  (use-package org-mac-link
    :init
    (add-hook 'org-mode-hook
              (lambda ()
                (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))))

(defun xiaoliu/init-discover-my-major ()
  (use-package discover-my-major
    :defer t
    :init
    (progn
      (spacemacs/set-leader-keys (kbd "mhm") 'discover-my-major)

      (evilified-state-evilify makey-key-mode makey-key-mode-get-key-map))))

;; (defun xiaoliu/post-init-ycmd ()
;;   (progn
;;     (setq ycmd-tag-files 'auto)
;;     (setq ycmd-request-message-level -1)
;;     (set-variable 'ycmd-server-command `("python" ,(expand-file-name "~/Github/ycmd/ycmd/__main__.py")))
;;     (setq company-backends-c-mode-common '((company-c-headers
;;                                             company-dabbrev-code
;;                                             company-keywords
;;                                             company-gtags :with company-yasnippet)
;;                                            company-files company-dabbrev ))

;;     (zilongshanren|toggle-company-backends company-ycmd)
;;     (eval-after-load 'ycmd
;;       '(spacemacs|hide-lighter ycmd-mode))

;;     (spacemacs/set-leader-keys-for-major-mode 'c-mode
;;       "tb" 'zilong/company-toggle-company-ycmd)
;;     (spacemacs/set-leader-keys-for-major-mode 'c++-mode
;;       "tb" 'zilong/company-toggle-company-ycmd)))

;; (defun xiaoliu/post-init-lua-mode ()
;;   (progn
;;     (when (configuration-layer/package-usedp 'company)
;;       (push 'company-dabbrev company-backends-lua-mode)
;;       (push 'company-etags company-backends-lua-mode))
;;     (add-hook 'lua-mode-hook 'evil-matchit-mode)
;;     (add-hook 'lua-mode-hook 'smartparens-mode)
;;     (setq lua-indent-level 4)

;;     (spacemacs/set-leader-keys-for-major-mode 'lua-mode
;;       "<tab>" 'hs-toggle-hiding
;;       "gg" 'helm-gtags-dwim
;;       "gr" 'helm-gtags-find-rtag
;;       "gs" 'helm-gtags-find-symbol
;;       "gf" 'helm-gtags-find-files)))

;; (defun xiaoliu/post-init-elfeed ()
;;   (use-package elfeed
;;     :init
;;     (global-set-key (kbd "C-x w") 'elfeed)
;;     :defer t
;;     :config
;;     (progn

;;       (setq elfeed-feeds
;;             '("http://nullprogram.com/feed/"
;;               "http://z.caudate.me/rss/"
;;               "http://irreal.org/blog/?feed=rss2"
;;               "http://feeds.feedburner.com/LostInTheTriangles"
;;               "http://tonybai.com/feed/"
;;               "http://planet.emacsen.org/atom.xml"
;;               "http://feeds.feedburner.com/emacsblog"
;;               "http://blog.binchen.org/rss.xml"
;;               "http://oremacs.com/atom.xml"
;;               "http://blog.gemserk.com/feed/"
;;               "http://www.masteringemacs.org/feed/"
;;               "http://t-machine.org/index.php/feed/"
;;               "http://gameenginebook.blogspot.com/feeds/posts/default"
;;               "http://feeds.feedburner.com/ruanyifeng"
;;               "http://coolshell.cn/feed"
;;               "http://blog.devtang.com/atom.xml"
;;               "http://emacsist.com/rss"
;;               "http://puntoblogspot.blogspot.com/feeds/2507074905876002529/comments/default"
;;               "http://angelic-sedition.github.io/atom.xml"))

;;       ;; (evilify elfeed-search-mode elfeed-search-mode-map)
;;       (evilified-state-evilify-map elfeed-search-mode-map
;;         :mode elfeed-search-mode
;;         :bindings
;;         "G" 'elfeed-update
;;         "g" 'elfeed-search-update--force)

;;       (defun elfeed-mark-all-as-read ()
;;         (interactive)
;;         (mark-whole-buffer)
;;         (elfeed-search-untag-all-unread))

;;       (define-key elfeed-search-mode-map (kbd "R") 'elfeed-mark-all-as-read)

;;       (defadvice elfeed-show-yank (after elfeed-show-yank-to-kill-ring activate compile)
;;         "Insert the yanked text from x-selection to kill ring"
;;         (kill-new (x-get-selection)))

;;       (ad-activate 'elfeed-show-yank))))

(defun xiaoliu/init-helm-github-stars ()
  (use-package helm-github-stars
    :defer t
    :config
    (progn
      (setq helm-github-stars-username "xiaoliuai")
      (setq helm-github-stars-cache-file "~/.emacs.d/.cache/hgs-cache"))))



;; (defun xiaoliu/post-init-lispy ()
;;   (with-eval-after-load 'lispy
;;     (progn
;;       (define-key lispy-mode-map (kbd "s-1") 'lispy-describe-inline)
;;       (define-key lispy-mode-map (kbd "s-2") 'lispy-arglist-inline))))

;; (defun xiaoliu/post-init-company-c-headers ()
;;   (progn
;;     (setq company-c-headers-path-system
;;           (quote
;;            ("/usr/include/" "/usr/local/include/" "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1")))
;;     ;; (setq company-c-headers-path-user
;;     ;;       (quote
;;     ;;        ("/Users/xiaoliu/cocos2d-x/cocos/platform" "/Users/guanghui/cocos2d-x/cocos" "." "/Users/guanghui/cocos2d-x/cocos/audio/include/")))
;;     ))

;; (defun xiaoliu/post-init-nodejs-repl ()
;;   (progn
;;     (spacemacs/declare-prefix-for-mode 'js2-mode
;;                                        "ms" "REPL")
;;     (spacemacs/set-leader-keys-for-major-mode 'js2-mode
;;       "sb" 'nodejs-repl-eval-buffer
;;       "sf" 'nodejs-repl-eval-function
;;       "sd" 'nodejs-repl-eval-dwim)))

(defun xiaoliu/init-visual-regexp-steroids ()
  (use-package visual-regexp-steroids
    :config
    (progn
      (define-key global-map (kbd "C-c r") 'vr/replace)
      (define-key global-map (kbd "C-c q") 'vr/query-replace))
    )
  )

;; (defun xiaoliu/init-multiple-cursors ()
;;   (use-package multiple-cursors
;;     :init
;;     (progn
;;       (bind-key* "C-s-l" 'mc/edit-lines)
;;       (bind-key* "C-s-f" 'mc/mark-all-dwim)
;;       (bind-key* "C-s-." 'mc/mark-next-like-this)
;;       (bind-key* "C-s-," 'mc/mark-previous-like-this)
;;       (bind-key* "s->" 'mc/unmark-next-like-this)
;;       (bind-key* "s-<" 'mc/unmark-previous-like-this)
;;       (bind-key* "C-c C-s-." 'mc/mark-all-like-this)

;;       ;; http://endlessparentheses.com/multiple-cursors-keybinds.html?source=rss
;;       (define-prefix-command 'endless/mc-map)
;;       ;; C-x m is usually `compose-mail'. Bind it to something
;;       ;; else if you use this command.
;;       (define-key ctl-x-map "m" 'endless/mc-map)
;; ;;; Really really nice!
;;       (define-key endless/mc-map "i" #'mc/insert-numbers)
;;       (define-key endless/mc-map "h" #'mc-hide-unmatched-lines-mode)
;;       (define-key endless/mc-map "a" #'mc/mark-all-like-this)

;; ;;; Occasionally useful
;;       (define-key endless/mc-map "d" #'mc/mark-all-symbols-like-this-in-defun)
;;       (define-key endless/mc-map "r" #'mc/reverse-regions)
;;       (define-key endless/mc-map "s" #'mc/sort-regions)
;;       (define-key endless/mc-map "l" #'mc/edit-lines)
;;       (define-key endless/mc-map "\C-a" #'mc/edit-beginnings-of-lines)
;;       (define-key endless/mc-map "\C-e" #'mc/edit-ends-of-lines)
;;       )))

;; (defun xiaoliu/post-init-persp-mode ()
;;   (when (fboundp 'spacemacs|define-custom-layout)
;;     (spacemacs|define-custom-layout "@Cocos2D-X"
;;       :binding "c"
;;       :body
;;       (find-file "~/cocos2d-x/cocos/ui/UIWidget.cpp")
;;       (split-window-right)
;;       (find-file "~/cocos2d-x/cocos/cocos2d.cpp"))))

;; (defun xiaoliu/post-init-youdao-dictionary ()
;;   (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+))

;; (defun xiaoliu/post-init-cc-mode ()
;;   (progn
;;     ;; http://stackoverflow.com/questions/23553881/emacs-indenting-of-c11-lambda-functions-cc-mode
;;     (defadvice c-lineup-arglist (around my activate)
;;       "Improve indentation of continued C++11 lambda function opened as argument."
;;       (setq ad-return-value
;;             (if (and (equal major-mode 'c++-mode)
;;                      (ignore-errors
;;                        (save-excursion
;;                          (goto-char (c-langelem-pos langelem))
;;                          ;; Detect "[...](" or "[...]{". preceded by "," or "(",
;;                          ;;   and with unclosed brace.
;;                          (looking-at ".*[(,][ \t]*\\[[^]]*\\][ \t]*[({][^}]*$"))))
;;                 0                       ; no additional indent
;;               ad-do-it)))               ; default behavior


;;     (setq c-default-style "linux") ;; set style to "linux"
;;     (setq c-basic-offset 4)
;;     (c-set-offset 'substatement-open 0)
;;     (with-eval-after-load 'c++-mode
;;       (define-key c++-mode-map (kbd "s-.") 'company-ycmd)))
;;   ;; company backend should be grouped
;;   )

(defun xiaoliu/post-init-org-bullets ()
  (setq org-bullets-bullet-list '("🐉" "🐠" "🐬" "🐤")))

(defun xiaoliu/post-init-org-pomodoro ()
  (progn
    (add-hook 'org-pomodoro-finished-hook '(lambda () (zilongshanren/growl-notification "Pomodoro Finished" "☕️ Have a break!" t)))
    (add-hook 'org-pomodoro-short-break-finished-hook '(lambda () (zilongshanren/growl-notification "Short Break" "🐝 Ready to Go?" t)))
    (add-hook 'org-pomodoro-long-break-finished-hook '(lambda () (zilongshanren/growl-notification "Long Break" " 💪 Ready to Go?" t)))
    ))

;; (defun xiaoliu/post-init-js2-mode ()
;;   (progn
;;     (setq company-backends-js2-mode '((company-dabbrev-code
;;                                        company-keywords
;;                                        company-etags) company-files company-dabbrev))

;;     (zilongshanren|toggle-company-backends company-tern)


;;     (spacemacs/set-leader-keys-for-major-mode 'js2-mode
;;       "tb" 'zilong/company-toggle-company-tern)

;;     (spacemacs/set-leader-keys-for-major-mode 'js2-mode
;;       "ga" 'projectile-find-other-file
;;       "gA" 'projectile-find-other-file-other-window)

;;     (spacemacs/set-leader-keys-for-major-mode 'web-mode
;;       "ga" 'projectile-find-other-file
;;       "gA" 'projectile-find-other-file-other-window)
;;     (eval-after-load 'js2-mode
;;       '(progn
;;          (add-hook 'js2-mode-hook (lambda () (setq mode-name "JS2")))
;;          (define-key js2-mode-map   (kbd "s-.") 'company-tern)))))

(defun xiaoliu/init-org-tree-slide ()
  (use-package org-tree-slide
    :init
    (spacemacs/set-leader-keys "oto" 'org-tree-slide-mode)))

;; for blog
(defun xiaoliu/init-org-octopress ()
  (use-package org-octopress
    :init
    (progn
      (evilified-state-evilify org-octopress-summary-mode org-octopress-summary-mode-map)
      (add-hook 'org-octopress-summary-mode-hook
                #'(lambda () (local-set-key (kbd "q") 'bury-buffer)))
      (setq org-blog-dir "~/WorkSpace/xiaoliuai.github.io/")
      (setq org-octopress-directory-top org-blog-dir)
      (setq org-octopress-directory-posts (concat org-blog-dir "source/_posts"))
      (setq org-octopress-directory-org-top org-blog-dir)
      (setq org-octopress-directory-org-posts "~/Emacs/org/blog") ;; to be uploaded into dropbox
      (setq org-octopress-setup-file (concat org-blog-dir "source/org-sty/setupfile.org"))
      ;; add org-octopress project setting into project list and then use standard org-publish function to publish it.
      ;; org-octopress project setting uses org-jekyll-publish-to-html to publish each file, don't recursively discover files because it manage blog files flatly with date prefix in file name.
      ;; 其实也是有道理的,就算我欣赏 org-jekyll 导出章节的功能,文件夹结构也确实没有多大意义了.好吧,我调整调整
      (defun xiaoliu/org-save-and-export ()
        (interactive)
        (org-octopress-setup-publish-project)
        (org-jekyll-export-project "jektopress" t))

      (spacemacs/set-leader-keys "op" 'zilongshanren/org-save-and-export)
      )))

;; for all org files: notes, gtd
(defun xiaoliu/post-init-org ()
  (with-eval-after-load 'org
    (progn
      ;; define the refile targets
      (setq org-agenda-files (quote ("~/Emacs/org/" )))
      (setq org-default-notes-file "~/Emacs/org/gtd.org")

      (with-eval-after-load 'org-agenda
        (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))
      ;; the %i would copy the selected text into the template
      ;;http://www.howardism.org/Technical/Emacs/journaling-org.html
      ;;add multi-file journal
      (setq org-capture-templates
            '(("t" "Todo" entry (file+headline "~/Emacs/org/gtd.org" "Workspace")
               "* TODO [#B] %?\n  %i\n"
               :empty-lines 1)
              ("n" "notes" entry (file+headline "~/Emacs/org/notes.org" "Quick notes")
               "* TODO [#C] %?\n  %i\n %U"
               :empty-lines 1)
              ("b" "Blog Ideas" entry (file+headline "~/Emacs/org/notes.org" "Blog Ideas")
               "* TODO [#B] %?\n  %i\n %U"
               :empty-lines 1)
              ("w" "work" entry (file+headline "~/Emacs/org/gtd.org" "Cocos2D-X")
               "* TODO [#A] %?\n  %i\n %U"
               :empty-lines 1)
              ("c" "Chrome" entry (file+headline "~/Emacs/org/notes.org" "Quick notes")
               "* TODO [#C] %?\n %(zilongshanren/retrieve-chrome-current-tab-url)\n %i\n %U"
               :empty-lines 1)
              ("l" "links" entry (file+headline "~/Emacs/org/notes.org" "Quick notes")
               "* TODO [#C] %?\n  %i\n %a \n %U"
               :empty-lines 1)
              ("j" "Journal Entry"
               entry (file+datetree "~/Emacs/org/journal.org")
               "* %?"
               :empty-lines 1)))

      ;;An entry without a cookie is treated just like priority ' B '.
      ;;So when create new task, they are default 重要且紧急
      (setq org-agenda-custom-commands
            '(
              ("w" . "任务安排")
              ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
              ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
              ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
              ("b" "Blog" tags-todo "BLOG")
              ("p" . "项目安排")
              ("pw" tags-todo "PROJECT+WORK+CATEGORY=\"noisychannels\"")
              ("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"xiaoliu\"")
              ("W" "Weekly Review"
               ((stuck "")            ;; review stuck projects as designated by org-stuck-projects
                (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
                ))))

      (defvar xiaoliu-website-html-preamble
        "<div class='nav'>
<ul>
<li><a href='http://xiaoliuai.github.io'>博客</a></li>
<li><a href='publish/sitemap.html'>Wiki目录</a></li>
</ul>
</div>")
      (defvar xiaoliu-website-html-blog-head
        "<link rel=\"stylesheet\" type=\"text/css\" href=\"/~xiaoliu/publish/css/worg\.css\"/>
<link rel=\"stylesheet\" type=\"text/css\" href=\"/publish/css/worg\.css\"/>")
      (setq org-publish-project-alist
            `(
              ("notes-pages"
               :base-directory "~/Emacs/org"
               :base-extension "org"
               :publishing-directory "~/WorkSpace/xiaoliuai.github.io/source/publish/"

               :recursive t
               :html-head ,xiaoliu-website-html-blog-head
               :publishing-function org-html-publish-to-html
               :headline-levels 4           ; Just the default for this project.
               :exclude "gtd.org"
               ;; :exclude-tags ("ol" "noexport")
               :html-preamble ,xiaoliu-website-html-preamble
               :author "xiaoliu"
               :email "xiaoliuai@gmail.com"
               :auto-sitemap t               ; Generate sitemap.org automagically...
               :sitemap-filename "sitemap.org" ; ... call it sitemap.org (it's the default)...
               :sitemap-title "我的wiki"     ; ... with title 'Sitemap'.
               :sitemap-sort-files anti-chronologically
               :sitemap-file-entry-format "%t" ; %d to output date, we don't need date here
               :auto-preamble t
               :table-of-contents t
               )
              ("notes-static"
               :base-directory "~/Emacs/org"
               :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
               :publishing-directory "~/WorkSpace/xiaoliuai.github.io/source/publish/"
               :recursive t
               :publishing-function org-publish-attachment
               )
              ("notes" :components ("notes-pages" "notes-static"))))

      (defun org-summary-todo (n-done n-not-done)
        "Switch entry to DONE when all subentries are done, to TODO otherwise."
        (let (org-log-done org-log-states)  ; turn off logging
          (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

      (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
      ;; used by org-clock-sum-today-by-tags
      (defun filter-by-tags ()
        (let ((head-tags (org-get-tags-at)))
          (member current-tag head-tags)))

      (defun org-clock-sum-today-by-tags (timerange &optional tstart tend noinsert)
        (interactive "P")
        (let* ((timerange-numeric-value (prefix-numeric-value timerange))
               (files (org-add-archive-files (org-agenda-files)))
               (include-tags '("WORK" "EMACS" "DREAM" "WRITING" "MEETING"
                               "LIFE" "PROJECT" "OTHER"))
               (tags-time-alist (mapcar (lambda (tag) `(,tag . 0)) include-tags))
               (output-string "")
               (tstart (or tstart
                           (and timerange (equal timerange-numeric-value 4) (- (org-time-today) 86400))
                           (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "Start Date/Time:"))
                           (org-time-today)))
               (tend (or tend
                         (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "End Date/Time:"))
                         (+ tstart 86400)))
               h m file item prompt donesomething)
          (while (setq file (pop files))
            (setq org-agenda-buffer (if (file-exists-p file)
                                        (org-get-agenda-file-buffer file)
                                      (error "No such file %s" file)))
            (with-current-buffer org-agenda-buffer
              (dolist (current-tag include-tags)
                (org-clock-sum tstart tend 'filter-by-tags)
                (setcdr (assoc current-tag tags-time-alist)
                        (+ org-clock-file-total-minutes (cdr (assoc current-tag tags-time-alist)))))))
          (while (setq item (pop tags-time-alist))
            (unless (equal (cdr item) 0)
              (setq donesomething t)
              (setq h (/ (cdr item) 60)
                    m (- (cdr item) (* 60 h)))
              (setq output-string (concat output-string (format "[-%s-] %.2d:%.2d\n" (car item) h m)))))
          (unless donesomething
            (setq output-string (concat output-string "[-Nothing-] Done nothing!!!\n")))
          (unless noinsert
            (insert output-string))
          output-string))
      (global-set-key (kbd "C-c a") 'org-agenda)
      (define-key org-mode-map (kbd "s-p") 'org-priority)
      (define-key global-map (kbd "<f9>") 'org-capture)
      (global-set-key (kbd "C-c b") 'org-iswitchb)
      (define-key evil-normal-state-map (kbd "C-c C-w") 'org-refile)
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "owh" 'plain-org-wiki-helm
        "owf" 'plain-org-wiki)
      (setq org-mobile-directory "~/Emacs/org/org")
      )))

;; (defun xiaoliu/post-init-prodigy ()
;;   (progn
;;     (prodigy-define-tag
;;       :name 'jekyll
;;       :env '(("LANG" "en_US.UTF-8")
;;              ("LC_ALL" "en_US.UTF-8")))
;;     ;; define service
;;     (prodigy-define-service
;;       :name "Preview cocos2d-x web"
;;       :command "python"
;;       :args '("-m" "SimpleHTTPServer" "6001")
;;       :cwd "~/cocos2d-x/web"
;;       :tags '(work)
;;       :kill-signal 'sigkill
;;       :kill-process-buffer-on-stop t)

;;     (prodigy-define-service
;;       :name "Preview cocos2d-html5"
;;       :command "python"
;;       :args '("-m" "SimpleHTTPServer" "6004")
;;       :cwd "~/Github/fireball/engine"
;;       :tags '(work)
;;       :kill-signal 'sigkill
;;       :kill-process-buffer-on-stop t)

;;     (prodigy-define-service
;;       :name "Hexo Server"
;;       :command "hexo"
;;       :args '("server")
;;       :cwd "~/WorkSpace/xiaoliuai.github.io"
;;       :tags '(hexo server)
;;       :kill-signal 'sigkill
;;       :kill-process-buffer-on-stop t)

;;     (prodigy-define-service
;;       :name "Hexo Deploy"
;;       :command "hexo"
;;       :args '("deploy" "--generate")
;;       :cwd "~/4gamers.cn"
;;       :tags '(hexo deploy)
;;       :kill-signal 'sigkill
;;       :kill-process-buffer-on-stop t)

;;     (prodigy-define-service
;;       :name "Debug Fireball"
;;       :command "npm"
;;       :args '("start" "--" "--nologin" "/Users/xiaoliu/Github/example-cases")
;;       :cwd "~/Github/fireball/"
;;       :tags '(work)
;;       :kill-signal 'sigkill
;;       :kill-process-buffer-on-stop t)

;;     (prodigy-define-service
;;       :name "Org wiki preview"
;;       :command "python"
;;       :args '("-m" "SimpleHTTPServer" "8088")
;;       :cwd "~/Emacs/org/public_html"
;;       :tags '(org-mode)
;;       :init (lambda () (browse-url "http://localhost:8088"))
;;       :kill-signal 'sigkill
;;       :kill-process-buffer-on-stop t)))
