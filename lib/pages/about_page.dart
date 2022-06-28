import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent(title: 'Sobre'),
              Container(
                height: 32,
                width: 140,
                child: SvgPicture.asset(UiSvg.logo),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              ),
              const Text(
                'Versão',
                style: UiTextStyle.text2,
              ),
              const Text(
                'v1.0.0(c)',
                style: UiTextStyle.text1,
              ),
              const Text(
                '17 de janeiro de 2022 às 10:20',
                style: UiTextStyle.text1,
              ),
              const SizedBox(height: 30),
              const Text(
                'History e os logotipos e logomarcas do History são marcas registradas de Universe Inc. Todos os direitos registrados.',
                style: UiTextStyle.text1,
              ),
              const SizedBox(height: 30),
              const Text(
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
