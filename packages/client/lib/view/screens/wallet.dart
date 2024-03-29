import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '/model/contract_model.dart';
import '/view/widgets/qr_code.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Token dropdownValue = ContractModel().tokenList[2];
  List<Token> tokenList = ContractModel().tokenList;
  TextEditingController addressController = TextEditingController();
  final amountController = TextEditingController();

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
                    Text(
                      'Wallet',
                      style: isDeskTop
                          ? const TextStyle(fontSize: 50)
                          : (Theme.of(context).textTheme.headlineSmall),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: displayHeight * 0.02,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: HexColor('#D9D9D9'),
                      ),
                      width: double.infinity,
                      height: displayHeight * 0.12,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "wallet address",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isDeskTop ? 27 : 17,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(
                              contractModel.getAccount(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 35,
                                color: HexColor("#56CCC5"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight * 0.01,
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => QRCode(
                              qrImage: QrImageView(
                            data: contractModel.getAccount(),
                            size: 200,
                          )),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              fontSize: isDeskTop ? 24 : 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: displayHeight * 0.1,
                    ),
                    SizedBox(
                      height: displayHeight * 0.19,
                      child: SvgPicture.asset("assets/wallet_screen_img.svg"),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select coin and push the right button",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isDeskTop ? 30 : 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      color: HexColor('#D9D9D9'),
                                    ),
                                    width: displayWidth * 0.4,
                                    height: displayHeight * 0.12,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        buttonWidth: 20,
                                        buttonHeight: 20,
                                        customButton: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width: displayWidth * 0.13,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: isDeskTop ? 80 : 50,
                                                    width: isDeskTop ? 80 : 50,
                                                    child: Image.asset(
                                                        dropdownValue
                                                            .imagePath),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              height: displayHeight * 0.12,
                                              width: displayWidth * 0.14,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    dropdownValue.symbol,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize:
                                                          isDeskTop ? 28 : 14,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    dropdownValue.name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize:
                                                          isDeskTop ? 24 : 12,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: isDeskTop ? 40 : 20,
                                              width: isDeskTop ? 40 : 20,
                                              child: SvgPicture.asset(
                                                "assets/triangle.svg",
                                                color: HexColor("#628A8A"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 30,
                                          color: HexColor("#628A8A"),
                                        ),
                                        onChanged: (Token? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: tokenList
                                            .map<DropdownMenuItem<Token>>(
                                                (Token value) {
                                          return DropdownMenuItem<Token>(
                                            value: value,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: Image.asset(
                                                      value.imagePath),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(value.symbol)
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: displayWidth * 0.05,
                                  ),
                                  SizedBox(
                                    height: displayHeight * 0.08,
                                    width: displayWidth * 0.37,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          await contractModel.distributeToken(
                                              dropdownValue.address);
                                        } catch (error) {
                                          debugPrint('distributeToken: $error');
                                        }
                                      },
                                      child: Text(
                                        'Get 100 ${dropdownValue.symbol}!',
                                        style: GoogleFonts.patuaOne(
                                          fontWeight: FontWeight.w500,
                                          fontSize: isDeskTop ? 34 : 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: displayHeight * 0.1,
                            width: isDeskTop
                                ? (displayWidth * 0.9)
                                : (displayWidth * 0.7),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/signIn');
                              },
                              child: Text(
                                'Disconnect',
                                style: GoogleFonts.patuaOne(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 27,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
