import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'result_page.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  ScannerPageState createState() => ScannerPageState();
}

class ScannerPageState extends State<ScannerPage> with WidgetsBindingObserver {
  late MobileScannerController controller;
  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController(detectionSpeed: DetectionSpeed.normal);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      controller.start();
    }
  }

  void closescreen() {
    setState(() {
      isScanned = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
        // backgroundColor: const Color.fromRGBO(54, 69, 79, 1.0),
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("QR Code Scanner",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Place your QR code in the box below",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Scanning will start automatically",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      MobileScanner(
                        controller: controller,
                        onDetect: (BarcodeCapture barcodeCapture) {
                          if (!isScanned) {
                            final String code =
                                barcodeCapture.barcodes.first.rawValue ?? '---';
                            isScanned = true;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  code: code,
                                  closescreen: closescreen,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      QRScannerOverlay(
                        overlayColor: Colors.white,
                        borderColor: Colors.black,
                      )
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Made with ❤️ by Vedant",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
