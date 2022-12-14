import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend_api_congressman/shared/controllers/base_controller.dart';
import 'package:kiwi/kiwi.dart';

abstract class WidgetState<T extends BaseController> extends HookWidget {
  final T controller = KiwiContainer().resolve<T>();

  WidgetState({super.key});
}
