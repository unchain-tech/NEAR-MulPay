import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../model/contract_model.dart';
import '../widgets/navbar.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  static Web3App? _walletConnect;
  static String? _url;
  static SessionData? _sessionData;

  String get deepLinkUrl => 'metamask://wc?uri=$_url';

  Future<void> _initWalletConnect() async {
    _walletConnect = await Web3App.createInstance(
      projectId: '5eb727cbee79907289c211ebe913fc54',
      metadata: const PairingMetadata(
        name: 'NEAR MulPay',
        description: 'Mobile Payment dApp with Swap Feature',
        url: 'https://walletconnect.com/',
        icons: [
          'https://walletconnect.com/walletconnect-logo.png',
        ],
      ),
    );
  }

  Future<void> connectWallet() async {
    if (_walletConnect == null) {
      await _initWalletConnect();
    }

    try {
      // セッション（dAppとMetamask間の接続）を開始します。
      final ConnectResponse connectResponse = await _walletConnect!.connect(
        requiredNamespaces: {
          'eip155': const RequiredNamespace(
              chains: ['eip155:1313161555'],
              methods: ['eth_signTransaction', 'eth_sendTransaction'],
              events: ['chainChanged']),
        },
      );
      debugPrint('=== connectResponse: $connectResponse'); // TODO: delete
      final Uri? uri = connectResponse.uri;
      if (uri == null) {
        throw Exception('Invalid URI');
      }
      final String encodedUri = Uri.encodeComponent('$uri');
      _url = encodedUri;

      debugPrint('=== _url: $_url'); //TODO: delete

      // Metamaskを起動します。
      await launchUrlString(deepLinkUrl, mode: LaunchMode.externalApplication);

      // セッションが確立されるまで待機します。
      final Completer<SessionData> session = connectResponse.session;
      debugPrint('=== session: $session'); // TODO: delete
      _sessionData = await session.future;
      debugPrint('=== _sessionData: $_sessionData'); // TODO: delete
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.of(context).size.height;
    final displayWidth = MediaQuery.of(context).size.width;
    final isDeskTop = ResponsiveBreakpoints.of(context).largerThan(MOBILE);

    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/multiple-coins.jpg"),
                alignment: Alignment(isDeskTop ? 0 : -0.3, 0.5),
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: displayHeight * 0.1,
                ),
                ShaderMask(
                  blendMode: BlendMode.modulate,
                  shaderCallback: (size) => LinearGradient(
                    colors: [HexColor("#7AD6FE"), HexColor("#04494E")],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(
                    Rect.fromLTWH(0, 0, size.width, size.height),
                  ),
                  child: const Text(
                    "MulPay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: displayHeight * 0.03,
                ),
                Container(
                  width: isDeskTop ? displayWidth * 0.4 : displayWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'You can make a payment\n with multiple kinds of coin',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: displayHeight * 0.5,
                ),
                SizedBox(
                  height: displayHeight * 0.1,
                  width: isDeskTop ? displayWidth * 0.4 : displayWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await connectWallet();
                        debugPrint(
                            '=== Connected to MetaMask !!! ==='); // TODO: delete
                        await context.read<ContractModel>().setConnection(
                            deepLinkUrl, _walletConnect!, _sessionData!);
                        provider.currentIndex = 0;
                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (error) {
                        debugPrint('error $error');
                      }
                    },
                    child: Text(
                      'Connect Wallet',
                      style: GoogleFonts.patuaOne(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
