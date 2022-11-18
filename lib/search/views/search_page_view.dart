import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend_api_congressman/search/controllers/controllers.dart';
import 'package:frontend_api_congressman/search/models/congressman_model.dart';
import 'package:frontend_api_congressman/search/views/widgets/widgets.dart';
import 'package:frontend_api_congressman/shared/widgets/widget_state.dart';

class SearchPageView extends WidgetSate<SearchPageController> {
  SearchPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<CongressmanModel>> congressmanList = useState([]);

    useEffect(() {
      controller.getAllCongressmans().then(
            (value) => congressmanList.value = value,
          );

      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deputados'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border_outlined),
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
                const CustomSearchField(),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: ValueListenableBuilder(
                          valueListenable: congressmanList,
                          builder: (context, value, child) {
                            return ListView.builder(
                              itemCount: congressmanList.value.length,
                              itemBuilder: (context, index) {
                                final congressman =
                                    congressmanList.value[index];

                                return CustomCard(
                                  onPressed: () {},
                                  title: congressman.name,
                                  subtitle:
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
