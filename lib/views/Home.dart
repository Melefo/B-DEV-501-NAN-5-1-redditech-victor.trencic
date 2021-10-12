import 'package:app/controllers/Controller.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';

//view
class Home extends StatefulWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<Home> createState() => _Home();
}

//state
class _Home extends StateMVC<Home> {
  final Controller controller = Controller();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
              title: Text(widget.title)
          )
      );
}