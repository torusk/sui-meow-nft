---
description: NFTをグループメンバーに順次配布する手順
---

1. メンバーの「ウォレットアドレス」を聞き取ります
2. 下記のコマンドテンプレートの `TITLE`, `DESC`, `ADDRESS` を書き換えて実行します

```bash
sui client call \
  --function mint \
  --module meow_nft \
  --package 0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818 \
  --args "TITLE" "DESC" "ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4" ADDRESS \
  --gas-budget 10000000
```

3. 宛先、タイトル、説明文が正しいか最終確認してから Enter を押してください。
4. 実行後、Transaction Digest が表示されれば完了です。
5. Suiscan などで、入力した ADDRESS に NFT が届いているか確認できます。
