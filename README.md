# iOSEngineerCodeCheck プロジェクト

## 概要
このプロジェクトは、GitHubのリポジトリを検索し、検索結果をリスト表示し、詳細情報を確認できるiOSアプリケーションです。リストからリポジトリを選択すると、詳細画面でリポジトリの名前、使用言語、スター数、ウォッチャー数、フォーク数、オープンなイシュー数、オーナーのアバター画像などの情報が表示されます。

## アーキテクチャ
このプロジェクトでは、**Clean Architecture** を適用し、プレゼンテーションロジックやデータ取得ロジック、依存性の管理を明確に分離しました。このアーキテクチャにより、各層が単一の責任を持ち、テスト可能で拡張性の高い設計となっています。

### アーキテクチャの適用内容
- **Clean Architecture**: 
  - **Presentation** 層: ユーザーインターフェースに関わる部分を管理しています。`View` や `ViewModel` で構成されており、`SwiftUI` を使用して宣言的なUIを構築しています。
  - **Domain** 層: ビジネスロジックを管理する層で、リポジトリ取得や画像取得のインターフェースを定義したプロトコル (`RepositoryFetchable` や `ImageFetchable`) を提供し、具体的なデータソースに依存しない設計です。
  - **Data** 層: データの取得および加工を行う層です。APIからリポジトリ情報を取得する `SearchService` や、画像を取得する `ImageService` が含まれます。
  - **Dependency Injection**: `DIContainer` と `ServiceLocator` を使用して依存性を解決し、各層で必要なコンポーネントを注入しています。これにより、テストが容易になり、モジュールの交換が柔軟に行えます。

### 主な構成要素
- **DIContainer**: アプリケーション全体で使用するサービスを一元管理し、依存性を解決するためのコンテナ。
- **ServiceLocator**: アプリの起動時にDIコンテナにサービスを登録し、必要な場所での依存性注入を可能にします。
- **エラーハンドリング**: `AppError` と `NetworkError` を使用してエラーの種類を管理し、ユーザーに適切なフィードバックを提供します。

## ファイル構成
- **App/iOSEngineerCodeCheckApp.swift**: アプリケーションのエントリーポイントで、DIコンテナにサービスを登録する初期設定を行います。
- **View/Screen/ContentView.swift**: メイン画面で、検索バーとリポジトリ一覧を表示するSwiftUIビューです。
- **View/Screen/DetailView.swift**: リポジトリの詳細情報を表示するSwiftUIビューで、`ImageLoader` を使用してリポジトリのオーナーのアバター画像を取得・表示します。
- **Domain/ViewModel/RepositoryListViewModel.swift**: 検索機能やリポジトリ情報の取得を担当するビューモデルで、ユーザーの検索操作に応じて `RepositoryManager` からデータを取得し、UIを更新します。
- **Data/Repository/RepositoryManager.swift**: リポジトリ取得ロジックを担当し、`SearchService` を通じてAPIからデータを取得します。
- **Data/Service/ImageService.swift**: 画像取得のサービスで、`ImageFetchable` プロトコルに準拠しています。
- **DependencyInjection/DIContainer.swift** と **ServiceLocator.swift**: 依存性の管理と解決のためのDIコンテナおよびサービスロケーターです。

## 使用技術
- **言語**: Swift
- **アーキテクチャ**: Clean Architecture
- **UIフレームワーク**: SwiftUI
- **ネットワーク**: `URLSession`を利用してGitHub APIと通信し、リポジトリと画像データの非同期取得を行います。
- **データ解析**: `JSONDecoder`でGitHub APIのレスポンスデータをSwiftの構造体にデコードしています。

## 生成AIの利用について
このREADMEおよび一部コードは、生成AIを活用して作成しました。生成AIを利用することで、迅速に高品質なコードとドキュメントを作成し、プロジェクトのアーキテクチャ設計に集中することができました。
