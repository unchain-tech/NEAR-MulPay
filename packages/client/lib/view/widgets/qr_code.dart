import 'package:flutter/material.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key, this.qrImage}) : super(key: key);
  final qrImage;
  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        child: Center(
          child: widget.qrImage,
        ),
      ),
    );
  }
}
