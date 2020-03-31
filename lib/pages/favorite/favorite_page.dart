import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/pages/favorite/bloc/bloc.dart';

class FavoritePage extends StatelessWidget {
  final df1 = DateFormat('yyyy-MM-ddThh:mm:ss.000000Z');
  final df2 = DateFormat('dd-MM-yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteRestaurantBloc, FavoriteRestaurantState>(
      builder: (_, state) {
        if (state is FetchFavoriteSuccess) {
          final favorites = state.favorites;
          if (favorites.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (_, i) => ListTile(
                title: Text(favorites[i].name),
                subtitle: Text(
                    'Último pedido: ${df2.format(df1.parse(favorites[0].lastOrder))}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      '$BASE_RESTAURANT_IMAGE_URL/${favorites[i].logoPath}/${favorites[i].logo}'),
                ),
                trailing: Text('Qtd: ${favorites[i].countOrders}'),
              ),
              itemCount: favorites.length,
            );
          } else {
            return Center(
              child: Text('Nenhum pedido foi realizado ainda!'),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
