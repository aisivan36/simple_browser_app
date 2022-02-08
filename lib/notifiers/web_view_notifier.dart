import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../resources/strings_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNotifier extends StateNotifier<WebViewController?> {
  WebViewNotifier() : super(null);

  void setWebView(WebViewController webViewController) {
    state = webViewController;
  }

  void openWebPage({required String url}) {
    if (url.isEmpty) return;

    const String dot = ".";

    if (url.isNotEmpty && !url.contains(dot)) {
      url = '${AppStrings.initialSearch}$url';
    } else {
      if (!url.startsWith(AppStrings.https) &&
          !url.startsWith(AppStrings.http)) {
        url = '${AppStrings.https}$url';
      }
    }

    state!.loadUrl(url);
  }
}
