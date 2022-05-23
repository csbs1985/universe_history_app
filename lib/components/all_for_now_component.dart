import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AllForNowComponent extends StatelessWidget {
  const AllForNowComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: const [
          Center(
            child: Text(
              'Isso é tudo por enquanto.',
              style: uiTextStyle.text2,
            ),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}
