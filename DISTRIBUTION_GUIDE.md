# NFT配布ガイド (Sui NFT Distribution Guide)

このドキュメントでは、作成したNFTをグループメンバーに個別に配布する手順をまとめています。
同じ画像データ（IPFS CID）を使いつつ、タイトルや説明文を一人ひとりに合わせてカスタマイズして発行（ミント）し、直接相手のウォレットに送ることができます。

---

## 📋 事前準備

以下の情報を手元に用意してください。

1.  **Package ID**: `0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818` (デプロイ済みのID)
2.  **画像URL (IPFS)**: `ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4` (共通の画像)
3.  **メンバーのウォレットアドレス**: `0x...` で始まるアドレスを聞いておきます。

---

## 🚀 配布手順 (1人ずつ実行)

各メンバーに対して、以下のコマンドをターミナルで実行します。

### 実行コマンドのテンプレート

```bash
sui client call \
  --function mint \
  --module meow_nft \
  --package 0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818 \
  --args "タイトル" "説明文" "画像URL" "相手のアドレス" \
  --gas-budget 10000000
```

### 具体的な入力例

例えば、メンバーのAさんに「優勝記念NFT」を送る場合：

- **タイトル**: `"Winner NFT for A-san"`
- **説明**: `"Group Work Championship! Great job."`
- **画像URL**: `"ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4"`
- **アドレス**: `0x1234...abcd` (Aさんのアドレス)

**コマンド:**
```bash
sui client call \
  --function mint \
  --module meow_nft \
  --package 0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818 \
  --args "Winner NFT for A-san" "Group Work Championship! Great job." "ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4" 0x1234567890abcdef1234567890abcdef1234567890abcdef \
  --gas-budget 10000000
```

---

## 🛠 効率よく配布するためのヒント

複数人に送る場合、毎回コマンドを打ち直すのは大変です。
以下のようなテキストファイルを作成して、アドレスを聞くたびに行を増やしていくと管理が楽になります。

### 管理用リスト例 (`members.txt`)
```text
Aさん: 0x123... (送付済み)
Bさん: 0x456... (未送付)
Cさん: 0x789... (未送付)
```

### 注意点
- **ガス代 (Gas)**: 配布するたびに少額のSUI（Testnetならテスト用SUI）が必要です。残高が足りなくなったら `sui client faucet` で補充してください。
- **確認**: コマンド実行後、出力される `Transaction Digest` を [SuiScan](https://suiscan.xyz/testnet/home) で検索すると、正しく送られたか確認できます。
- **相手側の確認**: 相手には「Slushウォレットなどで Testnet ネットワークに切り替えて、NFTタブを見てみて」と伝えてください。

---

## 📝 タイトルと説明文の変更について
`--args` の最初の2つの値を変更するだけで、それぞれ異なるメッセージを添えることができます。
- 1つ目の引数: **タイトル** (例: `"Meow Champion #1"`)
- 2つ目の引数: **説明文** (例: `"Keep up the great work in our team!"`)
