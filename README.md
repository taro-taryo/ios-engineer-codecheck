# iOSEngineerCodeCheck プロジェクト

## 概要
このプロジェクトは、GitHub API を利用してリポジトリを検索し、結果をリストで表示、また各リポジトリの詳細情報を表示する iOS アプリケーションです。本プロジェクトでは **Clean Architecture** に基づいた設計を採用し、テスト可能で保守性の高い構造を構築しています。リポジトリ検索機能を中心に、データ層、ビジネスロジック層、プレゼンテーション層の分離を実現しました。

## 主な機能
- **リポジトリ検索機能**: ユーザーが検索バーにキーワードを入力すると、GitHub API を通じて該当リポジトリを検索し、リスト表示します。
- **リポジトリ詳細表示**: リストからリポジトリを選択すると、詳細画面でリポジトリ名、プログラミング言語、スター数、ウォッチャー数、フォーク数、オープンなイシュー数、オーナーのアバター画像が表示されます。

## アーキテクチャ
本プロジェクトでは、**Clean Architecture** を採用して各層を独立させ、依存関係を最小限に保つ設計を行いました。これにより、各モジュールが独立してテスト可能となり、拡張性とメンテナンス性が向上しています。

### 層の構成
1. **Data 層**: データ取得や API 通信を担う層で、`RepositoryManager` と `SearchService` などのデータソースクラスが含まれます。
2. **Domain 層**: ビジネスロジックを管理する層です。`RepositoryFetchable` プロトコルに基づき、データソースへのアクセスを抽象化しています。
3. **Presentation 層**: UI に関わるプレゼンテーションロジックを管理する層で、SwiftUI を用いた ViewModel (`RepositoryListViewModel`) と View (`ContentView`、`DetailView`) が含まれます。
4. **Dependency Injection**: `ServiceLocator` と `DIContainer` を使用して依存性注入を行い、各層が疎結合となるようにしています。

## テスト
プロジェクトでは、ユニットテストと UI テストを追加し、各機能の正確性を検証しています。

### ユニットテスト
- **RepositoryManagerTests**: `RepositoryManager` の動作を検証するテスト。正常なリポジトリ取得、エラー処理、無効な検索ワードの処理をテストしています。
- **RepositoryListViewModelTests**: ビューモデル (`RepositoryListViewModel`) のテストで、検索機能やエラー処理を中心に検証しています。
- **AppErrorTests**: `AppError` および `NetworkError` のエラーメッセージを確認するテスト。
- **ImageLoaderTests**: 画像ローダー (`ImageLoader`) の正常動作とエラーハンドリングを検証するテスト。
- **Stub クラス**: リアルな API ではなくモックデータを利用したテストが可能なように、`StubSearchService` や `StubRepositoryManager` などのスタブクラスを導入しています。

### UIテスト
- **iOSEngineerCodeCheckUITests**: 
    - **検索テスト**: 検索機能が正しく動作し、リスト表示が更新されるかを検証します。
    - **詳細表示テスト**: 詳細画面で正しいリポジトリ情報が表示されるか、画像がロードされるかを確認します。
    - **画像読み込みテスト**: 詳細画面におけるアバター画像の非同期ロードが正常に行われるかをテストします。

## 使用技術
- **言語**: Swift
- **フレームワーク**: SwiftUI, Combine
- **ネットワーキング**: URLSession を用いて非同期で GitHub API からデータを取得
- **テスト**: XCTest を用いた Unit Test および UI Test の実装

## 生成AIの利用について
このREADMEおよび一部のコードは、生成AIのサポートを受けて作成しました。生成AIの活用により、迅速かつ正確なドキュメントとコード作成が可能となり、品質向上と開発効率の向上に寄与しています。
