#!/bin/bash

# ==========================================
# Meow NFT 配布用オートメーションスクリプト
# ==========================================

# --- 設定項目 (ここを編集) ---
# デプロイ済みのパッケージID
PACKAGE_ID="0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818"
# NFTの画像URL (IPFS)
IMAGE_URL="ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4"
# モジュール名
MODULE="meow_nft"

# --- スクリプト本体 ---

# 引数チェック
if [ "$#" -ne 3 ]; then
    echo "❌ エラー: 引数が足りません。"
    echo "使い方: ./mint_nft.sh \"タイトル\" \"説明文\" \"相手のアドレス\""
    echo "例: ./mint_nft.sh \"Meow Champion #1\" \"Good Job!\" 0x1234abcd..."
    exit 1
fi

TITLE=$1
DESC=$2
RECIPIENT=$3

echo "------------------------------------------"
echo "🚀 NFTのミントと配布を開始します..."
echo "タイトル: $TITLE"
echo "説明文  : $DESC"
echo "配布先  : $RECIPIENT"
echo "------------------------------------------"

# Sui CLIの実行
sui client call \
    --function mint \
    --module $MODULE \
    --package $PACKAGE_ID \
    --args "$TITLE" "$DESC" "$IMAGE_URL" "$RECIPIENT" \
    --gas-budget 20000000 \
    --json

# 結果の判定
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 成功しました！"
    echo "配布が完了しました。SuiScanなどで確認してください。"
else
    echo ""
    echo "❌ 失敗しました。"
    echo "エラー内容は上記を確認してください。"
fi
echo "------------------------------------------"
