// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/history_item_component.dart';
import 'package:universe_history_app/shared/models/history_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  List<HistoryModel> allHistory = HistoryModel.allHistory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Weight Tracker'),
              floating: true,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              elevation: 0,
              bottom: TabBar(
                tabs: const [
                  Tab(text: 'STATISTICS'),
                  Tab(text: 'HISTORY'),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            HistoryItemComponent(allHistory),
          ],
        ),
      ),
    );
  }
}
