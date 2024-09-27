import 'dart:async';

import 'package:design/loover_pages/futureProvider.dart';
import 'package:design/loover_pages/provider.dart';
import 'package:design/whereToDesign/translation/hive_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'whereToDesign/home_page.dart';

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
        searchFilterList: [], searchValue: false,
        //filterList: [],
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

class Myapp extends ConsumerStatefulWidget {
  const Myapp({super.key});

  @override
  ConsumerState<Myapp> createState() => _MyappState();
}

class _MyappState extends ConsumerState<Myapp> {
  @override
  Widget build(BuildContext context) {
    //final darkModeCheck = ref.watch(darkModProvider);
    return MaterialApp.router(
      routerConfig: router,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
