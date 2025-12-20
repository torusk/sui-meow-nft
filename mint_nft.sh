#!/bin/bash

# ==========================================
# Meow NFT 配布用オートメーションスクリプト
# ==========================================

# --- ローカル設定の読み込み ---
if [ -f "config.local" ]; then
    source config.local
else
    # config.localがない場合のデフォルト(GitHub公開用)
    PACKAGE_ID="0xa9151794e08d2feb3e1261a2718b42c787cfdeb296ba282dae44aca208957818"
    IMAGE_URL="ipfs://bafkreibczy52boyldncw4ohzqvyl5qagiyoip76q7u33qpvmc75r5mfsx4"
    NFT_TITLE="[タイトル未設定]"
    NFT_DESC="[説明文未設定]"
fi

MODULE="meow_nft"

# --- スクリプト本体 ---

# 引数チェック (アドレスを受け付ける)
if [ "$#" -lt 1 ]; then
    echo "❌ エラー: アドレスを指定してください。"
    echo "使い方: ./mint_nft.sh 0x相手のアドレス"
    exit 1
fi

RECIPIENT=$1

echo "------------------------------------------"
echo "🚀 NFTのミントと配布を開始します..."
echo "タイトル: $NFT_TITLE"
echo "説明文  : $NFT_DESC"
echo "配布先  : $RECIPIENT"
echo "------------------------------------------"

# Sui CLIの実行
sui client call \
    --function mint \
    --module $MODULE \
    --package $PACKAGE_ID \
    --args "$NFT_TITLE" "$NFT_DESC" "$IMAGE_URL" "$RECIPIENT" \
    --gas-budget 20000000 \
    --json

if [ $? -eq 0 ]; then
    echo "✅ 成功しました！"
else
    echo "❌ 失敗しました。"
fi
echo "------------------------------------------"
