import 'package:design/hompage.dart';
import 'package:design/svg.dart';
import 'package:flutter/material.dart';
import 'package:design/second.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design/provider.dart';
import 'package:design/model2.dart';
import 'package:design/futureProvider.dart';
import 'package:design/streamProvider.dart';
import 'package:design/svg.dart';

final stnprovider = StateNotifierProvider<Ddd, int>((ref) => Ddd());
final nameProvider = StateProvider<int>((ref) => 0);
final apiProvider = Provider<ApiService>((ref) => ApiService());
final userProvider = FutureProvider<List<UserModel>>((ref) {
  return ref.read(apiProvider).getdata();
});
final strmProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
      Duration(seconds: 3), (((computationCount) => computationCount)));
});
void main() {
  runApp(
    MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Svgg() //ProviderScope(
        //child: FutureProvide(),
        ),
  );
}
