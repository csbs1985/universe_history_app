import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AllForNowComponent extends StatelessWidget {
  const AllForNowComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        DividerComponent(),
        Center(
          child: Text(
            'Isso é tudo por enquanto.',
            style: uiTextStyle.text2,
          ),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
