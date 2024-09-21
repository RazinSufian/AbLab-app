import 'package:ab_lab_app/routes/routes_name.dart';
import 'package:ab_lab_app/view/menu_view.dart';
import 'package:ab_lab_app/view/report_list_viwes/report_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../view/auth_views/auth_view.dart';
import '../view/patient_entry_views/patient_entry.dart';
import '../view/report_list_viwes/report_list_view.dart';
import '../view/sales_views/sales_view.dart';
import '../view/setting_views/settings_view.dart';
import '../view/test_views/test_view.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){

    case RoutesName.menu:
      return CupertinoPageRoute(builder: (_) => MenuView(),);
    case RoutesName.menu:
    return PageTransition(type: PageTransitionType.bottomToTop, child: MenuView());
    case RoutesName.auth:
    return CupertinoPageRoute(builder: (_) => AuthPage());
    case RoutesName.sales:
    return PageTransition(type: PageTransitionType.rightToLeft, child: SalesPage());
    case RoutesName.patientList:
    return PageTransition(type: PageTransitionType.rightToLeft, child: ReportListPage());
    case RoutesName.patientEntry:
    return PageTransition(type: PageTransitionType.rightToLeft, child: PatientEntryPage());
    case RoutesName.tests:
    return PageTransition(type: PageTransitionType.rightToLeft, child: TestsPage());
    case RoutesName.settings:
    return PageTransition(type: PageTransitionType.rightToLeft, child: SettingsPage());
    case RoutesName.report_details_view:
    return PageTransition(type: PageTransitionType.rightToLeft, child: ReportView());


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