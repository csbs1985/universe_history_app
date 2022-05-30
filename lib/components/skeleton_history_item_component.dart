import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class SkeletonHistoryItemComponent extends StatelessWidget {
  const SkeletonHistoryItemComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: double.infinity,
            height: 20,
            textColor: UiColor.comp_3,
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Skeleton(
                width: 100,
                height: 12,
                textColor: UiColor.comp_3,
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
              const SizedBox(width: 10),
              Skeleton(
                width: 100,
                height: 12,
                textColor: UiColor.comp_3,
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Skeleton(
            width: double.infinity,
            height: 32,
            textColor: UiColor.comp_3,
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                width: 120,
                height: 12,
                textColor: UiColor.comp_3,
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Skeleton(
                    width: 40,
                    height: 12,
                    textColor: UiColor.comp_3,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                  const SizedBox(width: 10),
                  Skeleton(
                    width: 40,
                    height: 12,
                    textColor: UiColor.comp_3,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                  const SizedBox(width: 10),
                  Skeleton(
                    width: 40,
                    height: 12,
                    textColor: UiColor.comp_3,
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
