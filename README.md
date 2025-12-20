# Meow NFT Project 🐱🏆

このプロジェクトは、Sui（Testnet）上でNFTを自作・発行するためのMoveコントラクトと、その実行手順をまとめたものです。
「グループワーク優勝」を記念した「Meow Chain」NFTを発行しました。

## 1. プロジェクトの概要

- **NFT名**: Meow Chain
- **説明**: グループワーク優勝！
- **ネットワーク**: Sui Testnet
- **技術スタック**: Move (Sui Move 2024 edition)

---

## 2. 実行した手順（備忘録）

私が今回、Sui CLIを使って実行した一連の流れです。

### ① プロジェクトの作成
```bash
sui move new meow_nft
```

### ② 依存関係の設定 (`Move.toml`)
Sui Frameworkをテストネット用に設定しました。

### ③ コントラクトの実装 (`sources/meow_nft.move`)
NFTの構造体（`MeowNFT`）と、誰でもミントできる関数（`mint`）を実装しました。

### ④ ビルドとデプロイ（パブリッシュ）
```bash
# ビルド（コンパイル）
sui move build

# テストネットへのデプロイ
sui client publish --gas-budget 100000000
```
※デプロイに成功すると、`PackageID` が発行されます。

---

## 3. 手動でNFTをミント（追加発行）する方法

自分で新しいNFTを発行したい場合は、ターミナルで以下のコマンドを実行します。

### 必要な情報
- **Package ID**: `0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818`
- **Module Name**: `meow_nft`
- **Function Name**: `mint`

### ミントコマンド
以下のコマンドの `TITLE`、`DESCRIPTION`、`IPFS_URL`、`RECIPIENT_ADDRESS` を書き換えて実行してください。

```bash
sui client call \
  --function mint \
  --module meow_nft \
  --package 0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818 \
  --args "NFTのタイトル" "NFTの説明文" "ipfs://画像CID" [受け取り先アドレス] \
  --gas-budget 10000000
```

#### 引数の例
- **タイトル**: `"Next Meow"`
- **説明**: `"Second NFT"`
- **画像URL**: `"ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4"`
- **アドレス**: `0xf7fbe...（あなたのウォレットアドレス）`

---

## 4. 各種リンク
- **SuiScan (Testnet)**: [あなたのNFTを確認する](https://suiscan.xyz/testnet/object/0xa77ca89fac7385d6a37dad700a0f0a647cf6ea4a407209e478e9c137c5a39868)

---

## 構成ファイル
- `sources/meow_nft.move`: NFTのロジックが書かれたメインコード
- `Move.toml`: プロジェクトの設定と依存関係
