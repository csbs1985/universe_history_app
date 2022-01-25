// ignore_for_file: iterable_contains_unrelated_type, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/shared/models/notification_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<NotificationModel> allNotification =
      NotificationModel.allNotification;

  void _readNotification(String historyId) {
    setState(() {
      allNotification.contains(historyId);
      print("apertado: " + historyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(uiSvg.closed),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Text(
                'Notificações',
                style: uiTextStyle.header1,
              ),
            ),
            for (var item in allNotification)
              GestureDetector(
                onTap: () => _readNotification(item.history),
                child: Container(
                  width: double.infinity,
                  color: item.read ? uiColor.comp_1 : uiColor.comp_3,
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          item.anonimous
                              ? RichText(
                                  text: TextSpan(
                                    text: 'Sua história "',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: uiColor.third,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: item.history,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const TextSpan(
                                        text: '" recebeu um comentário ',
                                      ),
                                      const TextSpan(
                                        text: 'anônimo.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    text: item.user,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      const TextSpan(
                                        text: ' comentou a sua história "',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                        text: item.history,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const TextSpan(
                                        text: '".',
                                      ),
                                    ],
                                  ),
                                ),
                          Text(
                            item.date,
                            style: uiTextStyle.text2,
                          ),
                        ],
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
