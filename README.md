# Meme Generator
インターネットミーム（画像にテキストを埋め込んだ画像ネタ）を生成してくれるアプリです。<br><br>
こんな感じにミームを生成してくれます。
<br>
![a1e73093-938e-4cda-8c28-6009e5da6d39](https://user-images.githubusercontent.com/61376298/85324035-4b346900-b4f3-11ea-9638-32c18f2e50ec.png)
<br>
<br>
以下がアプリのURLです。<br>
https://memegenerator1.herokuapp.com/

## アプリ制作背景
MiniMagickについて学習した際にそのアウトプットとして作成しました。

## 主機能
* MiniMagickを用いて画像にテキストを埋め込む
* 生成した画像はAWS S3へ保存
* 生成した画像はローカルにダウンロードできる


## 使い方
1. ミームを生成する元画像を選択する
2. 画像に埋め込むテキストの色を選択する（暗い背景には白を選択するといいです。）
3. 画像上部に埋め込むテキストをUpper textに入力する
4. 画像下部に埋め込むテキストをLower textに入力する
5. Generate Memeボタンを押すとミームが生成されます。ダウンロードボタンから画像をダウンロードする

## 使用技術
* Ruby On Rails

* AWS S3

* heroku

* Semantic UI

## 使用Gem
* MiniMagick

* CarrierWave

* fog