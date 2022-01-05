// ignore_for_file: use_key_in_widget_constructors

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
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
    return Scaffold(
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.allHistory.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
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
                    expandText: 'CONTINUAR LENDO',
                    collapseText: 'FECHAR',
                    maxLines: 20,
                    linkColor: uiColor.comp_2,
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
                              onPressed: () {},
                              icon: SvgPicture.asset(uiSvg.options))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
