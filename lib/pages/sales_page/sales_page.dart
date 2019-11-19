import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import 'mock_sales_page.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (_, i) => AnimatedCard(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(sales[i].name, style: TextStyle(fontSize: 18),),
                      Container(
                        height: 32,
                        child: Image.network(
                          sales[i].logoAssetName,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Image.network(
                      sales[i].saleAssetImage,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      left: 10,
                      child: Chip(
                        backgroundColor: Colors.redAccent,
                        label: Text('${sales[i].discount}% OFF', style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Preço: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('De R\$ ${sales[i].originalPrice}', style: TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('por R\$ ${sales[i].priceWithDiscount}', style: TextStyle(fontSize: 18, )),
                    ),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
        ),
        itemCount: sales.length,
    );
  }
}
