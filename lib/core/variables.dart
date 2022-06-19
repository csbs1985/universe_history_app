import 'package:flutter/material.dart';

ValueNotifier<String> currentToken = ValueNotifier<String>('');

ValueNotifier<bool> currentNotification = ValueNotifier<bool>(false);

ValueNotifier<String> currentDialog = ValueNotifier<String>('');

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
