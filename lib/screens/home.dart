import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../resources/values_manager.dart';
import '../widgets/favorite_button.dart';
import '../widgets/favorite_pages.dart';
import '../widgets/mini_browser.dart';
import '../widgets/search_bar.dart';
import '../widgets/up_down_button.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShowedFavoriteProvider = ref.watch(showedFavoriteProvider);

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSize.s5),
          child: Row(
            children: [
              const SearchBar(),
              const SizedBox(width: AppSize.s15),
              const FavoriteButton(),
              const SizedBox(width: AppSize.s15),
              const UpDownButton(),
              IconButton(
                  onPressed: () async {
                    if (await ref.read(webViewProvider)!.canGoBack()) {
                      ref.read(webViewProvider)?.goBack();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_sharp))
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          if (isShowedFavoriteProvider) const FavoritePages(),
          const MiniBrowser(),
          ref.watch(stateValue).toDouble() != 1.0
              ? Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  child: const ProgressWebLoad())
              : const SizedBox()
        ],
      ),
    );
  }
}
