// ignore_for_file: use_function_type_syntax_for_parameters

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend_api_congressman/search/controllers/congressman_more_info_page_controller.dart';
import 'package:frontend_api_congressman/search/models/models.dart';
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
        controller.getMoreInformation(id: congressmanModel.id).then((value) {
          congressmanInformations.value = value;
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300,
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
                                        congressmanModel
                                            .abbreviationPoliticalParty,
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
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Gênero: ${congressmanInformations.value.abbreviationGender}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Naturalidade: ${congressmanInformations.value.birthCity}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'Escolaridade: ${congressmanInformations.value.education}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                        ),
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
