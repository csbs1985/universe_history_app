import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Column(
        children: const [
          Divider(
            height: 0.5,
            thickness: 0.5,
            indent: 10,
            endIndent: 10,
            color: uiColor.comp_3,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
