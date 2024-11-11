# iOSEngineerCodeCheck プロジェクト

## 概要
このプロジェクトは、GitHubのリポジトリを検索し、一覧表示されたリポジトリの詳細情報を確認できるiOSアプリケーションです。検索結果からリポジトリを選択することで、リポジトリの詳細情報（名前、使用言語、スター数、ウォッチャー数、フォーク数、オープンなイシュー数、オーナーのアバター画像）を表示します。

## 課題: Fat View Controller の回避
本プロジェクトでは `ViewController` が必要以上の責務を抱えていたため、いわゆる "Fat View Controller" 状態となっていました。今回のリファクタリングにより、以下の責務の分離を行い、各 `ViewController` の役割を明確化しました。

### リファクタリング内容
- **検索機能の分離**: GitHub APIを使ったリポジトリ検索を `SearchService` クラスに切り出しました。これにより、`ViewController` のコードが簡潔になり、責務が検索機能から分離されました。
- **画像取得機能の分離**: リポジトリのオーナーのアバター画像の非同期取得を `ImageService` クラスに移行しました。この変更により、画像の取得処理が `DetailViewController` から分離され、画像処理に特化した責務として扱われるようになりました。

## ファイル構成
- **ViewController.swift**: GitHubのリポジトリを検索し、検索結果をリスト表示する画面。`SearchService` を使って検索し、検索結果を表示します。
- **DetailViewController.swift**: 選択されたリポジトリの詳細情報を表示する画面。各リポジトリの詳細情報と、`ImageService` を使用してリポジトリのオーナーのアバター画像を表示します。
- **Repository.swift**: `Repository`構造体および`RepositoriesResponse`構造体を定義し、GitHub APIのレスポンスからリポジトリのデータをデコードします。
- **SearchService.swift**: GitHubのAPIからリポジトリデータを取得するためのサービスクラス。非同期でデータ取得し、取得結果を `Result` 型で返却します。
- **ImageService.swift**: 画像取得に関する処理を担当するクラス。指定されたURLから画像データを非同期でダウンロードし、`UIImage`として返却します。
- **AppDelegate.swift** & **SceneDelegate.swift**: アプリケーションのライフサイクルイベントを管理します。
- **iOSEngineerCodeCheckTests.swift**: 単体テスト用のファイル。
- **iOSEngineerCodeCheckUITests.swift**: UIテスト用のファイル。

## 使用技術
- **言語**: Swift
- **UIフレームワーク**: UIKit
- **ネットワーク**: `URLSession`を使用してGitHub APIと通信し、検索および画像の非同期取得を行います。
- **データ解析**: `JSONDecoder`を用いてGitHub APIからのレスポンスデータをパース。

## 生成AIの利用について
このREADMEおよびプロジェクトの一部コードは、生成AIを活用して作成しました。そのため、内容にはAIが生成したものが含まれています。

