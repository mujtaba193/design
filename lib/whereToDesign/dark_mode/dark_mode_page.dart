// import 'package:design/whereToDesign/tickets/tickets_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DarkModePage extends ConsumerStatefulWidget {
//   const DarkModePage({super.key});

//   @override
//   ConsumerState<DarkModePage> createState() => _DarkModePageState();
// }

// class _DarkModePageState extends ConsumerState<DarkModePage> {
//   @override
//   Widget build(BuildContext context) {
//     final darkMode = ref.watch(darkModProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Mode'),
//       ),
//       body: Center(
//         child: Switch(
//           value: darkMode,
//           onChanged: (value) {
//             ref.read(darkModProvider.notifier).toggle();
//             ref.invalidate(darkModProvider);
//           },
//         ),
//       ),
//     );
//   }
// }
