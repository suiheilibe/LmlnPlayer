# これは何
Web Audio APIを使ったLa-Mulana (リメイク版のPCバージョン)の音楽プレイヤー

ゲーム中と同様にループします

現在のところPC・Android版Google Chromeにのみ対応しています<br>
(Firefoxでも音は鳴りますが、ループする位置が正しくありません)

# ライセンス
NYSL Version 0.9982
> A. 本ソフトウェアは Everyone'sWare です。このソフトを手にした一人一人が、
>   ご自分の作ったものを扱うのと同じように、自由に利用することが出来ます。
>
>  A-1. フリーウェアです。作者からは使用料等を要求しません。
>  A-2. 有料無料や媒体の如何を問わず、自由に転載・再配布できます。
>  A-3. いかなる種類の 改変・他プログラムでの利用 を行っても構いません。
>  A-4. 変更したものや部分的に使用したものは、あなたのものになります。
>       公開する場合は、あなたの名前の下で行って下さい。
>
>B. このソフトを利用することによって生じた損害等について、作者は
>   責任を負わないものとします。各自の責任においてご利用下さい。
>
>C. 著作者人格権は suiheilibe に帰属します。著作権は放棄します。
>
>D. 以上の３項は、ソース・実行バイナリの双方に適用されます。

# 使い方
1. PureMVC Haxe Standard Framework ( https://github.com/PureMVC/puremvc-haxe-standard-framework )に依存しているので以下のコマンドでインストールして下さい
`haxelib git puremvc-haxe-standard-framework https://github.com/PureMVC/puremvc-haxe-standard-framework master src`
2. LmlnPlayer.hxprojをFlash Developで開き、ビルドを実行して下さい(そのままではClosure Compilerが必要です)
3. bin/media/README.txtの指示に従って、La-Mulanaのデータをそこにコピーして下さい
4. Webサーバに置いてbin/index.htmlを開いて下さい(La-Mulana由来のデータの利用許諾に注意して下さい)。ただし、*.oggファイルに対してOgg Vorbisを表すMIME Type (audio/oggなど)を返すように設定されている必要があります
