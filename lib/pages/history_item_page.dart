import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/input_comment_component.dart';

class HistoryItemPage extends StatelessWidget {
  const HistoryItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Text('texto'),
          ],
        ),
      ),
    );
  }
}


// child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Expanded(
//               child: Text('alguma cois'),
//             ),
//             Positioned(
//               bottom: 0,
//               child: InputCommentComponent(false),
//             ),
//           ],
//         ),