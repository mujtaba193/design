import 'dart:async';

import 'package:design/futureProvider.dart';
import 'package:design/provider.dart';
import 'package:design/where%20to%20design/translation/hive_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'where to design/home_page.dart';

//import 'package:design/router.dart';
final themeProvid = StateProvider<bool>((ref) => true);
const isUserLoggedIn = true;
final stnprovider = StateNotifierProvider.autoDispose<Ddd, int>((ref) {
  final l = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 10), () {
    l.close();
  });
  /* ref.onDispose(
    () => timer.cancel(),
  );*/
  return Ddd();
});
final nameProvider = StateProvider<int>((ref) => 0);
final apiProvider = Provider<ApiService>((ref) => ApiService());
final userProvider = FutureProvider<List<UserModel>>((ref) {
  return ref.read(apiProvider).getdata();
});
final strmProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
    const Duration(seconds: 3),
    (((computationCount) => computationCount)),
  );
});
void main() async {
  AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveBox.langbox);

  runApp(
    /*MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Loovr2()*/
    const ProviderScope(
      child: Myapp(),
      //routerConfig: router,
    ),
  );
}

final GoRouter router = GoRouter(
  /*redirect: (context, state) {
    if (isUserLoggedIn) {
      return "/";
    } else {
      return "/model2";
    }
  },*/
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(
          // newBoatList: const [],
          //isUserLoggedIn: true,
          ),
    ),
    GoRoute(
      path: '/futureProvider',
      builder: (context, state) => FutureProvide(),
    ),

    /*GoRoute(
      path: '/',
      builder: (context, state) => Hompage(
        isUserLoggedIn: true,
      ),
      routes: [
        
        GoRoute(
          path: 'futureProvider',
          builder: (context, state) => const FutureProvide(),
        ),
        GoRoute(
          path: 'value',
          builder: (context, state) => const Val(),
        ),
        GoRoute(
          path: 'model2',
          builder: (context, state) => const UseresModel(),
        )
      ],
    ),*/
  ],
);

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
