import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/model/restaurant_item.dart';
import 'package:to_com_fome/model/user_model.dart';
import 'package:to_com_fome/pages/home/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/order_summary_page.dart';

import 'bloc/restaurant_picked_bloc.dart';
import 'bloc/restaurant_picked_event.dart';

class ItemPickedPage extends StatefulWidget {
  ItemPickedPage(this.item, {this.fromSales = false});

  final RestaurantItem item;
  final bool fromSales;

  @override
  _ItemPickedPageState createState() => _ItemPickedPageState();
}

class _ItemPickedPageState extends State<ItemPickedPage> {
  int pickedQtd;

  TextEditingController obsController;

  @override
  void initState() {
    pickedQtd = 0;
    obsController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.item.name,
              child: Image.network(
                '$BASE_RESTAURANT_IMAGE_URL/uploads/item/${widget.item.image}',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text('O que é, o que é?'),
              subtitle: Text('Serve duas pessoas'),
            ),
            Divider(),
            ListTile(
              title: Text('qual o tamanho?'),
              subtitle: ListTile(
                title: Text('Único'),
                trailing: Text(
                  'R\$${widget.item.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Text(
              'valor: R\$${(widget.item.price * pickedQtd).toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: pickedQtd != 0
                      ? () {
                          if (pickedQtd != 0) {
                            setState(() {
                              pickedQtd = pickedQtd - 1;
                            });
                          }
                        }
                      : null,
                  iconSize: 28,
                  color: Theme.of(context).primaryColor,
                  icon: Icon(AntDesign.minuscircleo),
                ),
                SizedBox(width: 12),
                Text(
                  pickedQtd.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                  ),
                ),
                SizedBox(width: 12),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pickedQtd = pickedQtd + 1;
                    });
                  },
                  color: Theme.of(context).primaryColor,
                  iconSize: 28,
                  icon: Icon(AntDesign.pluscircleo),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Alguma observação?'),
                controller: obsController,
              ),
            ),
            RaisedButton(
              onPressed: pickedQtd != 0
                  ? () {
                      BlocProvider.of<RestaurantPickedBloc>(context).add(
                          ItemAddedToOrder(
                              widget.item, pickedQtd, obsController.text));
                      if (widget.fromSales) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: BlocProvider.of<RestaurantPickedBloc>(
                                      context),
                                ),
                                BlocProvider.value(
                                  value: BlocProvider.of<HomeBloc>(context),
                                ),
                              ],
                              child: Provider.value(
                                  value: Provider.of<UserModel>(context,
                                      listen: false),
                                  child: OrderSummaryPage()),
                            ),
                          ),
                        );
                      } else {
                        Navigator.of(context).pop();
                      }
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'ADICIONAR',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
