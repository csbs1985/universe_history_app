// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_field

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/comment_component.dart';
import 'package:universe_history_app/shared/models/history.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:universe_history_app/theme/ui_svgs.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryItemComponent extends StatefulWidget {
  const HistoryItemComponent(this.allHistory);
  final List<History> allHistory;

  @override
  _HistoryItemComponentState createState() => _HistoryItemComponentState();
}

class _HistoryItemComponentState extends State<HistoryItemComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.allHistory.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.allHistory[index].title,
                style: uiTextStyle.header1,
              ),
              Text(
                widget.allHistory[index].date + ' - anonimo',
                style: uiTextStyle.text2,
              ),
              const SizedBox(
                height: 10,
              ),
              ExpandableText(
                widget.allHistory[index].text,
                style: uiTextStyle.text1,
                expandText: 'continuar lendo',
                collapseText: 'fechar',
                maxLines: 20,
                linkColor: uiColor.first,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'comentários',
                    style: uiTextStyle.text2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.allHistory[index].isComment)
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(uiSvg.comment)),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(uiSvg.favorite),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(uiSvg.options),
                        onPressed: () => showMaterialModalBottomSheet(
                          expand: true,
                          barrierColor: Colors.white10,
                          context: context,
                          backgroundColor: uiColor.second,
                          builder: (context) => SingleChildScrollView(
                            controller: ModalScrollController.of(context),
                            child: Comment(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
