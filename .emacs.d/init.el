;
;CommandキーをMetaキーに
;
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;
; scroll 1 by 1
;
(setq scroll-step 1)

(require 'cl)

;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
;; load-path を追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "conf" "public_repos")

;;; P65 CUIとGUIによる分岐
;; ターミナル以外はツールバー、スクロールバーを非表示
(when window-system
  ;; tool-barを非表示
  (tool-bar-mode 0)
  ;; scroll-barを非表示
  (scroll-bar-mode 0))

;; CocoaEmacs以外はメニューバーを非表示
(unless (eq window-system 'ns)
  ;; menu-barを非表示
  (menu-bar-mode 0))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  環境変数の設定                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P82-83 パスの設定
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/bin")

;;; P85 文字コードを指定する
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;;; P86 ファイル名の扱い
;; Mac OS Xの場合のファイル名の設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Windowsの場合のファイル名の設定
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  フレームに関する設定                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P87-89 モードラインに関する設定
;; カラム番号も表示
(column-number-mode t)
;; ファイルサイズを表示
(size-indication-mode t)
;; 時計を表示（好みに応じてフォーマットを変更可能）
;; (setq display-time-day-and-date t) ; 曜日・月・日を表示
;; (setq display-time-24hr-format t) ; 24時表示
(display-time-mode t)

;;; P90 タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")
;; 行番号を常に表示する
;(global-linum-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; インデントの設定                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P92-94 タブ文字の表示幅
;; TABの表示幅。初期値は8
(setq-default tab-width 4)
;; インデントにタブ文字を使用しない
(setq-default indent-tabs-mode nil)
;; php-modeのみタブを利用しない
;; (add-hook 'php-mode-hook
;;           '(lambda ()
;;             (setq indent-tabs-mode nil)))

;; C、C++、JAVA、PHPなどのインデント
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "bsd")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  表示・装飾に関する設定                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P97-99 フォントの設定
(when (eq window-system 'ns)
  ;; asciiフォントをMenloに
  (set-face-attribute 'default nil
                      :family "Menlo"
                      :height 120)
  ;; 日本語フォントをヒラギノ明朝 Proに
  (set-fontset-font
   nil 'japanese-jisx0208
   ;; 英語名の場合
   ;; (font-spec :family "Hiragino Mincho Pro"))
   ;;(font-spec :family "ヒラギノ明朝 Pro"))
   (font-spec :family "Osaka"))
  ;; ひらがなとカタカナをモトヤシーダに
  ;; U+3000-303F	CJKの記号および句読点
  ;; U+3040-309F	ひらがな
  ;; U+30A0-30FF	カタカナ
  ;;(set-fontset-font
  ;;nil '(#x3040 . #x30ff)
  ;;(font-spec :family "NfMotoyaCedar"))
  ;; フォントの横幅を調節する
  ;; (setq face-font-rescale-alist
  ;;       '((".*Menlo.*" . 1.0)
  ;;         (".*Hiragino_Mincho_Pro.*" . 1.2)
  ;;         (".*nfmotoyacedar-bold.*" . 1.2)
  ;;         (".*nfmotoyacedar-medium.*" . 1.2)
  ;;         ("-cdac$" . 1.3)))
  )

(when (eq system-type 'windows-nt)
  ;; asciiフォントをConsolasに
  (set-face-attribute 'default nil
                      :family "Consolas"
                      :height 120)
  ;; 日本語フォントをメイリオに
  (set-fontset-font
   nil
   'japanese-jisx0208
   (font-spec :family "メイリオ"))
  ;; フォントの横幅を調節する
  (setq face-font-rescale-alist
        '((".*Consolas.*" . 1.0)
          (".*メイリオ.*" . 1.15)
          ("-cdac$" . 1.3))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ハイライトの設定                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; P101 括弧の対応関係のハイライト
;; paren-mode：対応する括弧を強調して表示する
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
(show-paren-mode t) ; 有効化
;; parenのスタイル: expressionは括弧内も強調表示
(setq show-paren-style 'expression)
;; フェイスを変更する
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  バックアップとオートセーブ                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P102-103 バックアップとオートセーブの設定
;; バックアップファイルを作成しない
(setq make-backup-files nil) ; 初期値はt
;; オートセーブファイルを作らない
(setq auto-save-default nil) ; 初期値はt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5.9 フック                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ファイルが #! から始まる場合、+xを付けて保存する
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; emacs-lisp-mode-hook用の関数を定義
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
    (setq eldoc-idle-delay 0.2)
    (setq eldoc-echo-area-use-multiline-p t)
    (turn-on-eldoc-mode)))

;; emacs-lisp-modeのフックをセット
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 6.1 Elispをインストールしよう                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P113 拡張機能を自動インストール──auto-install
;; auto-installの設定
(when (require 'auto-install nil t)	; ←1●
  ;; 2●インストールディレクトリを設定する 初期値は ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelisp の名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;; 必要であればプロキシの設定を行う
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; 3●install-elisp の関数を利用可能にする
  (auto-install-compatibility-setup)) ; 4●

;; ▼要拡張機能インストール▼
;;; P114-115 auto-installを利用する
;; (install-elisp "http://www.emacswiki.org/emacs/download/redo+.el")
(when (require 'redo+ nil t)
  ;; C-' にリドゥを割り当てる
  (global-set-key (kbd "C-'") 'redo)
  ;; 日本語キーボードの場合C-. などがよいかも
  ;; (global-set-key (kbd "C-.") 'redo)
  ) ; ←ここでC-x C-eで設定反映

;; ▼要拡張機能インストール▼（ただし、Emacs24からはインストール不要）
;;; P115-116 Emacs Lisp Package Archive（ELPA）──Emacs Lispパッケージマネージャ
;; package.elの設定
(when (require 'package nil t)
  ;; パッケージリポジトリにMarmaladeと開発者運営のELPAを追加
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  ;; インストールしたパッケージにロードパスを通して読み込む
  (package-initialize))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  統一したインタフェースでの操作                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P122-129 候補選択型インタフェース──Anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間。デフォルトは0.5
   anything-idle-delay 0.3
   ;; タイプして再描写するまでの時間。デフォルトは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数。デフォルトは50
   anything-candidate-number-limit 100
   ;; 候補が多いときに体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root権限でアクションを実行するときのコマンド
    ;; デフォルトは"su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))
 

  (when (require 'descbinds-anything nil t)
    ;; describe-bindingsをAnythingに置き換える
    (descbinds-anything-install)))

;; ▼要拡張機能インストール▼
;;; P127-128 過去の履歴からペースト──anything-show-kill-ring
;; M-yにanything-show-kill-ringを割り当てる
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; ▼要拡張機能インストール▼
;;; P128-129 moccurを利用する──anything-c-moccur
(when (require 'anything-c-moccur nil t)
  (setq
   ;; anything-c-moccur用 `anything-idle-delay'
   anything-c-moccur-anything-idle-delay 0.1
   ;; バッファの情報をハイライトする
   anything-c-moccur-higligt-info-line-flag t
   ;; 現在選択中の候補の位置をほかのwindowに表示する
   anything-c-moccur-enable-auto-look-flag t
   ;; 起動時にポイントの位置の単語を初期パターンにする
   anything-c-moccur-enable-initial-pattern t)
  ;; C-M-oにanything-c-moccur-occur-by-moccurを割り当てる
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 7.1 各種言語の開発環境                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P158 nxml-modeをHTML編集のデフォルトモードに
;; HTML編集のデフォルトモードをnxml-modeにする
(add-to-list 'auto-mode-alist '("\\.[sx]?html?\\(\\.[a-zA-Z_]+\\)?\\'" . nxml-mode))
;; ▼要拡張機能インストール▼
;;; P159 HTML5をnxml-modeで編集する
;; HTML5
;; (eval-after-load "rng-loc"
;;   '(add-to-list 'rng-schema-locating-files "~/.emacs.d/public_repos/html5-el/schemas.xml"))
;; (require 'whattf-dt)

;;; P160 nxml-modeの基本設定
;; </を入力すると自動的にタグを閉じる
(setq nxml-slash-auto-complete-flag t)
;; M-TABでタグを補完する
(setq nxml-bind-meta-tab-to-complete-flag t)
;; nxml-modeでauto-complete-modeを利用する
;;(add-to-list 'ac-modes 'nxml-mode)
;; 子要素のインデント幅を設定する。初期値は2
(setq nxml-child-indent 0)
;; 属性値のインデント幅を設定する。初期値は4
(setq nxml-attribute-indent 0)

;; ▼要拡張機能インストール▼
;;; P161 cssm-modeの基本設定
(defun css-mode-hooks ()
  "css-mode hooks"
  ;; インデントをCスタイルにする
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; インデント幅を2にする
  (setq cssm-indent-level 2)
  ;; インデントにタブ文字を使わない
  (setq-default indent-tabs-mode nil)
  ;; 閉じ括弧の前に改行を挿入する
  (setq cssm-newline-before-closing-bracket ))

(add-hook 'css-mode-hook 'css-mode-hooks)

;;; P163 js-modeの基本設定
(defun js-indent-hook ()
  ;; インデント幅を4にする
  (setq js-indent-level 2
        js-expr-indent-offset 2
        indent-tabs-mode nil)
  ;; switch文のcaseラベルをインデントする関数を定義する
  (defun my-js-indent-line () ; ←1●
    (interactive)
    (let* ((parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (js--proper-indentation parse-status)))
      (back-to-indentation)
      (if (looking-at "case\\s-")
          (indent-line-to (+ indentation 2))
        (js-indent-line))
      (when (> offset 0) (forward-char offset))))
  ;; caseラベルのインデント処理をセットする
  (set (make-local-variable 'indent-line-function) 'my-js-indent-line)
  ;; ここまでcaseラベルを調整する設定
  )

;; js-modeの起動時にhookを追加
(add-hook 'js-mode-hook 'js-indent-hook)


;; P168-169 cperl-mode
;; perl-modeをcperl-modeのエイリアスにする
(defalias 'perl-mode 'cperl-mode)

;;; P170 cperl-modeのインデントを調整する
;; cperl-modeのインデント設定
(setq cperl-indent-level 4 ; インデント幅を4にする
      cperl-continued-statement-offset 4 ; 継続する文のオフセット※
      cperl-brace-offset -4 ; ブレースのオフセット
      cperl-label-offset -4 ; labelのオフセット
      cperl-indent-parens-as-block t ; 括弧もブロックとしてインデント
      cperl-close-paren-offset -4 ; 閉じ括弧のオフセット
      cperl-tab-always-indent t ; TABをインデントにする
      cperl-highlight-variables-indiscriminately t) ; スカラを常にハイライトする

;; ▼要拡張機能インストール▼
;;; P170 yaml-mode
;; yaml-modeの設定
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; ▼要拡張機能インストール▼
;;; P171 Perl補完入力──perl-completion
;; perl-completionの設定
(defun perl-completion-hook ()
  (when (require 'perl-completion nil t)
    (perl-completion-mode t)
    (when (require 'auto-complete nil t)
      (auto-complete-mode t)
      (make-variable-buffer-local 'ac-sources)
      (setq ac-sources
            '(ac-source-perl-completion)))))

(add-hook  'cperl-mode-hook 'perl-completion-hook)

;;; P169 コラム　便利なエイリアス
;; dtwをdelete-trailing-whitespaceのエイリアスにする
(defalias 'dtw 'delete-trailing-whitespace)

;;; P172 ruby-modeのインデントを調整する
;; ruby-modeのインデント設定
(setq ;; ruby-indent-level 3 ; インデント幅を3に。初期値は2
      ruby-deep-indent-paren-style nil ; 改行時のインデントを調整する
      ;; ruby-mode実行時にindent-tabs-modeを設定値に変更
      ;; ruby-indent-tabs-mode t ; タブ文字を使用する。初期値はnil
      ) 

(autoload 'ruby-mode "ruby-mode"
    "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.cap$" . ruby-mode))

;; ruby-mode-hook用の関数を定義
(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  (ruby-block-mode t))
;; ruby-mode-hookに追加
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)


;; ▼要拡張機能インストール▼
;;; P172-173 Ruby編集用の便利なマイナーモード
;; 括弧の自動挿入──ruby-electric
(require 'ruby-electric nil t)
;; endに対応する行のハイライト──ruby-block
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))
;; インタラクティブRubyを利用する──inf-ruby
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  タグによるコードリーディング                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P189-190 gtagsとEmacsとの連携
;; gtags-modeのキーバインドを有効化する
(setq gtags-suggested-key-mapping t) ; 無効化する場合はコメントアウト
(require 'gtags nil t)


;; ▼要拡張機能インストール▼
;;; P190-191 ctagsとEmacsとの連携
;; ctags.elの設定
(require 'ctags nil t)
(setq tags-revert-without-query t)
;; ctagsを呼び出すコマンドライン。パスが通っていればフルパスでなくてもよい
;; etags互換タグを利用する場合はコメントを外す
;; (setq ctags-command "ctags -e -R ")
;; anything-exuberant-ctags.elを利用しない場合はコメントアウトする
(setq ctags-command "ctags -R --fields=\"+afikKlmnsSzt\" ")
(global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)

;; ▼要拡張機能インストール▼
;;; P192-193 Anythingとタグの連携
;; AnythingからTAGSを利用しやすくするコマンド作成
(when (and (require 'anything-exuberant-ctags nil t)
           (require 'anything-gtags nil t))
  ;; anything-for-tags用のソースを定義
  (setq anything-for-tags
        (list anything-c-source-imenu
              anything-c-source-gtags-select
              ;; etagsを利用する場合はコメントを外す
              ;; anything-c-source-etags-select
              anything-c-source-exuberant-ctags-select
              ))

  ;; anything-for-tagsコマンドを作成
  (defun anything-for-tags ()
    "Preconfigured `anything' for anything-for-tags."
    (interactive)
    (anything anything-for-tags
              (thing-at-point 'symbol)
              nil nil nil "*anything for tags*"))
  
  ;; M-tにanything-for-currentを割り当て
  (define-key global-map (kbd "M-t") 'anything-for-tags))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 7.4 フレームワーク専用拡張機能                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P195-196 Rinari
;(when (require 'rhtml-mode nil t)
;  (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . rhtml-mode)))

;;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/elisp/rhtml")
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.js\\.erb$" . rhtml-mode))
(add-hook 'rhtml-mode-hook
              (lambda () (rinari-launch)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Emacsからデータベースを操作                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P210-211 MySQLへ接続する──sql-interactive-mode
;; SQLサーバへ接続するためのデフォルト情報
;; (setq sql-user "root" ; デフォルトユーザ名
;;       sql-database "database_name" ;  データベース名
;;       sql-server "localhost" ; ホスト名
;;       sql-product 'mysql) ; データベースの種類



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  バージョン管理                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ▼要拡張機能インストール▼
;;; P217-219 Gitフロントエンド Egg
;; GitフロントエンドEggの設定
(when (executable-find "git")
  (require 'egg nil t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;            オマケ                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; カーソル位置のファイルパスやアドレスを "C-x C-f" で開く
(ffap-bindings)

;;; 筆者のキーバインド設定
;; Mac の Command + f と C-x b で anything-for-files
(define-key global-map (kbd "s-f") 'anything-for-files)
(define-key global-map (kbd "C-x b") 'anything-for-files)
;; M-k でカレントバッファを閉じる
(define-key global-map (kbd "M-k") 'kill-this-buffer)
;; Mac の command + 3 でウィンドウを左右に分割
(define-key global-map (kbd "s-3") 'split-window-horizontally)
;; Mac の Command + 2 でウィンドウを上下に分割
(define-key global-map (kbd "s-2") 'split-window-vertically)
;; Mac の Command + 1 で現在のウィンドウ以外を閉じる
(define-key global-map (kbd "s-1") 'delete-other-windows)
;; Mac の Command + 0 で現在のウィンドウを閉じる
(define-key global-map (kbd "s-0") 'delete-window)
;; バッファを全体をインデント
(defun indent-whole-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))
;; C-<f8> でバッファ全体をインデント
(define-key global-map (kbd "C-<f8>") 'indent-whole-buffer)


;;; 改行やタブを可視化する whitespace-mode
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□]) ; zenkaku space
        (newline-mark 10 [8629 10]) ; newlne
        (tab-mark 9 [187 9] [92 9]) ; tab » 187
        )
      whitespace-style
      '(spaces
        ;; tabs
        trailing
        newline
        space-mark
        tab-mark
        newline-mark))
;; whitespace-modeで全角スペース文字を可視化　
(setq whitespace-space-regexp "\\(\x3000+\\)")
;; whitespace-mode をオン
(global-whitespace-mode t)
;; F5 で whitespace-mode をトグル
(define-key global-map (kbd "<f5>") 'global-whitespace-mode)


;;; Mac でファイルを開いたときに、新たなフレームを作らない
(setq ns-pop-up-frames nil)


;;; 最近閉じたバッファを復元
;; http://d.hatena.ne.jp/kitokitoki/20100608/p2
(defvar my-killed-file-name-list nil)

(defun my-push-killed-file-name-list ()
  (when (buffer-file-name)
    (push (expand-file-name (buffer-file-name)) my-killed-file-name-list)))

(defun my-pop-killed-file-name-list ()
  (interactive)
  (unless (null my-killed-file-name-list)
    (find-file (pop my-killed-file-name-list))))
;; kill-buffer-hook (バッファを消去するときのフック) に関数を追加
(add-hook 'kill-buffer-hook 'my-push-killed-file-name-list)
;; Mac の Command + z で閉じたバッファを復元する
(define-key global-map (kbd "s-z") 'my-pop-killed-file-name-list)

;;---------------------------------------------------------------------------

(setq visible-bell nil)

;====================================
;フレーム位置設定(ウィンドウ） 
;====================================
(setq initial-frame-alist
      (append
       '((top . 20)		       ; フレームの Y 位置(ピクセル数)
	 (left . 0)		           ; フレームの X 位置(ピクセル数)
	 (width . 150)		       ; フレーム幅(文字数)
	 (height . 46)		       ; フレーム高(文字数)
	 ) initial-frame-alist))

(if window-system (progn

    ;; 文字の色を設定します。
    (add-to-list 'default-frame-alist '(foreground-color . "gray10"))
    ;; 背景色を設定します。
    (add-to-list 'default-frame-alist '(background-color . "white"))
    ;; カーソルの色を設定します。
    (add-to-list 'default-frame-alist '(cursor-color . "SlateBlue2"))
    ;; マウスポインタの色を設定します。
    (add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
    ;; モードラインの文字の色を設定します。
;;    (set-face-foreground 'modeline "white")
    ;; モードラインの背景色を設定します。
;;    (set-face-background 'modeline "MediumPurple2")
    ;; 選択中のリージョンの色を設定します。
    (set-face-background 'region "LightSteelBlue1")
    ;; モードライン（アクティブでないバッファ）の文字色を設定します。
    (set-face-foreground 'mode-line-inactive "gray30")
    ;; モードライン（アクティブでないバッファ）の背景色を設定します。
    (set-face-background 'mode-line-inactive "gray85")
	    ))
;; デフォルトの透明度を設定する (85%)
(add-to-list 'default-frame-alist '(alpha . 90))

;; カレントウィンドウの透明度を変更する (85%)
;; (set-frame-parameter nil 'alpha 0.85)
(set-frame-parameter nil 'alpha 95)
(put 'upcase-region 'disabled nil)

(setq c-tab-always-indent t)
(setq default-tab-width 4)
(setq indent-line-function 'indent-relative-maybe) ;;直前行と同じインデント

;====================================
; スクロール設定
;====================================
(setq scroll-conservatively 35
  scroll-margin 0
  scroll-step 1) 

;(load-theme 'misterioso t)
(load-theme 'light-blue t)

;
; scss-mode
; git@github.com:antonj/scss-mode.git
;
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
          '(lambda() (scss-custom)))

(add-to-list 'load-path "~/.emacs.d/public_repos/cucumber")
(autoload 'feature-mode "feature-mode" "Mode for editing cucumber files" t)
(add-to-list 'auto-mode-alist '("\\.feature$" . feature-mode))
