import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';

class SkeletonActivityComponent extends StatelessWidget {
  const SkeletonActivityComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: UiSize.iconCircle,
            height: UiSize.iconCircle,
            textColor: UiColor.comp_3,
            borderRadius: BorderRadius.circular(UiBorder.circle),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width: MediaQuery.of(context).size.width - 82,
                height: 16,
                textColor: UiColor.comp_3,
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
              const SizedBox(height: 4),
              Skeleton(
                width: 100,
                height: 12,
                textColor: UiColor.comp_3,
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
