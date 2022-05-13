// ignore_for_file: unnecessary_new, unnecessary_import, override_on_non_overriding_member, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class AppbarBackComponent extends StatelessWidget with PreferredSizeWidget {
  const AppbarBackComponent({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(uiSize.appBar),
      child: AppBar(
        leading: IconButton(
            icon: SvgPicture.asset(uiSvg.closed),
            onPressed: () => Navigator.of(context).pop()),
      ),
    );
  }
}
