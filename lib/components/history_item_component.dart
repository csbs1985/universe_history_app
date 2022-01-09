// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/shared/models/history.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:universe_history_app/theme/ui_svgs.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryItemComponent extends StatefulWidget {
  const HistoryItemComponent(this.allHistory);
  final List<HistoryModel> allHistory;

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
                      widget.allHistory[index].historyTitle,
                      style: uiTextStyle.header1,
                    ),
                    Text(
                      widget.allHistory[index].historyDate + ' - anonimo',
                      style: uiTextStyle.text2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpandableText(
                      widget.allHistory[index].historyText,
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
                            if (widget.allHistory[index].historyComment)
                              IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(uiSvg.comment)),
                            IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(uiSvg.favorite),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(uiSvg.options),
                              onPressed: () => showCupertinoModalBottomSheet(
                                expand: true,
                                barrierColor: uiColor.second,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SingleChildScrollView(
                                  controller: ModalScrollController.of(context),
                                  child: Container(
                                    child: Text('data'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )),
    );
  }
}
