import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class NoResultComponent extends StatelessWidget {
  const NoResultComponent({required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
      child: Column(
        children: [
          const Text(
            'Nada para mostrar',
            style: UiTextStyle.text1,
            textAlign: TextAlign.center,
          ),
          Text(
            _text,
            style: UiTextStyle.text2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
