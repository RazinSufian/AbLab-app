import 'package:ab_lab_app/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../view/auth_views/auth_view.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){

    // case RoutesName.menu:
    //   return CupertinoPageRoute(builder: (_) => MenuView(),);
    // case RoutesName.menu:
    // return PageTransition(type: PageTransitionType.bottomToTop, child: MenuView());
    case RoutesName.auth:
    return CupertinoPageRoute(builder: (_) => AuthPage());


      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}