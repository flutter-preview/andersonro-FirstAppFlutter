import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class NavigationBarCustom extends StatefulWidget {
  const NavigationBarCustom({super.key});

  @override
  State<NavigationBarCustom> createState() => _NavigationBarCustomState();
}

class _NavigationBarCustomState extends State<NavigationBarCustom> with TickerProviderStateMixin {

  late TabController tabController;
  int positionPage = 0;
  double qtdMessage = 9;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Navigation Bar Custom"),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              Container(color: Colors.red),
              Container(color: Colors.yellow),
              Container(color: Colors.blue),
              Container(
                color: Colors.grey,
                child: Center(child:
                  Column(
                    children: [
                      Text(qtdMessage.toString()),
                      TextButton(
                          onPressed: (){
                            setState(() {
                              qtdMessage++;
                            });
                          },
                          child: Text("Add"),
                      )
                    ],
                  )
                ),
              ),
              Container(color: Colors.green)
            ],
          ),
          bottomNavigationBar: ConvexAppBar.badge(
            {0:'9+', 1: Icons.assistant_photo, 2:Colors.amber, 3 : qtdMessage.toString()},
            items: const [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.map, title: 'Discovery'),
              TabItem(icon: Icons.add, title: 'Add'),
              TabItem(icon: Icons.message, title: 'Message'),
              TabItem(icon: Icons.people, title: 'Profile'),
            ],
            onTap: (int i) => tabController.index = i,
            controller: tabController,
          ),
        ),
    );
  }
}
