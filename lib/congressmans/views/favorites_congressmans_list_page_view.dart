import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend_api_congressman/congressmans/controllers/controllers.dart';
import 'package:frontend_api_congressman/congressmans/models/models.dart';
import 'package:frontend_api_congressman/congressmans/views/views.dart';
import 'package:frontend_api_congressman/congressmans/views/widgets/custom_card.dart';
import 'package:frontend_api_congressman/shared/widgets/widget_state.dart';

class FavoritesCongressmansListPageView
    extends WidgetState<FavoritesPageController> {
  final List<CongressmanModel> favoritesList;

  FavoritesCongressmansListPageView({
    required this.favoritesList,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesListNotifier = useState(favoritesList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Favoritos'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: ValueListenableBuilder(
                          valueListenable: favoritesListNotifier,
                          builder: (context, value, child) {
                            return ListView.builder(
                              itemCount: favoritesListNotifier.value.length,
                              itemBuilder: (context, index) {
                                final favoritedCongressman =
                                    favoritesListNotifier.value[index];

                                return CustomCard(
                                  congressmanName: favoritedCongressman.name,
                                  congressmanPoliticalParty:
                                      favoritedCongressman
                                          .abbreviationPoliticalParty,
                                  congressmanPhotoUrl:
                                      favoritedCongressman.urlPhoto,
                                  iconOnpressed: () async {
                                    final newList = await controller
                                        .saveCongressmanToStorage(
                                      favoritesListNotifier.value,
                                      favoritedCongressman,
                                    );
                                    favoritesListNotifier.value = newList;
                                  },
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CongressmanInfoPageView(
                                          congressmanModel:
                                              favoritedCongressman,
                                        ),
                                      ),
                                    );
                                  },
                                  isFavorited: true,
                                );
                              },
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
