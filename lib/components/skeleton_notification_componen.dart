import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class SkeletonNotificationComponent extends StatelessWidget {
  const SkeletonNotificationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width - 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  width: double.infinity,
                  height: 16,
                  textColor: uiColor.comp_3,
                  borderRadius: BorderRadius.circular(uiBorder.rounded),
                ),
                const SizedBox(height: 10),
                Skeleton(
                  width: (MediaQuery.of(context).size.width * .8),
                  height: 16,
                  textColor: uiColor.comp_3,
                  borderRadius: BorderRadius.circular(uiBorder.rounded),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
