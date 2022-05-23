import 'package:flutter/material.dart';
import 'package:universe_history_app/components/subtitle_resume_component.dart';
import 'package:universe_history_app/components/toggle_component.dart';

class SelectToggleComponent extends StatefulWidget {
  const SelectToggleComponent({
    required Function callback,
    required String title,
    required String resume,
    required bool value,
  })  : _title = title,
        _resume = resume,
        _callback = callback,
        _value = value;

  final Function _callback;
  final String _title;
  final String _resume;
  final bool _value;

  @override
  State<SelectToggleComponent> createState() => _SelectToggleComponentState();
}

class _SelectToggleComponentState extends State<SelectToggleComponent> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 108;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SubtitleResumeComponent(
            title: widget._title,
            resume: widget._resume,
            width: width,
          ),
          ToggleComponent(
            value: widget._value,
            callback: (value) => widget._callback(value),
          ),
        ],
      ),
    );
  }
}
