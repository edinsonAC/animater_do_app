import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  const NavegacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('Notifications page'),
        ),
        floatingActionButton: const BotonFlotante(),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numNot = Provider.of<_NotificationModel>(context).numero;

    return BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.pink,
        items: [
          const BottomNavigationBarItem(
              label: 'Bones', icon: FaIcon(FontAwesomeIcons.bone)),
          BottomNavigationBarItem(
              label: 'Notifiacations',
              icon: Stack(
                children: [
                  const FaIcon(FontAwesomeIcons.bell),
                  Positioned(
                    top: 0,
                    right: 0,
                    // child: Icon(
                    //   Icons.brightness_1,
                    //   size: 8,
                    //   color: Colors.redAccent,
                    // ),
                    child: BounceInDown(
                      from: 15,
                      animate: numNot > 0 ? true : false,
                      child: Bounce(
                        from: 10,
                        controller: (controller) =>
                            Provider.of<_NotificationModel>(context)
                                .bounceController = controller,
                        child: Container(
                          alignment: Alignment.center,
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                              color: Colors.redAccent, shape: BoxShape.circle),
                          child: Text(
                            '$numNot',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 7),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          const BottomNavigationBarItem(
              label: 'My dog', icon: FaIcon(FontAwesomeIcons.dog))
        ]);
  }
}

class BotonFlotante extends StatelessWidget {
  const BotonFlotante({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.pink,
        child: const FaIcon(FontAwesomeIcons.play),
        onPressed: () {
          final notiModel =
              Provider.of<_NotificationModel>(context, listen: false);
          int numero = notiModel.numero;
          numero++;
          notiModel.numero = numero;

          if (numero >= 2) {
            final controller = notiModel.bounceController;

            controller.forward(from: 0.0);
          }
        });
  }
}

class _NotificationModel with ChangeNotifier {
  int _numero = 0;
  AnimationController? _bounceController;
  int get numero => _numero;
  set numero(int valor) {
    _numero = valor;
    notifyListeners();
  }

  AnimationController get bounceController => _bounceController!;

  set bounceController(AnimationController controller) {
    _bounceController = controller;
  }
}
