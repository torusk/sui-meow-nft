# Meow NFT Project (Final Documentation) 🐱🏆

このプロジェクトは、Sui Testnet上でNFTを作成し、メンバーに配布するための一連の手順をまとめたものです。

---

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
  ※メインネットの場合は `rev` を `framework/mainnet` にします。

- **コントラクト実装 (`sources/meow_nft.move`)**:
  主要なポイントは以下の4点です。

  1.  **NFT構造体の定義**: 
      `key, store` を持たせることでウォレット間での転送が可能になります。
  2.  **Displayオブジェクトの設定**: ウォレット上で画像を表示させるために設定します。
  3.  **ミント（発行）関数**: 誰がNFTを作成できるかを定義します。
  4.  **バーン（削除）関数**: 所有者がNFTを破壊できるようにするために定義します。これにより、ウォレット上での削除ボタン表示やスクリプトによる消去が可能になります。

### 4. テストネットへのデプロイ
- **ビルド**: `sui move build`
- **デプロイ**: `sui client publish --gas-budget 100000000`
- 成功時に出力される **Package ID** をメモし、スクリプトの `PACKAGE_ID` 変数（または `config.local`）を更新します。

### 5. 配布自動化 (Shell Script)
一人ひとりにコマンドを打つのは大変なため、自動化スクリプトを使用します。
リポジトリ直下に `config.local` という名前でファイルを作成すると、スクリプトが自動で読み込みます。

- **汎用スクリプト (`mint_nft.sh`)**: 宛先アドレスを引数に取ります。
- **専用スクリプト (`distribute_meow.sh`)**: 優勝記念に特化した内容を直接配布します。

### 6. 不要なNFTの削除 (Burn)
自分が所有しているNFTを削除して、ストレージ代の返金を受けることができます。
```bash
./burn_nft.sh [NFTのObject ID]
```

---

## 🚀 クローンして別の画像でNFTを発行する手順
既存のパッケージIDを再利用して、画像や名前だけが異なる新しいNFTを発行する最短手順です。

1. **GitHubからクローン**: `git clone [URL]`
2. **ローカル設定ファイルの作成**: `touch config.local`
3. **設定の書き込み**:
   ```bash
   PACKAGE_ID="0x8971df9b4ea946c47f01baf46ed492ac02290faf8d768b5d4adecd824ed8cbbf"
   IMAGE_URL="ipfs://[取得した新しいCID]"
   NFT_TITLE="[タイトル]"
   NFT_DESC="[説明文]"
   ```
4. **発行（ミント）の実行**: `./mint_nft.sh [アドレス]`

---

## 💰 メインネット（本番環境）移行ガイド
本番環境へ移行する際の手順、費用、および注意点です。

### 費用概算 (目安)
- **コントラクト公開**: 約 1.0 ~ 2.0 SUI (数百円)
- **NFTミント (1枚あたり)**: 約 0.005 ~ 0.01 SUI (数円)

### 移行時の変更ポイント
1. **Sui CLI の環境切り替え**: `sui client switch --env mainnet`
2. **本物の SUI の準備**: 取引所等で入手し、自分のアドレスへ送金。
3. **パッケージIDの更新**: メインネットへデプロイ後に発行される新しいIDをスクリプトに反映。

### 注意事項
- **不変性**: 一度発行したNFTの画像URLを後から変更することはできません。デプロイ前にテストネットで完璧に動作確認をしてください。
- **画像CIDの恒久性**: Pinataにアップロードした画像が「間違っていないか」を再確認してください。

---

## 🔗 参考リンク
- **SuiScan (Testnet)**: [https://suiscan.xyz/testnet/](https://suiscan.xyz/testnet/)
- **Sui Documentation**: Move言語の公式ドキュメント
