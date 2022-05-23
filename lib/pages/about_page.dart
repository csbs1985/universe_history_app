import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(UiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitleComponent(title: 'Sobre'),
              SizedBox(
                height: 20,
              ),
              LogoComponent(),
              SizedBox(
                height: 20,
              ),
              Text(
                'Versão',
                style: UiTextStyle.text2,
              ),
              Text(
                'v1.0.0(c)',
                style: UiTextStyle.text1,
              ),
              Text(
                '17 de janeiro de 2022 às 10:20',
                style: UiTextStyle.text1,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'History e os logotipos e logomarcas do History são marcas registradas de Universe Inc. Todos os direitos registrados.',
                style: UiTextStyle.text1,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'History foi construído usando software de código aberto e licenciado.',
                style: UiTextStyle.text1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
