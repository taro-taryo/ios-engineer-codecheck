# TestCases.md

## プロジェクト テストケース設計

このドキュメントは、プロジェクトのユニットテストおよびUIテストケースの詳細な設計をまとめています。各ケースにおいて、期待される挙動とエラーハンドリングを含めています。

---

### ユニットテスト (XCTest)

#### RepositoryListViewModel
- **テストケース1**：有効な検索語でリポジトリ一覧が取得できること
  - **期待結果**：リポジトリリストが`repositories`にセットされ、検索語に関連するリポジトリが正しく表示される。

- **テストケース2**：無効な検索語やネットワークエラーが発生した場合に、`AppError`が設定されること
  - **期待結果**：エラーが発生した場合、`error` プロパティが適切に設定され、ユーザーにエラーメッセージが表示される。

- **テストケース3**：`searchText`および`repositories`の初期化確認
  - **期待結果**：`searchText`と`repositories`が空であること。

- **テストケース4**：リポジトリ取得の非同期処理が完了後に`repositories`が更新されること
  - **期待結果**：検索完了後、`repositories` プロパティに正しいリポジトリデータがセットされる。

#### ImageLoader
- **テストケース1**：URLから画像を非同期で取得できること
  - **期待結果**：有効なURLを渡した場合、`image` プロパティに画像が設定される。

- **テストケース2**：無効なURLが指定された場合に画像が設定されないこと
  - **期待結果**：無効なURLを渡した場合、`image` プロパティが`nil`のままである。

#### RepositoryManager
- **テストケース1**：`fetchRepositories(for:)`で検索語に基づいたリポジトリリストが取得されること
  - **期待結果**：指定した検索語に関連するリポジトリリストが取得できる。

- **テストケース2**：無効なURLが指定された場合に`AppError`が返されること
  - **期待結果**：エラーが発生し、`AppError`が返される。

#### SearchService
- **テストケース1**：APIリクエストが成功し、データが正しく返されること
  - **期待結果**：APIリクエストが正常に行われ、期待されるデータがデコードされる。

- **テストケース2**：APIリクエストが失敗した場合に適切なエラーが発生すること
  - **期待結果**：リクエスト失敗時に`AppError`が設定され、ユーザーにエラーメッセージが表示される。

- **テストケース3**：レスポンスデータが不正な場合、デコードエラーが発生すること
  - **期待結果**：デコードエラーが発生し、`AppError`が返される。

---

### UIテスト (XCUITest)

#### リポジトリ検索フロー
- **テストケース1**：検索バーに文字を入力し、リポジトリ検索が正常に動作すること
  - **期待結果**：検索ボタンを押すとリポジトリリストが更新される。

- **テストケース2**：検索結果が一覧として表示されること
  - **期待結果**：検索結果がリスト形式で表示され、リポジトリ名と言語が正しく表示される。

- **テストケース3**：リポジトリリストのセルをタップして詳細画面に遷移すること
  - **期待結果**：セルをタップするとリポジトリの詳細画面に遷移し、リポジトリの詳細が表示される。

#### リポジトリ詳細画面
- **テストケース1**：詳細画面でオーナーのアバター画像が正しく表示されること
  - **期待結果**：アバター画像が表示され、サイズや位置が正しい。

- **テストケース2**：詳細情報（リポジトリ名、言語、スター数など）がすべて表示されること
  - **期待結果**：リポジトリ名、言語、スター数、ウォッチャー数、フォーク数、オープンイシュー数が正しく表示される。

- **テストケース3**：ネットワークエラー時にエラーメッセージが表示されること
  - **期待結果**：ネットワーク接続がない場合に、エラーメッセージが表示される。
