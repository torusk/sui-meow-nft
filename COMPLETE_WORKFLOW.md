# Meow NFT Project (Final Documentation) 🐱🏆

このプロジェクトは、Sui Testnet上でNFTを作成し、メンバーに配布するための一連の手順をまとめたものです。

## 📋 プロジェクト全体の流れ

### 1. 画像の準備 (Pinata / IPFS)
NFTの「見た目」となる画像をIPFSに永久保存します。
- [Pinata](https://www.pinata.cloud/) にログイン。
- 「Upload」から画像ファイルをアップロード。
- 発行された **CID** (例: `bafkreibczy...`) をメモする。
- リンク形式は `ipfs://[CID]` となります。

### 2. Sui 環境のセットアップ
- **Sui CLI** のインストールと最新化。
- ネットワークをテストネットに切り替え:
  ```bash
  sui client envs
  sui client switch --env testnet
  ```
- ガス代（SUI）の確保:
  ```bash
  sui client faucet
  ```
  ※ コマンドでエラーが出る場合、または案内が表示される場合は、Web UI ([faucet.sui.io](https://faucet.sui.io/)) にアクセスし、自分のアドレス（`sui client active-address` で確認可能）を入力して取得してください。

### 3. スマートコントラクト(Move)の開発
NFTの「中身」と「ルール」を定義するスマートコントラクトを作成します。

- **プロジェクト作成**:
  ```bash
  sui move new [プロジェクト名]
  ```
  実行後、ディレクトリ内に `Move.toml` と `sources/` ディレクトリが生成されます。

- **依存関係設定 (`Move.toml`)**:
  Suiの標準ライブラリ（Sui Framework）を利用するために、`[dependencies]` セクションに以下を記述します。
  ```toml
  [dependencies]
  Sui = { git = "https://github.com/MystenLabs/sui.git", subdir = "crates/sui-framework/packages/sui-framework", rev = "framework/testnet" }
  ```
  ※テストネット用の場合。メインネットの場合は `rev` を `framework/mainnet` にします。

- **コントラクト実装 (`sources/meow_nft.move`)**:
  主要なポイントは以下の3点です。

  1.  **NFT構造体の定義**:
      ```move
      public struct MeowNFT has key, store {
          id: UID,
          name: String,
          description: String,
          url: Url,
      }
      ```
      `key` はSuiオブジェクトとしてIDを持つために必要で、`store` を持たせることでウォレット間での自由な転送が可能になります。

  2.  **Displayオブジェクトの設定 (メタデータ表示)**:
      `init` 関数内で `sui::display` を使用し、ウォレットやエクスプローラー上で名前や画像がどのように表示されるかを設定します。
      ```move
      let keys = vector[utf8(b"name"), utf8(b"image_url"), ...];
      let values = vector[utf8(b"{name}"), utf8(b"{url}"), ...];
      // {name} や {url} は、NFT構造体のフィールド値を参照するテンプレート
      ```

  3.  **ミント（発行）関数**:
      誰が（または権限者が）NFTを作成できるかを `public entry fun mint` として定義します。引数に `name` や `url` を受け取るようにすることで、発行ごとに異なる情報を設定できます。

### 4. テストネットへのデプロイ
- **ビルド**: `sui move build`
- **デプロイ**: `sui client publish --gas-budget 100000000`
- 成功時に出力される **Package ID** をメモします。

### 5. 配布自動化 (Shell Script)
一人ひとりにコマンドを打つのは大変なため、自動化スクリプトを作成しました。

#### A. 汎用スクリプト (`mint_nft.sh`)
GitHub公開用の汎用スクリプトです。`config.local` ファイルを作成して使用します。

#### B. 専用スクリプト (`distribute_meow.sh`)
【ローカル専用 / Git追跡対象外】
今回の優勝記念に特化した内容を直接書き込んだスクリプトです。アドレスを一つ指定するだけで、即座にミントと配布が行われ、確認用URLが表示されます。
```bash
./distribute_meow.sh [相手のウォレットアドレス]
```

---

## 🛠️ まとめ：次回からの最短手順
1. 画像をPinataに上げる。
2. `distribute_meow.sh` 内の `IMAGE_URL` を新しいCIDに書き換える。
3. 必要に応じて `TITLE` や `DESC` を変える。
4. コマンドを実行して配布！

---

## 🔗 参考リンク
- **SuiScan (Testnet)**: トランザクションやNFTの確認
- **Sui Documentation**: Move言語の公式ドキュメント
