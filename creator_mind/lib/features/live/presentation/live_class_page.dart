import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveClassPage extends StatelessWidget {
  const LiveClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    final playbackUrl = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Live Class")),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadHtmlString("""
            <html>
              <body style="margin:0;background:black">
                <video autoplay controls playsinline
                  style="width:100%;height:100%"
                  src="$playbackUrl">
                </video>
              </body>
            </html>
          """),
      ),
    );
  }
}
