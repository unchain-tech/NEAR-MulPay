import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractModel extends ChangeNotifier {
  List<Token> tokenList = [
    Token(
      address: dotenv.env["AOA_CONTRACT_ADDRESS"]!,
      contractName: dotenv.env["AOA_CONTRACT_NAME"]!,
      name: "Aurora",
      symbol: "AOA",
      imagePath: "assets/aurora-aoa-logo.png",
    ),
    Token(
        address: dotenv.env["SHIB_CONTRACT_ADDRESS"]!,
        contractName: dotenv.env["SHIB_CONTRACT_NAME"]!,
        name: "Shibainu",
        symbol: "SHIB",
        imagePath: "assets/shib-logo.png"),
    Token(
        address: dotenv.env["ETH_CONTRACT_ADDRESS"]!,
        contractName: dotenv.env["ETH_CONTRACT_NAME"]!,
        name: "Ethereum",
        symbol: "ETH",
        imagePath: "assets/ethereum-eth-logo.png"),
    Token(
        address: dotenv.env["SOL_CONTRACT_ADDRESS"]!,
        contractName: dotenv.env["SOL_CONTRACT_NAME"]!,
        name: "Solana",
        symbol: "SOL",
        imagePath: "assets/solana-sol-logo.png"),
    Token(
        address: dotenv.env["USDT_CONTRACT_ADDRESS"]!,
        contractName: dotenv.env["USDT_CONTRACT_NAME"]!,
        name: "Tether",
        symbol: "USDT",
        imagePath: "assets/tether-usdt-logo.png"),
    Token(
        address: dotenv.env["UNI_CONTRACT_ADDRESS"]!,
        contractName: dotenv.env["UNI_CONTRACT_NAME"]!,
        name: "Uniswap",
        symbol: "UNI",
        imagePath: "assets/uniswap-uni-logo.png"),
    Token(
        address: dotenv.env["MATIC_CONTRACT_ADDRESS"]!,
        contractName: dotenv.env["MATIC_CONTRACT_NAME"]!,
        name: "Polygon",
        symbol: "MATIC",
        imagePath: "assets/polygon-matic-logo.png"),
  ];

  final SWAP_CONTRACT_ADDRESS = dotenv.env["SWAP_CONTRACT_ADDRESS"];
  final SWAP_CONTRACT_NAME = dotenv.env["SWAP_CONTRACT_NAME"];

  String? _deepLinkUrl;
  String? _account;
  Web3App? _wcClient;
  SessionData? _sessionData;

  late Web3Client auroraClient;
  int ethBalance = 0;
  bool _isLoading = true;
  final String _rpcUrl = "https://testnet.aurora.dev";
  final String _wsUrl = "wss://testnet.aurora.dev";
  final String _deepLink =
      "wc:00e46b69-d0cc-4b3e-b6a2-cee442f97188@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=91303dedf64285cbbaf9120f6e9d160a5c8aa3deb67017a3874cd272323f48ae";

  Web3Client? _client;
  String? _abiCode;

  Credentials? _credentials;
  EthereumAddress? _contractAddress;
  EthereumAddress? _ownAddress;
  DeployedContract? _contract;

  ContractFunction? _transfer;
  ContractFunction? _balanceOf;

  // Web3Connect? _connection;
  // var account;

  ContractModel() {
    init();
  }

  Future<void> init() async {
    // final INFURA_KEY_TEST = dotenv.env["INFURA_KEY_TEST"];
    // http.Client httpClient = http.Client();
    // auroraClient = Web3Client(INFURA_KEY_TEST!, httpClient);
    // _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
    //   return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    // });

    var httpClient = Client();

    auroraClient = Web3Client(dotenv.env["INFURA_KEY_TEST"]!, httpClient);
  }

  // Future<void> getAbi(String contractName) async {
  //   String abiStringFile =
  //       await rootBundle.loadString("smartcontracts/" + contractName + ".json");
  //   var jsonAbi = jsonDecode(abiStringFile);
  //   _abiCode = jsonEncode(jsonAbi["abi"]);
  //   _contractAddress =
  //       EthereumAddress.fromHex(jsonAbi["networks"]["1313161555"]["address"]);
  // }

  getAccount() {
    return _account;
  }

  Future<DeployedContract> getContract(
      String contractName, String contractAddress) async {
    String abi =
        await rootBundle.loadString('smartcontracts/$contractName.json');
    DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(jsonEncode(jsonDecode(abi)["abi"]), contractName),
      EthereumAddress.fromHex(contractAddress),
    );
    return contract;
  }

// This is called for read-only function of contract
  Future<List<dynamic>> query(String contractName, String contractAddress,
      String functionName, List<dynamic> args) async {
    DeployedContract contract =
        await getContract(contractName, contractAddress);
    ContractFunction function = contract.function(functionName);
    List<dynamic> result = await auroraClient.call(
      contract: contract,
      function: function,
      params: args,
    );
    return result;
  }

  Future<EthereumTransaction> generateTransaction(
      String contractName,
      String contractAddress,
      String functionName,
      List<dynamic> parameters) async {
    debugPrint('===== In generateTransaction ====='); // TODO: delete
    debugPrint('=== contractName: $contractName'); // TODO: delete
    debugPrint('=== contractAddress: $contractAddress'); // TODO: delete
    debugPrint('=== functionName: $functionName'); // TODO: delete
    debugPrint('=== parameters: $parameters'); // TODO: delete

    _contract = await getContract(contractName, contractAddress);
    debugPrint('=== _contract: $_contract'); // TODO: delete

    ContractFunction function = _contract!.function(functionName);

    debugPrint('=== function: $function'); // TODO: delete

    // web3dartを使用して、トランザクションを作成します。
    final Transaction transaction = Transaction.callContract(
        contract: _contract!, function: function, parameters: parameters);

    debugPrint('=== transaction: $transaction'); // TODO: delete

    // walletconnect_flutter_v2を使用して、Ethereumトランザクションを作成します。
    final EthereumTransaction ethereumTransaction = EthereumTransaction(
      from: _account!,
      to: contractAddress,
      value: '0x${transaction.value?.getInWei.toRadixString(16) ?? '0'}',
      data: transaction.data != null ? bytesToHex(transaction.data!) : null,
    );

    debugPrint('=== ethereumTransaction: $ethereumTransaction'); // TODO: delete

    return ethereumTransaction;
  }

  Future<String> sendTransaction(EthereumTransaction transaction) async {
    // Metamaskアプリケーションを起動します。
    await launchUrlString(_deepLinkUrl!, mode: LaunchMode.externalApplication);

    // 署名をリクエストします。
    final String signResponse = await _wcClient?.request(
      topic: _sessionData?.topic ?? "",
      chainId: 'eip155:1313161555',
      request: SessionRequestParams(
        method: 'eth_sendTransaction',
        params: [transaction.toJson()],
      ),
    );

    return signResponse;
  }

  Future<void> setConnection(
      String deepLinkUrl, Web3App wcClient, SessionData sessionData) async {
    _deepLinkUrl = deepLinkUrl;
    _wcClient = wcClient;
    _sessionData = sessionData;
    // セッションを認証したアカウントを取得します。
    _account = NamespaceUtils.getAccount(
        sessionData.namespaces.values.first.accounts.first);

    // TODO: delete ====
    debugPrint('=== _account: $_account'); // TODO: delete
    // TODO: delete ====

    notifyListeners();
  }

  Future<String> getBalance(
      String tokenContractName, String tokenAddress) async {
    List<dynamic> result = await query(tokenContractName, tokenAddress,
        'balanceOf', [EthereumAddress.fromHex(_account!)]);
    return result[0].toString();
  }

  Future<String> getEthBalance(String tokenContractName) async {
    List<dynamic> result = await query(
        SWAP_CONTRACT_NAME!, SWAP_CONTRACT_ADDRESS!, 'calculateValue', [
      EthereumAddress.fromHex(dotenv.env["ETH_CONTRACT_ADDRESS"]!),
      EthereumAddress.fromHex(tokenContractName)
    ]);
    return result[0].toString();
  }

  Future<bool> getTokensInfo() async {
    for (int i = 0; i < tokenList.length; i++) {
      final balance =
          await getBalance(tokenList[i].contractName, tokenList[i].address);
      final ethValue = await getEthBalance(tokenList[i].address);
      final ethBalance =
          ((double.parse(ethValue) * double.parse(balance) / (pow(10, 18)))
                  .ceil())
              .toString();
      tokenList[i]
        ..balance = balance
        ..ethBalance = ethBalance;
    }
    return true;
  }

  Future<void> sendToken(String sendTokenContractName, String sendTokenAddress,
      String receiveTokenAddress, String recipientAddress, int amount) async {
    try {
      // トークンの送信を承認します。
      final EthereumTransaction ethereumTransactionOfApprove =
          await generateTransaction(
              sendTokenContractName, sendTokenAddress, "approve", [
        EthereumAddress.fromHex(dotenv.env['SWAP_CONTRACT_ADDRESS']!),
        BigInt.from(amount),
      ]);

      final String signResponseOfApprove =
          await sendTransaction(ethereumTransactionOfApprove);
      debugPrint(
          '=== signResponseOfApprove: $signResponseOfApprove'); // TODO: delete

      final EthereumTransaction ethereumTransactionOfSwap =
          await generateTransaction(
        dotenv.env['SWAP_CONTRACT_NAME']!,
        dotenv.env['SWAP_CONTRACT_ADDRESS']!,
        "swap",
        [
          // measureToken is got rid of
          EthereumAddress.fromHex(sendTokenAddress),
          EthereumAddress.fromHex(sendTokenAddress),
          EthereumAddress.fromHex(receiveTokenAddress),
          BigInt.from(amount),
          EthereumAddress.fromHex(recipientAddress),
        ],
      );

      final String signResponseOfSwap =
          await sendTransaction(ethereumTransactionOfSwap);
      debugPrint('=== signResponseOfSwap: $signResponseOfSwap'); // TODO: delete
    } catch (error) {
      debugPrint('=== error: $error'); // TODO: delete
    } finally {
      notifyListeners();
    }
  }

  Future<void> distributeToken(String tokenAddress) async {
    try {
      debugPrint('=== tokenAddress: $tokenAddress'); // TODO: delete
      final EthereumTransaction ethereumTransaction = await generateTransaction(
        dotenv.env["SWAP_CONTRACT_NAME"]!,
        dotenv.env["SWAP_CONTRACT_ADDRESS"]!,
        "distributeToken",
        [
          EthereumAddress.fromHex(tokenAddress),
          BigInt.from(100),
          EthereumAddress.fromHex(_account!),
        ],
      );

      debugPrint(
          '=== ethereumTransaction: $ethereumTransaction'); // TODO: delete

      final String signResponse = await sendTransaction(ethereumTransaction);
      debugPrint('=== signResponse: $signResponse'); // TODO: delete
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<double> getTotalBalance() async {
    double total = 0;
    for (int i = 0; i < tokenList.length; i++) {
      var balance =
          await getBalance(tokenList[i].contractName, tokenList[i].address);
      var ethValue = await getEthBalance(tokenList[i].address);
      var ethBalance =
          ((double.parse(ethValue) * double.parse(balance) / (pow(10, 18)))
                  .ceil())
              .toString();
      total += double.parse(ethBalance);
    }
    return total;
  }
}

class Token {
  final String address;
  final String contractName;
  final String name;
  final String symbol;
  final String imagePath;
  String? balance;
  String? ethBalance;

  Token({
    required this.address,
    required this.contractName,
    required this.name,
    required this.symbol,
    required this.imagePath,
  }) {
    this.balance = "0";
    this.ethBalance = "0";
  }
}

// Ethereumトランザクションを作成するためのモデルクラス
class EthereumTransaction {
  const EthereumTransaction({
    required this.from,
    required this.to,
    required this.value,
    this.data,
  });

  final String from;
  final String to;
  final String value;
  final String? data;

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'value': value,
        'data': data,
      };
}
