#!/bin/bash

# ==========================================
# Meow NFT バーン（削除）用スクリプト
# ==========================================

# --- ローカル設定の読み込み ---
if [ -f "config.local" ]; then
    source config.local
else
    echo "❌ エラー: config.localが見つかりません。"
    exit 1
fi

MODULE="meow_nft"

# 引数チェック (オブジェクトIDを受け付ける)
if [ "$#" -lt 1 ]; then
    echo "❌ エラー: 削除するNFTの Object ID を指定してください。"
    echo "使い方: ./burn_nft.sh 0xオブジェクトID"
    exit 1
fi

NFT_ID=$1

echo "------------------------------------------"
echo "🔥 NFTの削除（バーン）を開始します..."
echo "対象Object ID: $NFT_ID"
echo "------------------------------------------"

# Sui CLIの実行
sui client call \
    --function burn \
    --module $MODULE \
    --package $PACKAGE_ID \
    --args "$NFT_ID" \
    --gas-budget 10000000 \
    --json

if [ $? -eq 0 ]; then
    echo "✅ 削除に成功しました！"
else
    echo "❌ 失敗しました。自分が所有しているNFTか、IDが正しいか確認してください。"
fi
echo "------------------------------------------"
