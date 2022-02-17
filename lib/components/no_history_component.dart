import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class NoHistoryComponent extends StatelessWidget {
  const NoHistoryComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Nada para mostrar',
              style: uiTextStyle.header1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Não encontramos histórias que atendam sua pesquisa.',
              style: uiTextStyle.text7,
            ),
            Text(
              'Mas não desista, temos muitas outras histórias para você interagir.',
              style: uiTextStyle.text7,
            ),
          ],
        ),
      ),
    );
  }
}
