import 'package:design/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class StrProvid extends ConsumerWidget {
  const StrProvid({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(strmProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
        centerTitle: true,
      ),
      body: value.when(
        data: (TT) => Center(
          child: Text(
            TT.toString(),
          ),
        ),
        error: (error, StackTrace) => Text('error'),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
