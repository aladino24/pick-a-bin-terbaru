import 'package:boilerplate/ui/schedule/list_done.dart';
import 'package:boilerplate/ui/schedule/list_schedule.dart';
import 'package:flutter/material.dart';

class StackOver extends StatefulWidget {
  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StackOver>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Jadwal',
          style: TextStyle(color: Color(0xff00783E)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Colors.green,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Akan dilakukan',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Selesai',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SchedulePage()
                  ),

                  // second tab bar view widget
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: ListDonePage()
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}