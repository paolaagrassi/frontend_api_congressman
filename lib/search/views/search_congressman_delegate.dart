import 'package:flutter/material.dart';

import 'package:frontend_api_congressman/search/models/models.dart';
import 'package:frontend_api_congressman/search/views/widgets/widgets.dart';

class SearchCongressmanDelegate extends SearchDelegate {
  ValueNotifier<List<CongressmanModel>> congressmanList;

  SearchCongressmanDelegate(
    this.congressmanList,
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      body: Expanded(
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
                  return ListView.builder(
                    itemCount: congressmanList.value.length,
                    itemBuilder: (context, index) {
                      final congressman = congressmanList.value[index];

                      return CustomCard(
                        onPressed: () {},
                        congressmanPhotoUrl: congressman.urlPhoto,
                        congressmanName: congressman.name,
                        congressmanPoliticalParty:
                            congressman.abbreviationPoliticalParty,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Pesquise o deputado'),
    );
  }
}
