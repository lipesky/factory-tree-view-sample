import 'package:factory_tree_viewer/modules/fake_service/model/company.dart';
import 'package:factory_tree_viewer/modules/company_viewer/company_tree_viewer_page.dart';
import 'package:factory_tree_viewer/modules/company_viewer/locations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == null) {
      return MaterialPageRoute(builder: (context) => const LocationsPage());
    }
    if (settings.name!.trim() == '/') {
      return MaterialPageRoute(builder: (context) => const LocationsPage());
    } else if (settings.name!.startsWith('/company') &&
        settings.arguments != null) {
      final Company company = Company.fromJson(
          (settings.arguments as Map<String, dynamic>)['company']);
      return MaterialPageRoute(
          builder: (context) => CompanyTreeViewerPager(company: company));
    }
    return MaterialPageRoute(builder: (context) => const LocationsPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: onGenerateRoute,
      home: const LocationsPage(),
    );
  }
}
