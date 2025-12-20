# NFT Distribution Guide (GitHub Version)

このリポジトリにはスクリプトの本体のみが含まれています。
個人情報を含むタイトルや説明文を扱う場合は、以下の手順でローカル設定を行ってください。

## 1. ローカル設定の作成
リポジトリ直下に `config.local` というファイルを作成します（このファイルはGitで無視されます）。

```bash
# config.local の内容例
PACKAGE_ID="0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818"
IMAGE_URL="ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4"
NFT_TITLE="あなたのタイトル"
NFT_DESC="あなたの説明文"
```

## 2. 実行
設定完了後、以下のコマンドで配布できます。

```bash
./mint_nft.sh 相手のアドレス
```
