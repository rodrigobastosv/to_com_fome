import 'package:flutter/material.dart';

import 'mock_favorite_page.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (_, i) => ListTile(
            title: Text(favorites[i].restaurantName),
            subtitle: Text('Último pedido: ${favorites[i].lastOrderDate}'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(favorites[i].restaurantAssetLogo),
            ),
            trailing: Text('Qtd: ${favorites[i].numberOfOrders}'),
          ),
        itemCount: favorites.length,
      ),
    );
  }
}
