import 'package:design/hompage.dart';
import 'package:design/main.dart';
import 'package:design/model2.dart';
import 'package:design/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Go extends StatelessWidget {
  const Go({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      //home:ProviderScope(
      //child: Prov(),
      routerConfig: router,
    );
  }
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
      builder: (context, state) => Hompage(
        isUserLoggedIn: isUserLoggedIn,
      ),
      routes: [
        GoRoute(
          path: 'provoider',
          builder: (context, state) => const Prov(),
        ),
        GoRoute(
          path: 'futureProvider',
          builder: (context, state) => const UseresModel(),
        )
      ],
    ),
  ],
);
