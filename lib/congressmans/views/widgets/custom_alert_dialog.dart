import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.builder});

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Erro no servidor. Tente novamente mais tarde!',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      content: Image.asset(
        'assets/errorWarning.png',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();

            MaterialPageRoute(
              builder: builder,
            );

            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
