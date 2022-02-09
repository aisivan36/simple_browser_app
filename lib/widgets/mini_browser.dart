import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ValueProgress extends StateNotifier<double> {
  ValueProgress() : super(0);

  void value(double value) {
    state = value / 100;
  }
}

final stateValue = StateNotifierProvider<ValueProgress, double>(
  (ref) => ValueProgress(),
);

class MiniBrowser extends ConsumerWidget {
  const MiniBrowser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) =>
            ref.read(webViewProvider.notifier).setWebView(webViewController),
        initialUrl: ref.watch(webPageProvider),
        onProgress: (val) {
          if (kDebugMode) {
            print("Progress $val");
          }
          ref.read(stateValue.notifier).value(val.toDouble());

          // if (val == 100) {
          //   if (kDebugMode) {
          //     print("Completed $val");
          //   }
          //   ref.read(stateValue.notifier).value(false);
          // }
        },
        onWebResourceError: (error) =>
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Error with page ${error.failingUrl}",
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        )),
        onPageStarted: (url) =>
            ref.read(webPageProvider.notifier).setWebPage(url),
      ),
    );
  }
}

class ProgressWebLoad extends ConsumerWidget {
  const ProgressWebLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(ref.watch(stateValue).toDouble());
    return LinearProgressIndicator(
      color: Colors.blue,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      backgroundColor: Colors.black,
      value: ref.watch(stateValue).toDouble(),
    );
  }
}
