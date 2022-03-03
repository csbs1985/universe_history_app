// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class SkeletonMyHistoryComponent extends StatelessWidget {
  const SkeletonMyHistoryComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: double.infinity,
            height: 48,
            textColor: uiColor.comp_3,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Skeleton(
                width: 100,
                height: 16,
                textColor: uiColor.comp_3,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(
                width: 10,
              ),
              Skeleton(
                width: 100,
                height: 16,
                textColor: uiColor.comp_3,
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
