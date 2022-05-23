import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class AppbarBackComponent extends StatelessWidget with PreferredSizeWidget {
  const AppbarBackComponent({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(uiSize.appBar),
      child: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(uiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
