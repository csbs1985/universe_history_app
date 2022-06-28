import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

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
              Text(
                'v${_packageInfo.version}',
                style: UiTextStyle.text1,
              ),
              const SizedBox(height: 20),
              const Text(
                'Número do build',
                style: UiTextStyle.text2,
              ),
              Text(
                _packageInfo.buildNumber,
                style: UiTextStyle.text1,
              ),
              const SizedBox(height: 20),
              const Text(
                'History e os logotipos e logomarcas do History são marcas registradas de Universe Inc. Todos os direitos registrados.',
                style: UiTextStyle.text1,
              ),
              const SizedBox(height: 20),
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
/**    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown', */