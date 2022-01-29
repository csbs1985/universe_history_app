import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/icon_component.dart';
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
          icon: SvgPicture.asset(uiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent(title: 'Sobre'),
              const SizedBox(
                height: 10,
              ),
              IconComponent(svg: uiSvg.logo),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Versão',
                style: uiTextStyle.text2,
              ),
              const Text(
                'v1.0.0(c)',
                style: uiTextStyle.text1,
              ),
              const Text(
                '17 de janeiro de 2022 às 10:20',
                style: uiTextStyle.text1,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'History e os logotipos e logomarcas do History são marcas registradas de Universe Inc. Todos os direitos registrados.',
                style: uiTextStyle.text1,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'History foi construído usando software de código aberto e licenciado.',
                style: uiTextStyle.text1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
