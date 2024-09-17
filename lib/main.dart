import 'package:ab_lab_app/routes/routes.dart';
import 'package:ab_lab_app/routes/routes_name.dart';
import 'package:ab_lab_app/view_model/report_list_view_model.dart';
import 'package:ab_lab_app/view_model/sales_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart'; // Localization support


void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Always portrait mode orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Optional
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SalesViewModel()),
        ChangeNotifierProvider(create: (_) => ReportListViewModel())// Add ReportViewModel provider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        locale: const Locale('en'), // Default language
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        themeMode: ThemeMode.light,
        initialRoute: RoutesName.auth,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
