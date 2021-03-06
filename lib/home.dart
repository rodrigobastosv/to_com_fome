import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_monitor/shared_preferences_monitor.dart';
import 'package:to_com_fome/core/dio_builder.dart';
import 'package:to_com_fome/pages/favorite/bloc/bloc.dart';
import 'package:to_com_fome/pages/favorite/repository/favorite_restaurant_repository.dart';
import 'package:to_com_fome/pages/home/bloc/bloc.dart';
import 'package:to_com_fome/pages/home/repository/home_repository.dart';
import 'package:to_com_fome/pages/orders/bloc/bloc.dart';
import 'package:to_com_fome/pages/orders/repository/orders_repository.dart';
import 'package:to_com_fome/pages/sales/bloc/bloc.dart';

import 'core/dio_builder.dart';
import 'model/user_model.dart';
import 'pages/faq/faq_page.dart';
import 'pages/favorite/favorite_page.dart';
import 'pages/home/home_page.dart';
import 'pages/orders/orders_page.dart';
import 'pages/sales/bloc/sales_bloc.dart';
import 'pages/sales/repository/sales_repository.dart';
import 'pages/sales/sales_page.dart';

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
      viewportFraction: 1.0,
    );
    _pageController.addListener(_handlePageChange);
    super.initState();
  }

  void _handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olá, ${Provider.of<UserModel>(context).name}',
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/tanamao.jpg', fit: BoxFit.cover),
        ),
        actions: <Widget>[
          !kReleaseMode
              ? IconButton(
                  icon: Icon(Foundation.monitor, color: Colors.white, size: 28),
                  onPressed: () {
                    SharedPreferencesMonitor.showPage();
                  },
                )
              : SizedBox.shrink(),
          SizedBox(width: 10),
        ],
        centerTitle: true,
        backgroundColor: Color(0xFFf05925),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          BlocProvider<HomeBloc>(
            create: (_) => HomeBloc(HomeRepository(client: DioBuilder.getDio()))
              ..add(LoadCategoriesEvent(Provider.of<UserModel>(context))),
            child: Provider.value(
                value: Provider.of<UserModel>(context), child: HomePage()),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider<SalesBloc>(
                create: (_) =>
                    SalesBloc(SalesRepository(client: DioBuilder.getDio()))
                      ..add(LoadItems()),
              ),
              BlocProvider<HomeBloc>(
                create: (_) => HomeBloc(
                    HomeRepository(client: DioBuilder.getDio()))
                  ..add(LoadCategoriesEvent(Provider.of<UserModel>(context))),
              ),
            ],
            child: Provider.value(
                value: Provider.of<UserModel>(context), child: SalesPage()),
          ),
          BlocProvider(
            create: (_) => FavoriteRestaurantBloc(
                FavoriteRestaurantRepository(client: DioBuilder.getDio()))
              ..add(FetchFavoriteRestaurants(
                  Provider.of<UserModel>(context).id.toString())),
            child: FavoritePage(),
          ),
          BlocProvider(
            create: (_) => OrdersBloc(
                repository: OrdersRepository(client: DioBuilder.getDio()))
              ..add(FetchOrders(Provider.of<UserModel>(context))),
            child: OrdersPage(),
          ),
          FaqPage(),
        ],
      ),
      bottomNavigationBar: BubbledNavigationBar(
        defaultBubbleColor: Colors.blue,
        backgroundColor: Colors.grey[100],
        initialIndex: 0,
        onTap: (index) {
          _pageController.animateToPage(index,
              curve: Curves.easeInOutQuad,
              duration: Duration(milliseconds: 500));
        },
        controller: _menuPositionController,
        items: <BubbledNavigationBarItem>[
          BubbledNavigationBarItem(
            icon: Icon(CupertinoIcons.home, size: 30, color: Colors.blue),
            activeIcon:
                Icon(CupertinoIcons.home, size: 30, color: Colors.white),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            bubbleColor: mainColor,
          ),
          BubbledNavigationBarItem(
            icon:
                Icon(Foundation.burst_sale, size: 30, color: Colors.lightGreen),
            activeIcon:
                Icon(Foundation.burst_sale, size: 30, color: Colors.white),
            title: Text(
              'Promoções',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            bubbleColor: mainColor,
          ),
          BubbledNavigationBarItem(
            icon: Icon(MaterialIcons.favorite, size: 30, color: Colors.red),
            activeIcon:
                Icon(MaterialIcons.favorite, size: 30, color: Colors.white),
            title: Text(
              'Favoritos',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            bubbleColor: mainColor,
          ),
          BubbledNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.view_sequential,
                size: 30, color: Colors.indigo),
            activeIcon: Icon(MaterialCommunityIcons.view_sequential,
                size: 30, color: Colors.white),
            title: Text(
              'Pedidos',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            bubbleColor: mainColor,
          ),
          BubbledNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.cloud_question,
                size: 30, color: Colors.indigo),
            activeIcon: Icon(MaterialCommunityIcons.cloud_question,
                size: 30, color: Colors.white),
            title: Text(
              'FAQ',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            bubbleColor: mainColor,
          ),
        ],
      ),
    );
  }
}
