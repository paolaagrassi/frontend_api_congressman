// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomCard extends HookWidget {
  final void Function()? iconOnpressed;
  void Function()? onTap;
  final String congressmanName;
  final String congressmanPoliticalParty;
  final String congressmanPhotoUrl;
  final bool isFavorited;

  CustomCard({
    required this.congressmanName,
    required this.congressmanPoliticalParty,
    required this.congressmanPhotoUrl,
    required this.iconOnpressed,
    required this.onTap,
    required this.isFavorited,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isCongressmanFavoritedNotifier = useState(isFavorited);

    return Card(
      child: ListTile(
        title: Text(
          congressmanName,
          style: const TextStyle(
            color: Color.fromARGB(255, 2, 126, 95),
          ),
        ),
        subtitle: Text(congressmanPoliticalParty),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            congressmanPhotoUrl,
            fit: BoxFit.fill,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            isCongressmanFavoritedNotifier.value =
                !isCongressmanFavoritedNotifier.value;
            iconOnpressed?.call();
          },
          icon: Icon(
            isCongressmanFavoritedNotifier.value
                ? Icons.favorite_rounded
                : Icons.favorite_border_outlined,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
