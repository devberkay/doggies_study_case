import 'package:dog_appnation/model/router/go_router_singleton.dart';
import 'package:dog_appnation/service/os_version_service.dart';
import 'package:dog_appnation/service/path_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  PathSingleton().setAppDir = (await getTemporaryDirectory()).path;
  await OsVersionService().readVersion(); 
  runApp(const DoggnationApp());
}

class DoggnationApp extends StatefulWidget {
  const DoggnationApp({super.key});

  @override
  State<DoggnationApp> createState() => _DoggnationAppState();
}

class _DoggnationAppState extends State<DoggnationApp> {
  late final GoRouter _router;

  @override
  void initState() {
    _router = GoRouterSingleton().getInstance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Doggnation',
      theme: ThemeData(
        fontFamily: "Galano Grotesque",
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0055D3)),
        useMaterial3: true,
      ),
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
    );
  }
}
