import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatefulWidget {
  final String code;
  final Function() closescreen;
  const ResultPage({super.key, required this.code, required this.closescreen});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.closescreen();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "The QR code says:",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.code,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Copy code to clipboard
                    Clipboard.setData(ClipboardData(text: widget.code));

                    // Show a snackbar to confirm the action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Code copied to clipboard!')),
                    );
                  },
                  child: const Text(
                    'Copy Code',
                  ),
                ),
                ElevatedButton(
                    onPressed: () => setState(() {
                          var link = widget.code;
                          launchUrl(Uri.parse(link),
                              mode: LaunchMode.externalApplication);
                        }),
                    // onPressed: () {
                    //
                    // },
                    child: const Text('Open URL'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
