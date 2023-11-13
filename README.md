# 💬 NEAR MulPay(prototype)

本レポジトリは NEAR MulPay の完成版を示したものになります。

## 実行方法

事前に[こちら](https://app.unchain.tech/learn/NEAR-MulPay/ja/0/2/)のページを参考にして環境構築を行なってください。

### 1. レポジトリのクローン

[こちら](https://github.com/unchain-tech/NEAR-MulPay.git)から NEAR MulPay をクローンします。

クローンが完了したら、プロジェクトに移動して下のコマンドを実行してください。必要なパッケージをインストールします。

```
yarn
```

### 2. コントラクトのデプロイ

`packages/contract`ディレクトリに`.env`ファイルを作成し、下のように記述しましょう。`YOUR_PRIVATE_KEY`には Metamask の秘密鍵を指定してください。

```
AURORA_PRIVATE_KEY="YOUR_PRIVATE_KEY"
```

.env ファイルを作成したら下のコマンドを実行しましょう。

```
yarn contract deploy
```

デプロイ完了後に表示された各コントラクトのアドレスは、次のステップで使用します。

### 3. フロントエンドの起動

`packages/client`ディレクトリに`.env`ファイルを作成し、下のように記述しましょう。

```
SWAP_CONTRACT_ADDRESS="YOUR_SWAP_CONTRACT_ADDRESS"
AOA_CONTRACT_ADDRESS="YOUR_AOA_CONTRACT_ADDRESS"
DAI_CONTRACT_ADDRESS="YOUR_DAI_CONTRACT_ADDRESS"
ETH_CONTRACT_ADDRESS="YOUR_ETH_CONTRACT_ADDRESS"
MATIC_CONTRACT_ADDRESS="YOUR_MATIC_CONTRACT_ADDRESS"
SHIB_CONTRACT_ADDRESS="YOUR_SHIB_CONTRACT_ADDRESS"
SOL_CONTRACT_ADDRESS="YOUR_SOL_CONTRACT_ADDRESS"
UNI_CONTRACT_ADDRESS="YOUR_UNI_CONTRACT_ADDRESS"
USDT_CONTRACT_ADDRESS="YOUR_USDT_CONTRACT_ADDRESS"

SWAP_CONTRACT_NAME="SwapContract"
AOA_CONTRACT_NAME="AuroraToken"
DAI_CONTRACT_NAME="DaiToken"
ETH_CONTRACT_NAME="EthToken"
MATIC_CONTRACT_NAME="PolygonToken"
SHIB_CONTRACT_NAME="ShibainuToken"
SOL_CONTRACT_NAME="SolanaToken"
UNI_CONTRACT_NAME="UniswapToken"
USDT_CONTRACT_NAME="TetherToken"

AURORA_TESTNET_INFURA_KEY="YOUR_INFURA_KEY"

WALLETCONNECT_PROJECT_ID="YOUR_PROJECT_ID"
```

- `YOUR_xxx_CONTRACT_ADDRESS`：2. でデプロイしたコントラクトのアドレスを指定してください。
- `YOUR_INFURA_KEY`：環境構築で作成した Infura の API Key を指定してください。
- `YOUR_PROJECT_ID`：環境構築で作成した WalletConnect の Project ID を指定してください。

.env ファイルを作成したら下のコマンドを実行しましょう。flutter のパッケージをインストールします。

```
yarn client flutter:install
```

エミュレータや実機が接続されていることを確認し、下のコマンドを実行しましょう。

```
yarn client flutter:run
```

アプリケーションを操作してみましょう。[こちら](https://app.unchain.tech/learn/NEAR-MulPay/ja/3/1/)のページのように動作していれば成功です！
