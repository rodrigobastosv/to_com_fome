import 'package:to_com_fome/model/category.dart';
import 'package:to_com_fome/model/category_item.dart';

final restaurantInfo = [
  Category(
    name: 'Entradas',
    items: [
      CategoryItem(
        name: 'Chips',
        price: 5.13
      ),
      CategoryItem(
          name: 'Bolinha de Queijo',
          price: 9.00
      ),
      CategoryItem(
          name: 'Batata Frita',
          price: 11.00
      ),
      CategoryItem(
          name: 'Isca de Peixe',
          price: 13.25
      ),
    ]
  ),
  Category(
      name: 'Pratos Principais',
      items: [
        CategoryItem(
            name: 'Feijoada Completa',
            price: 66.35
        ),
        CategoryItem(
            name: 'Peixada',
            price: 44.99
        ),
        CategoryItem(
            name: 'Camarão Internacional',
            price: 111.99
        ),
        CategoryItem(
            name: 'Lagosta Flambada',
            price: 150.00
        ),
      ]
  ),
  Category(
      name: 'Sobremesa',
      items: [
        CategoryItem(
            name: 'Delícia de Banana',
            price: 15.00
        ),
        CategoryItem(
            name: 'Petigatoo',
            price: 18.99
        ),
        CategoryItem(
            name: 'Torta Alemã',
            price: 21.00
        ),
      ]
  ),
  Category(
      name: 'Bebidas',
      items: [
        CategoryItem(
            name: 'Água sem Gás',
            price: 2.00
        ),
        CategoryItem(
            name: 'Refrigerante',
            price: 3.00
        ),
        CategoryItem(
            name: 'Vinho Nacional',
            price: 25.00
        ),
        CategoryItem(
            name: 'Vinho Internacional',
            price: 5.13
        ),
      ],
  ),
  Category(
    name: 'Ofertas Especiais',
    items: [
      CategoryItem(
          name: 'Prato Kids',
          price: 15.99
      ),
      CategoryItem(
          name: 'Prato Família',
          price: 99.50
      ),
      CategoryItem(
          name: 'Festa Completa',
          price: 300.00
      ),
    ],
  ),
];