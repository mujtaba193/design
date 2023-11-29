import 'dart:async';

import 'package:design/goRouter.dart';
import 'package:design/hompage.dart';
import 'package:design/loover2.dart';
import 'package:design/router.dart';
import 'package:design/svg.dart';
import 'package:design/value.dart';
import 'package:flutter/material.dart';
import 'package:design/loovr.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design/provider.dart';
import 'package:design/model2.dart';
import 'package:design/futureProvider.dart';
import 'package:design/streamProvider.dart';
import 'package:design/svg.dart';
import 'package:design/third.dart';
import 'package:go_router/go_router.dart';
import 'package:design/themeProvder.dart';

//import 'package:design/router.dart';
final themeProvid = StateProvider<bool>((ref) => true);
final isUserLoggedIn = true;
final stnprovider = StateNotifierProvider.autoDispose<Ddd, int>((ref) {
  final l = ref.keepAlive();
  final timer = Timer(Duration(seconds: 10), () {
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
    Duration(seconds: 3),
    (((computationCount) => computationCount)),
  );
});
void main() {
  runApp(
    /*MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Loovr2()*/
    ProviderScope(
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
      builder: (context, state) => Loovr(),
      routes: [
        GoRoute(
          path: 'loover2',
          builder: (context, state) => Loovr2(),
        ),
        GoRoute(
          path: 'value',
          builder: (context, state) => Val(),
        ),
        GoRoute(
          path: 'model2',
          builder: (context, state) => UseresModel(),
        )
      ],
    ),
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
