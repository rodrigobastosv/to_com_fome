import 'package:animated_card/animated_card.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:to_com_fome/core/API.dart';
import 'package:to_com_fome/core/dio_builder.dart';
import 'package:to_com_fome/model/restaurant.dart';
import 'package:to_com_fome/model/user_model.dart';
import 'package:to_com_fome/pages/home/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/bloc/bloc.dart';
import 'package:to_com_fome/pages/restaurant/repository/restaurant_picked_repository.dart';
import 'package:to_com_fome/pages/restaurant/restaurant_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<UserModel>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state is CategoriesLoadingState) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (state is CategoriesLoadedState) {
          final categories = state.categories;
          return ListView.builder(
            itemBuilder: (_, i) {
              final category = categories[i];
              final restaurants = category.restaurants;
              return AnimatedCard(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        category.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 160,
                        child: restaurants.isEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.warning,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 12),
                                  Center(
                                    child: Text(
                                        'Nenhum restaurante nesta categoria!'),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, i) => Hero(
                                  tag: '${category.name}-${restaurants[i].id}',
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return MultiBlocProvider(
                                            providers: [
                                              BlocProvider<
                                                  RestaurantPickedBloc>(
                                                create: (_) =>
                                                    RestaurantPickedBloc(
                                                  restaurants[i],
                                                  client,
                                                  RestaurantPickedRepository(
                                                      client:
                                                          DioBuilder.getDio()),
                                                )..add(LoadItemsEvent()),
                                              ),
                                              BlocProvider<HomeBloc>.value(
                                                value: context.bloc<HomeBloc>(),
                                              ),
                                            ],
                                            child: Provider.value(
                                                value: Provider.of<UserModel>(
                                                    context),
                                                child: RestaurantPage()),
                                          );
                                        },
                                      ),
                                    ),
                                    child: RestaurantWidget(restaurants[i]),
                                  ),
                                ),
                                itemCount: restaurants.length,
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: categories.length,
          );
        } else if (state is CategoriesErrorOnLoadState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class RestaurantWidget extends StatelessWidget {
  RestaurantWidget(this.restaurant);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    return Container(
      width: 260,
      child: Column(
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              height: 100,
              width: 200,
              child: FancyShimmerImage(
                imageUrl:
                    '$BASE_RESTAURANT_IMAGE_URL/${restaurant.logoPath}/${restaurant.logo}',
                errorWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Ionicons.md_warning, color: Colors.red),
                    SizedBox(height: 6),
                    Text('Erro ao carregar a imagem'),
                  ],
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ),
          Expanded(
            child: Text(
              restaurant.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: mainColor, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
