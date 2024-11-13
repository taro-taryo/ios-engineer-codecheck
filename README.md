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
- [課題-ボーナス-UIをブラッシュアップ](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-ボーナス-UIをブラッシュアップ)
- [課題-ボーナス-新機能を追加](https://github.com/taro-taryo/ios-engineer-codecheck/releases/tag/課題-ボーナス-新機能を追加-v1.1)

## アプリ仕様

このアプリはGitHubのリポジトリを検索するためのものです。本仕様の一部はオリジナルのリポジトリ（[株式会社ゆめみの課題リポジトリ](https://github.com/yumemi-inc/ios-engineer-codecheck)）から引用しています。

### 動作

1. キーワードを入力してリポジトリを検索
2. GitHub API（`search/repositories`）を使用してリポジトリを検索し、結果一覧を概要（リポジトリ名）で表示
3. 結果の1つを選択すると、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star数、Watcher数、Fork数、Issue数）が表示されます

## 既知のバグと課題

このプロジェクトにおいて現在確認されているバグや修正課題については、GitHubのIssueとして管理しています。以下のリンクから一覧をご確認いただけます。

- [既知のバグと課題の一覧](https://github.com/taro-taryo/ios-engineer-codecheck/issues)

現時点で未解決の項目がいくつかあるため、動作確認の際にはご留意ください。バグや修正が完了した際には、リリースノートおよびIssueで進捗を更新します。

## 環境

- 開発機OS: macOS Sequoia 15.1
- XCode: Version 16.1 (16B40)
- 開発言語: Swift 5
- Minimum Deployments: iOS 17.2

## 生成AIの利用について

このプロジェクトは **生成AIを積極的に使用しています。**
コードを生成AIに渡すときにトークンを節約するため、 [ディレクトリ内のコードのインデントを削除して、１つのプレーンテキストファイルに纏めるツール](https://github.com/taro-taryo/ios-engineer-codecheck/tree/tools/project-source-compression/tools/project_source_compression) を作成しました。

[対話的なプログラマー](https://github.com/taro-taryo/ios-engineer-codecheck/blob/tools/ai-prompts/tools/ai-prompts/%E5%AF%BE%E8%A9%B1%E7%9A%84%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9E%E3%83%BC) を作成して、時間を大きく節約しました。

