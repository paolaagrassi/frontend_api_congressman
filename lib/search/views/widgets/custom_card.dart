import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.onPressed,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final void Function()? onPressed;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 2, 126, 95),
          ),
        ),
        subtitle: Text(subtitle),
        leading: const Icon(
          Icons.person_outline_rounded,
          size: 50,
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.info_outline),
        ),
      ),
    );
  }
}
