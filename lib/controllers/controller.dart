import 'package:app/models/Model.dart';
import 'package:mvc_application/controller.dart';

class Controller extends ControllerMVC {
  factory Controller() => _this ??= Controller._();

  static Controller? _this;
  late Model model;

  Controller._()
  {
    model = Model();
  }
}
