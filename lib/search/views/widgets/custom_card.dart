import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.congressmanName,
    required this.congressmanPoliticalParty,
    required this.congressmanPhotoUrl,
    required this.onPressed,
    super.key,
  });

  final void Function()? onPressed;
  final String congressmanName;
  final String congressmanPoliticalParty;
  final String congressmanPhotoUrl;

  @override
  Widget build(BuildContext context) {
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
          onPressed: onPressed,
          icon: const Icon(Icons.info_outline_rounded),
        ),
      ),
    );
  }
}
