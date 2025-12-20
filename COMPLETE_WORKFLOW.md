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

### 3. スマートコントラクト(Move)の開発
- **プロジェクト作成**: `sui move new meow_nft`
- **依存関係設定**: `Move.toml` に `Sui Framework` を追加。
- **コントラクト実装**: `sources/meow_nft.move` に NFT の構造と、ミント（発行）関数を記述。
  - `key, store` を持たせることでウォレット間での転送が可能になります。
  - `display` オブジェクトを設定することで、エクスプローラー上で画像が表示されるようになります。

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
