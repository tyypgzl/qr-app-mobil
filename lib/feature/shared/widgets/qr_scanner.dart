import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key, required this.onRead}) : super(key: key);

  final void Function(String? barcode)? onRead;

  @override
  BarcodeScannerWithControllerState createState() =>
      BarcodeScannerWithControllerState();
}

class BarcodeScannerWithControllerState extends State<QrScanner>
    with SingleTickerProviderStateMixin {
  String? barcode;

  MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
    facing: CameraFacing.back,
  );

  bool isStarted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.cover,
                onDetect: (barcode, args) {
                  setState(() {
                    this.barcode = barcode.rawValue;
                    widget.onRead!(barcode.rawValue);
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
