import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'pages/favorite_page.dart';
import 'pages/home_page.dart';
import 'pages/orders_page.dart';
import 'pages/sales_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController _pageController;
  MenuPositionController _menuPositionController;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController = PageController(
        initialPage: 0,
        keepPage: false,
        viewportFraction: 1.0
    );
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tô com fome'),
        leading: Icon(MaterialCommunityIcons.face_profile, color: Colors.purple, size: 32),
        actions: <Widget>[
          Icon(Icons.search, color: Colors.purple, size: 28),
          SizedBox(width: 10),
          Icon(Icons.notifications_none, color: Colors.purple, size: 28)
        ],
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          SalesPage(),
          FavoritePage(),
          OrdersPage(),
        ],
      ),
      bottomNavigationBar: BubbledNavigationBar(
        defaultBubbleColor: Colors.blue,
        backgroundColor: Colors.grey[100],
        initialIndex: 0,
        onTap: (index) {
          _pageController.animateToPage(
              index,
              curve: Curves.easeInOutQuad,
              duration: Duration(milliseconds: 500)
          );
        },
        controller: _menuPositionController,
        items: <BubbledNavigationBarItem>[
          BubbledNavigationBarItem(
            icon:       Icon(CupertinoIcons.home, size: 30, color: Colors.blue),
            activeIcon: Icon(CupertinoIcons.home, size: 30, color: Colors.white),
            title: Text('Home', style: TextStyle(color: Colors.white, fontSize: 12),),
            bubbleColor: Colors.purple
          ),
          BubbledNavigationBarItem(
            icon:       Icon(Foundation.burst_sale, size: 30, color: Colors.orangeAccent),
            activeIcon: Icon(Foundation.burst_sale, size: 30, color: Colors.white),
            title: Text('Promoções', style: TextStyle(color: Colors.white, fontSize: 12),),
              bubbleColor: Colors.purple
          ),
          BubbledNavigationBarItem(
            icon:       Icon(MaterialIcons.favorite, size: 30, color: Colors.red),
            activeIcon: Icon(MaterialIcons.favorite, size: 30, color: Colors.white),
            title: Text('Info', style: TextStyle(color: Colors.white, fontSize: 12),),
              bubbleColor: Colors.purple
          ),
          BubbledNavigationBarItem(
            icon:       Icon(MaterialCommunityIcons.view_sequential, size: 30, color: Colors.indigo),
            activeIcon: Icon(MaterialCommunityIcons.view_sequential, size: 30, color: Colors.white),
            title: Text('Pedidos', style: TextStyle(color: Colors.white, fontSize: 12),),
            bubbleColor: Colors.purple
          ),
        ],
      ),
    );
  }
}