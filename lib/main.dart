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

import 'whereToDesign/change_notifier/boat_provider_change_notifire.dart';
import 'whereToDesign/home_page.dart';
import 'whereToDesign/new_design_slivers/pages/sliver_page.dart';

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
// GoRoute(
//   path: '/',
//   builder: (context, state) => const HomePage(),
// ),
// GoRoute(
//   path: '/futureProvider',
//   builder: (context, state) {
//     // Wrap your widget with Consumer to access the ref
//     return Consumer(
//       builder: (context, ref, child) {
//         // Access your provider
//         final boatListHolder = ref.watch(boatProviderChangeNotifier);

//         // Now you can use boatListHolder in the FutureProvide widget
//         return FutureProvide(
//           boatListHolder: boatListHolder,
//         );
//       },
//     );
//   },
// ),

//..................................................................
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
      builder: (context, state) =>
          Consumer(builder: (BuildContext context, ref, _) {
        final boatListHolder = ref.watch(boatProviderChangeNotifier);
        return boatListHolder.value == true
            ? HomePage(
                //  searchFilterList: [], searchValue: false,
                //filterList: [],
                // newBoatList: const [],
                //isUserLoggedIn: true,
                )
            : SliverBar();
      }),
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
