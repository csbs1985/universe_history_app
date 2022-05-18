// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class SkeletonCommentComponent extends StatelessWidget {
  const SkeletonCommentComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
              width: double.infinity,
              height: 24,
              textColor: uiColor.comp_3,
              borderRadius: BorderRadius.circular(uiBorder.rounded)),
          const SizedBox(height: 10),
          Row(children: [
            Skeleton(
                width: 100,
                height: 12,
                textColor: uiColor.comp_3,
                borderRadius: BorderRadius.circular(uiBorder.rounded)),
            const SizedBox(width: 10),
            Skeleton(
                width: 100,
                height: 12,
                textColor: uiColor.comp_3,
                borderRadius: BorderRadius.circular(uiBorder.rounded)),
          ]),
          const SizedBox(height: 10)
        ]);
  }
}
