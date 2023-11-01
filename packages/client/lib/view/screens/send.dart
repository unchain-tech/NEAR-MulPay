// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:client/view/screens/qr_code_scan.dart';
import 'package:provider/provider.dart';
import '../../model/contract_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Send extends StatefulWidget {
  const Send({Key? key}) : super(key: key);

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  Token dropdownValueOfSecond = ContractModel().tokenList[2];
  Token dropdownValueOfThird = ContractModel().tokenList[2];
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
          //   margin: EdgeInsets.symmetric(horizontal: displayWidth * 0.08),
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height:
          //             isDeskTop ? (displayHeight * 0.01) : (displayHeight * 0.04),
          //       ),
          //       SizedBox(
          //         height:
          //             isDeskTop ? (displayHeight * 0.06) : (displayHeight * 0.04),
          child: Row(
            children: [
              Text(
                'Send',
                style: isDeskTop
                    ? const TextStyle(fontSize: 50)
                    : (Theme.of(context).textTheme.headlineSmall),
              ),
            ],
          ),
          //     ),
          //     SizedBox(
          //       height: displayHeight * 0.01,
          //     ),
          //     Expanded(
          //       child: SingleChildScrollView(
          //         child: ConstrainedBox(
          //           constraints:
          //               BoxConstraints(maxHeight: displayHeight * 0.82),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Column(
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         "①Input receiver's wallet address",
          //                         style: GoogleFonts.roboto(
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: isDeskTop ? 30 : 17,
          //                           color: Colors.black,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: displayHeight * 0.015,
          //                   ),
          //                   Container(
          //                     margin: EdgeInsets.symmetric(
          //                         horizontal: displayWidth * 0.05),
          //                     color: Colors.white,
          //                     child: TextFormField(
          //                       decoration: InputDecoration(
          //                         enabledBorder: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(3),
          //                           borderSide: const BorderSide(
          //                             color: Colors.grey,
          //                             width: 1.0,
          //                           ),
          //                         ),
          //                         focusedBorder: OutlineInputBorder(
          //                           borderRadius: BorderRadius.circular(3),
          //                           borderSide: BorderSide(
          //                             color: HexColor('#19667E'),
          //                             width: 2.0,
          //                           ),
          //                         ),
          //                         labelText: 'ex) 0x96324xv029...',
          //                       ),
          //                       controller: addressController,
          //                     ),
          //                   ),
          //                   GestureDetector(
          //                     onTap: () async {
          //                       final result = await Navigator.of(context).push(
          //                         MaterialPageRoute(
          //                           builder: (context) => QRCodeScan(),
          //                         ),
          //                       );

          //                       if (!mounted) return;

          //                       if (result == null) {
          //                         Fluttertoast.showToast(
          //                           msg: "Couldn\'t get recipient address",
          //                           toastLength: Toast.LENGTH_SHORT,
          //                           timeInSecForIosWeb: 1,
          //                           backgroundColor: Colors.black,
          //                           textColor: Colors.white,
          //                           fontSize: 16.0,
          //                         );
          //                       } else {
          //                         addressController.text = result;
          //                       }
          //                       setState(() {});
          //                     },
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       children: [
          //                         const SizedBox(width: 18),
          //                         SizedBox(
          //                           height: 22,
          //                           width: 22,
          //                           child: SvgPicture.asset(
          //                             'assets/pop.svg',
          //                             color: Colors.grey,
          //                           ),
          //                         ),
          //                         Text(
          //                           ' scan QR code',
          //                           style: TextStyle(
          //                             color: Colors.grey,
          //                             fontSize: isDeskTop ? 20 : 12,
          //                             fontWeight: FontWeight.w600,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         "②Select coin you want to transfer \n and input amount",
          //                         style: GoogleFonts.roboto(
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: isDeskTop ? 30 : 17,
          //                           color: Colors.black,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Container(
          //                         decoration: BoxDecoration(
          //                           borderRadius: const BorderRadius.all(
          //                             Radius.circular(15),
          //                           ),
          //                           color: HexColor('#D9D9D9'),
          //                         ),
          //                         width: displayWidth * 0.4,
          //                         height: displayHeight * 0.12,
          //                         child: DropdownButtonHideUnderline(
          //                           child: DropdownButton2(
          //                             buttonWidth: 20,
          //                             buttonHeight: 20,
          //                             customButton: Container(
          //                                 child: Row(
          //                               children: [
          //                                 const SizedBox(
          //                                   width: 5,
          //                                 ),
          //                                 SizedBox(
          //                                   width: displayWidth * 0.13,
          //                                   child: Column(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment.center,
          //                                     children: [
          //                                       SizedBox(
          //                                         height: isDeskTop ? 80 : 50,
          //                                         width: isDeskTop ? 80 : 50,
          //                                         child: Image.asset(
          //                                             dropdownValueOfSecond
          //                                                 .imagePath),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 const SizedBox(
          //                                   width: 5,
          //                                 ),
          //                                 SizedBox(
          //                                   height: displayHeight * 0.12,
          //                                   width: displayWidth * 0.14,
          //                                   child: Column(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment.center,
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.start,
          //                                     children: [
          //                                       const SizedBox(
          //                                         height: 10,
          //                                       ),
          //                                       Text(
          //                                         dropdownValueOfSecond.symbol,
          //                                         style: TextStyle(
          //                                           fontWeight: FontWeight.bold,
          //                                           color: Colors.black,
          //                                           fontSize:
          //                                               isDeskTop ? 28 : 14,
          //                                         ),
          //                                       ),
          //                                       const SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                       Text(
          //                                         dropdownValueOfSecond.name,
          //                                         style: TextStyle(
          //                                           fontWeight: FontWeight.bold,
          //                                           color: Colors.grey,
          //                                           fontSize:
          //                                               isDeskTop ? 24 : 12,
          //                                         ),
          //                                       ),
          //                                       const SizedBox(
          //                                         height: 20,
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 const SizedBox(
          //                                   width: 10,
          //                                 ),
          //                                 SizedBox(
          //                                   height: isDeskTop ? 40 : 20,
          //                                   width: isDeskTop ? 40 : 20,
          //                                   child: SvgPicture.asset(
          //                                     "assets/triangle.svg",
          //                                     color: HexColor("#628A8A"),
          //                                   ),
          //                                 ),
          //                               ],
          //                             )),
          //                             icon: Icon(
          //                               Icons.arrow_drop_down,
          //                               size: 30,
          //                               color: HexColor("#628A8A"),
          //                             ),
          //                             onChanged: (Token? newValue) {
          //                               setState(() {
          //                                 dropdownValueOfSecond = newValue!;
          //                               });
          //                             },
          //                             items: tokenList
          //                                 .map<DropdownMenuItem<Token>>(
          //                                     (Token value) {
          //                               return DropdownMenuItem<Token>(
          //                                 value: value,
          //                                 child: Row(
          //                                   children: [
          //                                     SizedBox(
          //                                       height: 30,
          //                                       width: 30,
          //                                       child: Image.asset(
          //                                           value.imagePath),
          //                                     ),
          //                                     const SizedBox(
          //                                       width: 10,
          //                                     ),
          //                                     Text(value.symbol)
          //                                   ],
          //                                 ),
          //                               );
          //                             }).toList(),
          //                           ),
          //                         ),
          //                       ),
          //                       Container(
          //                         margin: EdgeInsets.symmetric(horizontal: 20),
          //                         height: displayHeight * 0.12,
          //                         width: displayWidth * 0.32,
          //                         decoration: BoxDecoration(
          //                           borderRadius: const BorderRadius.all(
          //                             Radius.circular(15),
          //                           ),
          //                           color: HexColor('#D9D9D9'),
          //                         ),
          //                         child: Row(
          //                           children: [
          //                             Container(
          //                               margin: EdgeInsets.symmetric(
          //                                   horizontal: 15,
          //                                   vertical: displayHeight * 0.026),
          //                               width: isDeskTop
          //                                   ? (displayWidth * 0.24)
          //                                   : (displayWidth * 0.12),
          //                               color: Colors.white,
          //                               child: TextFormField(
          //                                 decoration: InputDecoration(
          //                                   enabledBorder: OutlineInputBorder(
          //                                     borderRadius:
          //                                         BorderRadius.circular(3),
          //                                     borderSide: const BorderSide(
          //                                       color: Colors.grey,
          //                                       width: 1.0,
          //                                     ),
          //                                   ),
          //                                   focusedBorder: OutlineInputBorder(
          //                                     borderRadius:
          //                                         BorderRadius.circular(3),
          //                                     borderSide: BorderSide(
          //                                       color: HexColor('#19667E'),
          //                                       width: 2.0,
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 keyboardType: TextInputType.number,
          //                                 inputFormatters: [
          //                                   LengthLimitingTextInputFormatter(3),
          //                                 ],
          //                                 controller: amountController,
          //                               ),
          //                             ),
          //                             SizedBox(
          //                               height: double.infinity,
          //                               child: Column(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.end,
          //                                 children: [
          //                                   Text(
          //                                     dropdownValueOfSecond.symbol,
          //                                     style: TextStyle(
          //                                       fontSize: isDeskTop ? 32 : 20,
          //                                       fontWeight: FontWeight.bold,
          //                                     ),
          //                                   ),
          //                                   SizedBox(
          //                                     height: displayHeight * 0.026,
          //                                   )
          //                                 ],
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //               Column(
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         "③Select coin recipient want",
          //                         style: GoogleFonts.roboto(
          //                           fontWeight: FontWeight.bold,
          //                           fontSize: isDeskTop ? 30 : 17,
          //                           color: Colors.black,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     height: 20,
          //                   ),
          //                   Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius: const BorderRadius.all(
          //                         Radius.circular(15),
          //                       ),
          //                       color: HexColor('#D9D9D9'),
          //                     ),
          //                     width: displayWidth * 0.7,
          //                     height: displayHeight * 0.12,
          //                     child: DropdownButtonHideUnderline(
          //                       child: DropdownButton2(
          //                         buttonWidth: 20,
          //                         buttonHeight: 20,
          //                         customButton: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             const SizedBox(
          //                               width: 5,
          //                             ),
          //                             SizedBox(
          //                               width: displayWidth * 0.13,
          //                               child: Column(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.center,
          //                                 children: [
          //                                   SizedBox(
          //                                     height: isDeskTop ? 80 : 50,
          //                                     width: isDeskTop ? 80 : 50,
          //                                     child: Image.asset(
          //                                         dropdownValueOfThird
          //                                             .imagePath),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             const SizedBox(
          //                               width: 15,
          //                             ),
          //                             SizedBox(
          //                               height: displayHeight * 0.12,
          //                               width: displayWidth * 0.14,
          //                               child: Column(
          //                                 mainAxisAlignment:
          //                                     MainAxisAlignment.center,
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   const SizedBox(
          //                                     height: 10,
          //                                   ),
          //                                   Text(
          //                                     dropdownValueOfThird.symbol,
          //                                     style: TextStyle(
          //                                       fontWeight: FontWeight.bold,
          //                                       color: Colors.black,
          //                                       fontSize: isDeskTop ? 28 : 14,
          //                                     ),
          //                                   ),
          //                                   const SizedBox(
          //                                     height: 5,
          //                                   ),
          //                                   Text(
          //                                     dropdownValueOfThird.name,
          //                                     style: TextStyle(
          //                                       fontWeight: FontWeight.bold,
          //                                       color: Colors.grey,
          //                                       fontSize: isDeskTop ? 24 : 12,
          //                                     ),
          //                                   ),
          //                                   const SizedBox(
          //                                     height: 20,
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                             const SizedBox(
          //                               width: 70,
          //                             ),
          //                             SizedBox(
          //                               height: isDeskTop ? 40 : 20,
          //                               width: isDeskTop ? 40 : 20,
          //                               child: SvgPicture.asset(
          //                                 "assets/triangle.svg",
          //                                 color: HexColor("#628A8A"),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                         icon: Icon(
          //                           Icons.arrow_drop_down,
          //                           size: 30,
          //                           color: HexColor("#628A8A"),
          //                         ),
          //                         onChanged: (Token? newValue) {
          //                           setState(() {
          //                             dropdownValueOfThird = newValue!;
          //                           });
          //                         },
          //                         items: tokenList.map<DropdownMenuItem<Token>>(
          //                             (Token value) {
          //                           return DropdownMenuItem<Token>(
          //                             value: value,
          //                             child: Row(
          //                               children: [
          //                                 SizedBox(
          //                                   height: 30,
          //                                   width: 30,
          //                                   child: Image.asset(value.imagePath),
          //                                 ),
          //                                 const SizedBox(
          //                                   width: 10,
          //                                 ),
          //                                 Text(value.symbol)
          //                               ],
          //                             ),
          //                           );
          //                         }).toList(),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               Container(
          //                 margin: EdgeInsets.only(bottom: displayHeight * 0.02),
          //                 child: SizedBox(
          //                   height: displayHeight * 0.1,
          //                   width: isDeskTop
          //                       ? (displayWidth * 0.9)
          //                       : (displayWidth * 0.7),
          //                   child: ElevatedButton(
          //                     onPressed: () async {
          //                       await contractModel.sendToken(
          //                         dropdownValueOfSecond.contractName,
          //                         dropdownValueOfSecond.address,
          //                         dropdownValueOfThird.address,
          //                         addressController.text,
          //                         int.parse(amountController.text),
          //                       );
          //                       setState(() {
          //                         dropdownValueOfSecond = tokenList[2];
          //                       });
          //                       dropdownValueOfThird = tokenList[2];
          //                       addressController.clear();
          //                       amountController.clear();
          //                     },
          //                     child: Text(
          //                       'Transfer',
          //                       style: GoogleFonts.patuaOne(
          //                         fontWeight: FontWeight.w500,
          //                         fontSize: 27,
          //                         color: Colors.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
