************************
 platex-suite
************************
俺の俺による俺のための latex コンパイル用 VIM
プラグイン。本当はVimのドキュメント書きたいけどよくわからないし面倒なので
ここに説明を書きます。

ばーじょん: 0.0.1

動悸
====
VIM-LaTeX-Suiteを入れると他プラグインと競合しまくる。
ぶっちゃけショートカットキーとか使ってないし、それらが欲しくても
neocomplcache, sonictemplate-vimとかでいくらでも代用可能。

結局欲しいのはコンパイル機能だけ。じゃぁ作ってしまえ、ってのが動悸です。

ちなみに Tex環境は TexLive 2011 とか使ってます。これだと Ubuntu で UTF-8 が扱
える ``platex`` とか入ってるので便利です。

インストール方法
================
Vundleとか使うの推奨してます。そうじゃないなら全部を突っ込めばいいと思います。

使い方
======

1.  メインの LaTeX ファイルを ``index.tex`` とします。ここは設定で変えられる
    けどとりあえず。

2.  おもむろに Vim を起動します。さっきの ``index.tex`` を開きます。

3.  「クリリンのことかー」と叫びながら ``<F5>``
    を押します。するとコンパイルができます。デバッグしてないので「クリリンの
    ことかー」と叫びながら押さないと機能しない可能性があります。

4.  プレビューしたい場合は「俺、この論文が終わったら結婚するんだ」と
    つぶやきながら ``<F12>`` を押してください。Macならプレビュー出来ます。
    Linuxの場合 ``evince`` が入ってるとプレビュー出来ます。これも同様に
    デバッグしてないのでつぶやかないと動かないかもしれません。ちなみに「論文」
    は今ご自身が戦っているものに置き換えたほうが成功率はあがります。


もっと詳しい使い方
==================

-   ``Compile <file>`` で特定ファイルをコンパイルします。
    ``<file>`` 省略すると ``g:platex_suite_main_file`` の値が使われます。

-   ``Preview <file>`` で特定ファイルをコンパイル後プレビューします
    ``<file>`` 省略すると ``g:platex_suite_main_file`` の値が使われます。

えふえーきゅー
==============

コンパイル出来ない
    filetypeがplaintexになってませんか？filetypeはtexです

        set FileType plaintex set ft=tex


設定
====

``g:platex_suite_main_file``
    コンパイル時にメインで使用するファイル名です。デフォルトは ``index``
    になってます。多分拡張子付けても機能するはず。

``g:platex_suite_latex_compiler``
    LaTeXのコンパイルに使用します。デフォは ``platex`` です。

``g:platex_suite_bibtex_compiler``
    Bibtexのコンパイルに使用します。デフォは日本人らしからぬ ``bibtex`` です。

``g:platex_suite_dvipdf_compiler``
    PDFつくります。デフォは ``dvipdfmx`` です。

``g:platex_suite_viewer``
    PDF用ビュワーです。デフォはMacだと ``open`` で Linux だと ``evince`` にな
    ります。 Windows はよくわかりません。

``g:platex_suite_makefile``
    コンパイルに使用する汎用Makefileです。もっといいのがあったら作っていただ
    けると嬉しい限りです。デフォは ``scripts/platex-suite.make`` です。

``<Plug>(platex_suite_compile)``
    コンパイル用キーマップです。 ``g:platex_suite_main_file``
    使ってコンパイルします。デフォでは ``<F5>`` です。

``<Plug>(platex_suite_preview)``
    プレビュー用キーマップです。 ``g:platex_suite_main_file``
    使ってコンパイル・プレビューします。デフォでは ``<F12>`` です。

``platex_suite``
    コンパイラです。Texファイル開くと勝手に指定されます。

他は ``platex_suite/plugin/platex_suite.vim``
を見てください。多分指定しないです。

スペシャルサンクス
==================
スクリプトを書くにあたって mattn_jp さん, thinca さん, Shougo
さんのスクリプトを参考にさせてもらいました。

加えてエラーフォーマットは VIM-LaTeX-Suite 本家
http://vim-latex.sourceforge.net/index.php?subject=download&title=Download
からほとんどコピーしています。ライセンスとか書いてなかったから凄く心配です。

もう一度言います。ライセンスが書いてなかったので果たしてコピーして使っていい
ものか怪しいです。問題があったら公開はやめます。

仕組み
======
汎用 Makefile 呼び出してるだけです。それだけです。
