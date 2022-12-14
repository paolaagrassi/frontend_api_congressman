// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend_api_congressman/congressmans/controllers/controllers.dart';
import 'package:frontend_api_congressman/congressmans/models/models.dart';
import 'package:frontend_api_congressman/congressmans/views/views.dart';
import 'package:frontend_api_congressman/congressmans/views/widgets/widgets.dart';
import 'package:frontend_api_congressman/shared/widgets/widget_state.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class SearchPageView extends WidgetState<SearchPageController> {
  SearchPageView({super.key});

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<CongressmanModel>> congressmanList = useState([]);

    Future<void> loadCongressmans() async {
      await controller.getAllCongressmans().then(
            (value) => congressmanList.value = value,
          );
    }

    useEffect(
      () {
        loadCongressmans();
        return null;
      },
      [],
    );

    void onSearchChanged(String query) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        final filteredList = controller.filterList(query);

        congressmanList.value = filteredList;
      });
    }

    Future onLoadMore() async {
      await Future.delayed(
        const Duration(seconds: 2),
      );
      final congressmanNewList =
          controller.getMoreDataByCount(congressmanList.value.length);

      congressmanList.value = congressmanNewList;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deputados'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesCongressmansListPageView(
                    favoritesList: controller.favoritedCongressmansList,
                  ),
                ),
              );
              await loadCongressmans();
            },
            icon: const Icon(Icons.favorite_border_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomSearchField(
                  onChanged: onSearchChanged,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: ValueListenableBuilder(
                          valueListenable: congressmanList,
                          builder: (context, value, child) {
                            return LazyLoadScrollView(
                              onEndOfPage: onLoadMore,
                              child: ListView.builder(
                                itemCount: congressmanList.value.length,
                                itemBuilder: (context, index) {
                                  final congressman =
                                      congressmanList.value[index];

                                  return CustomCard(
                                    congressmanPhotoUrl: congressman.urlPhoto,
                                    congressmanName: congressman.name,
                                    congressmanPoliticalParty:
                                        congressman.abbreviationPoliticalParty,
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CongressmanInfoPageView(
                                            congressmanModel: congressman,
                                          ),
                                        ),
                                      );
                                    },
                                    iconOnpressed: () async {
                                      await controller.saveCongressmanToStorage(
                                        congressman,
                                      );
                                    },
                                    isFavorited:
                                        controller.isCongressmanFavorited(
                                      congressman,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
