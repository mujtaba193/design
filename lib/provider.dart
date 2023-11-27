import 'package:design/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Prov extends ConsumerStatefulWidget {
  Prov({super.key});

  @override
  _ProvState createState() => _ProvState();
}

class _ProvState extends ConsumerState<Prov> {
  @override
  Widget build(BuildContext context) {
    final value = ref.watch(nameProvider);
    final value2 = ref.watch(stnprovider);
    ref.listen(stnprovider, (previous, next) {
      if (next == 6) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('The val is $next')));
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text('The Provider'), actions: [
        IconButton(
          onPressed: () {
            ref.invalidate(nameProvider);
          },
          icon: Icon(Icons.refresh),
        ),
      ]),
      body: Center(
        child: Text(
          value2.toString(),
          style: TextStyle(
              color: const Color.fromARGB(255, 231, 226, 226), fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ref.read(nameProvider.notifier).state++;
          //ref.read(nameProvider.notifier).update((state) => state + 2);
          ref.read(stnprovider.notifier).incremant();
        },
        child: Icon(Icons.add),
      ),

      /*floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: () => ref.read(nameProvider.notifier).state++,
              child: Icon(Icons.add),
            ),
            Expanded(
              child: FloatingActionButton(
                onPressed: () => ref.read(nameProvider.notifier).state--,
                child: Icon(Icons.remove),
              ),
            ),
          ],
        ),
      ),*/
      backgroundColor: const Color.fromARGB(255, 54, 52, 52),
    );
  }
}

class Ddd extends StateNotifier<int> {
  Ddd() : super(0);
  void incremant() {
    state++;
  }
}
