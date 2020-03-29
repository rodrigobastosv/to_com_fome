import 'package:animated_card/animated_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:url_launcher/url_launcher.dart';

final promocoes = [
  'https://1.bp.blogspot.com/-8DqWkexSYjg/UArV5bxmnDI/AAAAAAAAAW0/2AsdbnOcfaY/s1600/promo.jpg',
  'https://img.elo7.com.br/product/zoom/2119433/adesivo-vitrine-lojas-em-geral-promocoes-ofertas-mod-4-adesivo-para-lojas.jpg',
  'https://media.gazetadopovo.com.br/2019/11/27173541/burguer-mcdonalds-black-friday-660x372.jpg',
  'https://i0.wp.com/tribunadoplanalto.com.br/wp-content/uploads/2016/01/promocao.png?fit=467%2C300',
  'https://tiagotessmann.com.br/wp-content/uploads/2017/01/Dicas-para-Apresentar-Promo%C3%A7%C3%B5es-Imperd%C3%ADveis-e-Irrecus%C3%A1veis.jpg',
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<UserModel>(context, listen: false);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state is CategoriesLoadingState) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (state is CategoriesLoadedState) {
          final categories = state.categories;
          final banners = state.banners;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: CarouselSlider.builder(
                  itemCount: banners.length,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  itemBuilder: (_, i) => GestureDetector(
                    onTap: () async => await launch(banners[i].link),
                    child: FancyShimmerImage(
                      width: double.infinity,
                      imageUrl:
                          '$BASE_RESTAURANT_IMAGE_URL/${banners[i].imagePath}/${banners[i].image}',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    final category = categories[i];
                    final restaurants = category.restaurants;
                    return AnimatedCard(
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(
                                category.name,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 160,
                              child: restaurants.isEmpty
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        tag:
                                            '${category.name}-${restaurants[i].id}',
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).push(
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
                                                            client: DioBuilder
                                                                .getDio()),
                                                      )..add(LoadItemsEvent()),
                                                    ),
                                                    BlocProvider<
                                                        HomeBloc>.value(
                                                      value: context
                                                          .bloc<HomeBloc>(),
                                                    ),
                                                  ],
                                                  child: Provider.value(
                                                      value: Provider.of<
                                                          UserModel>(context),
                                                      child: RestaurantPage()),
                                                );
                                              },
                                            ),
                                          ),
                                          child:
                                              RestaurantWidget(restaurants[i]),
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
                ),
              ),
            ],
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
      width: 160,
      child: Column(
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              height: 100,
              width: 100,
              child: FancyShimmerImage(
                imageUrl:
                    '$BASE_RESTAURANT_IMAGE_URL/${restaurant.logoPath}/${restaurant.logo}',
                errorWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Ionicons.md_warning, color: Colors.red),
                    SizedBox(height: 6),
                    Text('Sem imagem'),
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
