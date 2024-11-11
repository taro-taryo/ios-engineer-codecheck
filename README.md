# iOSEngineerCodeCheck プロジェクト

## 概要
このプロジェクトは、GitHubのリポジトリを検索し、リスト表示されたリポジトリの詳細情報を確認できるiOSアプリケーションです。検索結果からリポジトリを選択することで、詳細画面でリポジトリの情報（リポジトリ名、使用言語、スター数、ウォッチャー数、フォーク数、オープンなイシュー数、オーナーのアバター画像）を表示します。

## 課題: プログラム構造のリファクタリング
本プロジェクトは、コード内でDRY（Don't Repeat Yourself）やCQS（Command Query Separation）といった原則に違反している箇所がありました。さらに、単一責任原則（SRP）やインターフェイス分離の原則（ISP）なども意識し、驚き最小の原則に従ってリファクタリングを行いました。以下のリファクタリングを行うことで、可読性と保守性を向上させました。

### リファクタリング内容
- **DRYの適用**: 重複していたコードを削減し、再利用可能なコンポーネントとして `ImageService` や `RepositoryManager` などのクラスを導入しました。
- **CQSの導入**: クエリ（データ取得）とコマンド（状態変更）の分離を行いました。例えば、データ取得専用の `RepositoryFetchable` プロトコルを定義し、状態変更のないクエリ操作を独立させました。
- **単一責任の徹底**: 各クラスが特定の責務にのみ集中するようにリファクタリングを行いました。データ取得ロジックを `SearchService` や `RepositoryManager` に移し、ビュー更新ロジックをビューやビューモデルに限定しました。
- **インターフェイス分離の原則**: インターフェイスを役割ごとに分離し、例えば画像の取得に関する `ImageFetchable` プロトコルを導入することで、関心の分離を行いました。
- **驚き最小の原則**: 予測可能で一貫性のあるコードにするため、SwiftUIを活用し、アプリ全体のUI構成を統一しました。

## ファイル構成
- **ContentView.swift**: メイン画面で、検索バーとリポジトリ一覧を表示するSwiftUIビューです。ユーザーが検索したリポジトリをリスト表示します。
- **RepositoryListViewModel.swift**: リスト画面のビューモデルで、GitHub APIからリポジトリデータを取得し、UIにデータを提供します。`SearchService` を利用して検索機能を実装し、エラーも管理しています。
- **DetailView.swift**: リポジトリの詳細情報を表示するSwiftUIビューで、`ImageLoader` を使用してオーナーのアバター画像を非同期で取得し表示します。
- **Repository.swift**: `Repository` 構造体を定義し、GitHub APIからのレスポンスをデコードします。
- **RepositoryManager.swift**: `RepositoryFetchable` を実装し、リポジトリのデータ取得機能を提供するクラス。`SearchService` を利用しています。
- **ImageService.swift**: `ImageFetchable` プロトコルを実装し、画像の非同期取得を行うサービスクラス。
- **ImageLoader.swift**: `ImageService` を使用して画像をロードし、SwiftUIビューに表示するための `ObservableObject` クラスです。
- **KeyboardAvoider.swift**: SwiftUIビューのキーボードを避けるためのモディファイア。キーボードが表示される高さに応じてビューのパディングを調整します。
- **RepositoryRow.swift**: リポジトリを一覧表示する際に各リポジトリの情報を表示する行ビューです。
- **SearchService.swift**: GitHub APIを呼び出し、検索クエリに基づいてリポジトリのデータを取得するクラス。`RepositoryFetchable` プロトコルを準拠しています。

## 使用技術
- **言語**: Swift
- **UIフレームワーク**: SwiftUI
- **ネットワーク**: `URLSession`を利用してGitHub APIと通信し、検索および画像の非同期取得を行います。
- **データ解析**: `JSONDecoder`を用いてGitHub APIからのレスポンスデータをパースします。

## 生成AIの利用について
このREADMEおよびプロジェクトの一部コードは、生成AIを活用して作成しました。生成AIを利用することで、効率的に高品質なコードとドキュメントを作成できました。
