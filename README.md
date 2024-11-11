# iOSエンジニア 課題提出プロジェクト

このリポジトリは、iOSエンジニアとしてのスキルを評価していただくための提出用プロジェクトです

## リリース情報
各課題ごとのリリースはこちらから確認できます。

- [課題-初級-Fat-VC-の回避](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-初級-Fat-VC-の回避)
- [課題-初級-ソースコードの可読性の向上](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-初級-ソースコードの可読性の向上)
- [課題-初級-ソースコードの安全性の向上](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-初級-ソースコードの安全性の向上)
- [課題-初級-バグを修正](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-初級-バグを修正)
- [課題-中級-アーキテクチャを適用](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-中級-アーキテクチャを適用)
- [課題-中級-テストを追加](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-中級-テストを追加)
- [課題-中級-プログラム構造をリファクタリング](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-中級-プログラム構造をリファクタリング)
- [課題-ボーナス-新機能を追加](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-ボーナス-新機能を追加)
- [課題-ボーナス-UIをブラッシュアップ](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-ボーナス-UIをブラッシュアップ)

## アプリ仕様

このアプリはGitHubのリポジトリを検索するためのものです。本仕様の一部はオリジナルのリポジトリ（[株式会社ゆめみの課題リポジトリ](https://github.com/yumemi-inc/ios-engineer-codecheck)）から引用しています。

![動作イメージ](README_Images/app.gif)

### 動作

1. キーワードを入力してリポジトリを検索
2. GitHub API（`search/repositories`）を使用してリポジトリを検索し、結果一覧を概要（リポジトリ名）で表示
3. 結果の1つを選択すると、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star数、Watcher数、Fork数、Issue数）が表示されます

## 環境

- 開発機OS: macOS Sequoia 15.1
- XCode: Version 16.1 (16B40)
- 開発言語: Swift 5
- Minimum Deployments: iOS 17.2