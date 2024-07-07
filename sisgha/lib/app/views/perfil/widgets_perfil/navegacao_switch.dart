import 'package:flutter/material.dart';

class NavSwitch extends StatefulWidget {
  const NavSwitch({Key? key}) : super(key: key);

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

class _NavSwitchState extends State<NavSwitch> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Disposição'),
            Tab(text: 'Ensino'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Text('Page 1'),
              Text('Page 2'),
            ],
          ),
        ),
      ],
    );
  }
}
