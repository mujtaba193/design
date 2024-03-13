import 'dart:async';
import 'dart:convert';

import 'package:design/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserModel {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;
  UserModel(
      {required this.id,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.avatar});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        email: json['email'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        avatar: json['avatar']);
  }
}

class ApiService {
  Future<List<UserModel>> getdata() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?pahe=1'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

class FutureProvide extends ConsumerWidget {
  const FutureProvide({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(userProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('FutureProvider'),
          centerTitle: true,
        ),
        body: value.when(
          data: (mm) {
            return ListView.builder(
              itemCount: mm.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text('${mm[index].first_name} ${mm[index].last_name}'),
                  subtitle: Text(mm[index].email),
                  leading: CircleAvatar(
                    child: Image.network(mm[index].avatar),
                  ),
                );
              }),
            );
          },
          error: ((error, StackTrace) => const Text('error')),
          loading: (() {
            return const Center(child: CircularProgressIndicator());
          }),
        ));
  }
}
