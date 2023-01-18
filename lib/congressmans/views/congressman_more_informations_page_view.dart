import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend_api_congressman/congressmans/controllers/congressman_more_info_page_controller.dart';
import 'package:frontend_api_congressman/congressmans/models/models.dart';
import 'package:frontend_api_congressman/congressmans/views/search_page_view.dart';
import 'package:frontend_api_congressman/congressmans/views/widgets/widgets.dart';
import 'package:frontend_api_congressman/shared/widgets/widget_state.dart';

class CongressmanInfoPageView
    extends WidgetState<CongressmanMoreInfoController> {
  final CongressmanModel congressmanModel;

  CongressmanInfoPageView({
    required this.congressmanModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isCongressmansInformationsLoaded =
        useState(false);

    final ValueNotifier<CongressmanMoreInfoModel> congressmanInformations =
        useState(
      CongressmanMoreInfoModel(
        abbreviationGender: '',
        education: '',
        birthCity: '',
      ),
    );

    useEffect(
      () {
        controller.getMoreInformation(id: congressmanModel.id).then((result) {
          if (result.isSuccess) {
            congressmanInformations.value = result.extractSuccess;
            isCongressmansInformationsLoaded.value = true;
          }

          if (result.isError) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  builder: (context) => SearchPageView(),
                );
              },
            );
          }
        });
        return null;
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o parlamentar'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 30),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            child: Image.network(
                              congressmanModel.urlPhoto,
                              fit: BoxFit.fill,
                              height: 100,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  congressmanModel.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  congressmanModel.abbreviationPoliticalParty,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: isCongressmansInformationsLoaded.value
                              ? Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Gênero: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            congressmanInformations
                                                .value.abbreviationGender,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Naturalidade: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            congressmanInformations
                                                .value.birthCity,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Escolaridade: ',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            congressmanInformations
                                                .value.education,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : const Align(
                                  child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 3, 170, 128),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
