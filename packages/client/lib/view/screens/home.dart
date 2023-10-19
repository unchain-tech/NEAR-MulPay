import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:client/model/contract_model.dart';
import 'package:client/view/widgets/qr_code.dart';
import 'package:client/view/widgets/coin.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.of(context).size.height;
    final displayWidth = MediaQuery.of(context).size.width;
    var contractModel = Provider.of<ContractModel>(context, listen: true);
    final isDeskTop = ResponsiveBreakpoints.of(context).largerThan(MOBILE);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: displayWidth * 0.08),
          child: Column(
            children: [
              SizedBox(
                height:
                    isDeskTop ? (displayHeight * 0.01) : (displayHeight * 0.04),
              ),
              SizedBox(
                height:
                    isDeskTop ? (displayHeight * 0.06) : (displayHeight * 0.04),
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        'Home',
                        style: isDeskTop
                            ? const TextStyle(fontSize: 50)
                            : (Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: displayHeight * 0.23,
                      width: displayWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            HexColor("3FA1C0"),
                            HexColor("000405"),
                            HexColor("19667E")
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: displayWidth * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: displayHeight * 0.027,
                                  ),
                                  Text(
                                    "Balance",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isDeskTop ? 35 : 13,
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: contractModel.getTotalBalance(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            "${(snapshot.data.toString())} ETH",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isDeskTop ? 28 : 13,
                                                fontWeight: FontWeight.bold),
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        }
                                      })
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                height: isDeskTop ? 55 : 30,
                                width: isDeskTop ? 45 : 22,
                                child: SvgPicture.asset(
                                  'assets/three-dots.svg',
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              SizedBox(
                                width: displayWidth * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: displayWidth * 0.2,
                                    child: Text(
                                      contractModel.account,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: isDeskTop ? 28 : 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (_) => QRCode(
                                            qrImage: QrImage(
                                          data: contractModel.account,
                                          size: 200,
                                        )),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: SvgPicture.asset(
                                            'assets/pop.svg',
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          ' display QR code',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: isDeskTop ? 25 : 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SizedBox(
                                height: isDeskTop ? 55 : 35,
                                width: isDeskTop ? 55 : 35,
                                child: Image.asset(
                                  'assets/unchain_logo.png',
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: displayHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: contractModel.getTokensInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var coinsList = contractModel.tokenList;
                            return ListView.builder(
                                itemCount: coinsList.length,
                                itemBuilder: (context, index) {
                                  return Coins(
                                      displayWidth,
                                      displayHeight,
                                      coinsList[index].imagePath,
                                      coinsList[index].symbol,
                                      coinsList[index].name,
                                      coinsList[index].balance,
                                      (coinsList[index].ethBalance),
                                      isDeskTop);
                                });
                          } else {
                            return const Center(
                                child: CircularProgressIndicator.adaptive());
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
