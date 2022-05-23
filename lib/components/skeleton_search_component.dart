import 'package:flutter/cupertino.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class SkeletonSearchComponent extends StatelessWidget {
  const SkeletonSearchComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(
          width: double.infinity,
          height: 28,
          textColor: uiColor.comp_3,
          borderRadius: BorderRadius.circular(uiBorder.rounded),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Skeleton(
              width: 100,
              height: 16,
              textColor: uiColor.comp_3,
              borderRadius: BorderRadius.circular(uiBorder.rounded),
            ),
            const SizedBox(width: 10),
            Skeleton(
              width: 100,
              height: 16,
              textColor: uiColor.comp_3,
              borderRadius: BorderRadius.circular(uiBorder.rounded),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Skeleton(
          width: double.infinity,
          height: 80,
          textColor: uiColor.comp_3,
          borderRadius: BorderRadius.circular(uiBorder.rounded),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (var i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Skeleton(
                  width: 50,
                  height: 16,
                  textColor: uiColor.comp_3,
                  borderRadius: BorderRadius.circular(uiBorder.rounded),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
