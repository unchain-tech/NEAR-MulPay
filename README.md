## 💬 NEAR-Mulpay(prototype)

本レポジトリは NEAR-Mulpay の完成版を示したものになります。

以下の手順を実行することで NEAR-Mulpay の挙動を確認できます。

### レポジトリのクローン

[こちら](https://github.com/unchain-tech/NEAR-MulPay.git)から NEAR-Mulpay をクローンします。

### コントラクトとフロントの準備

1. 環境構築

[こちら](https://app.unchain.tech/learn/NEAR-MulPay/ja/0/2/)のページを参考にして環境構築を行います。

2. キーの指定とテスト

packages/client, packages/contract 下に.env ファイルを作成し、下のように コントラクトのアドレス,名前と Infura の key を指定しましょう。Infura の key に関しては 1.　において作成したものを使用します。

[packages/contract]

```
AURORA_PRIVATE_KEY=METAMASKのPrivateKey
```

[packages/client]

```
AOA_CONTRACT_ADDRESS = "0x10Fc0df445Cc2be44Af50C008a83248b26228Df4"
SHIB_CONTRACT_ADDRESS = "0x53541b23074e4E14AE32f02aFc299E1990590D44"
ETH_CONTRACT_ADDRESS = "0x78C4F9eBF32E2a02Cd0dAE561DD0FAFF7bA64b9a"
SOL_CONTRACT_ADDRESS = "0xb2C9AA59BE1ba9bfda60EEa8a40d57aA08A8A49b"
USDT_CONTRACT_ADDRESS = "0x0004976DD6E9Bf9148d46706845962A5AD5F429e"
UNI_CONTRACT_ADDRESS = "0x9528bf0F166f0f167cbb1e028Ba951852e83927a"
MATIC_CONTRACT_ADDRESS = "0xE91fAD00f61076f9274e1656f263597B6ddA090D"
DAI_CONTRACT_ADDRESS = "0x7363F3bBf35fda8E14C98794EAc4196DbeDc76cC"
SWAP_CONTRACT_ADDRESS = "0x734156aE604355bEc16762168994bEb09b899da7"

SWAP_CONTRACT_NAME = "SwapContract"
DAI_CONTRACT_NAME = "DaiToken"
ETH_CONTRACT_NAME = "EthToken"
AOA_CONTRACT_NAME = "AuroraToken"
SHIB_CONTRACT_NAME = "ShibainuToken"
SOL_CONTRACT_NAME = "SolanaToken"
USDT_CONTRACT_NAME = "TetherToken"
UNI_CONTRACT_NAME = "UniswapToken"
MATIC_CONTRACT_NAME = "PolygonToken"

INFURA_KEY_TEST = InfuraのPrivateKey
```

次に下のコマンドを実行することでコントラクトのテスト＋コンパイルができます。

```
yarn contract test
```

下のような結果が出ていれば成功です！

```
  Swap Contract
    Deployment
1000000000000000000000000
      ✔ ERC20 token is minted from smart contract (1556ms)
value of ETH/DAI is 0.1
      ✔ Get value between DAI and ETH
Before transfer, address_1 has 0 ETH
After transfer, address_1 has 0.1 ETH
      ✔ swap function (103ms)


  3 passing (2s)

✨  Done in 4.05s.
```

3. コントラクトのデプロイとフロントへの反映

`packages/contract`ディレクトリに移動し、以下のコマンドを実行しましょう。

```
yarn contract deploy
```

下記のような結果がでていれば成功です。

```
Deploying contracts with the account: 0xa9eD1748Ffcda5442dCaEA242603E7e3FF09dD7F
Account balance: 228411549210000000
deployer address is 0xa9eD1748Ffcda5442dCaEA242603E7e3FF09dD7F
Swap Contract is deployed to: 0x734156aE604355bEc16762168994bEb09b899da7
DaiToken is deployed to: 0x7363F3bBf35fda8E14C98794EAc4196DbeDc76cC
EthToken is deployed to: 0x78C4F9eBF32E2a02Cd0dAE561DD0FAFF7bA64b9a
AoaToken is deployed to: 0x10Fc0df445Cc2be44Af50C008a83248b26228Df4
ShibToken is deployed to: 0x53541b23074e4E14AE32f02aFc299E1990590D44
SolToken is deployed to: 0xb2C9AA59BE1ba9bfda60EEa8a40d57aA08A8A49b
UsdtToken is deployed to: 0x0004976DD6E9Bf9148d46706845962A5AD5F429e
UniToken is deployed to: 0x9528bf0F166f0f167cbb1e028Ba951852e83927a
MaticToken is deployed to: 0xE91fAD00f61076f9274e1656f263597B6ddA090D
```

これでコントラクトとフロントエンドの準備は完了です！

### フロントエンドを起動

下のコマンドを実行させることでフロントエンドの動きを確認してみましょう。

どのコマンドを走らせるか聞かれるので下のように`run`と打ち込んで Enter を押すと PC のエミュレータまたは実機に Mulpay が立ち上がり動作確認ができます。

![](/public/1.png)

[こちら](https://app.unchain.tech/learn/NEAR-MulPay/ja/3/1/)のページのように動作していれば成功です！

```
yarn client run
```
