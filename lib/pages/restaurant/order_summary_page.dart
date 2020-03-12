import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_com_fome/model/order.dart';

import '../home/bloc/bloc.dart';
import 'bloc/restaurant_picked_bloc.dart';

class OrderSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RestaurantPickedBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do Pedido'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocListener<HomeBloc, HomeState>(
          bloc: homeBloc,
          listener: (_, state) {
            if (state is CupomChoosedState) {
              Flushbar(
                message: "Cupom adicionado ao Pedido",
                icon: Icon(
                  Icons.check,
                  size: 28.0,
                  color: Colors.green,
                ),
                backgroundGradient: LinearGradient(
                  colors: [Colors.green, Colors.greenAccent],
                ),
                duration: Duration(seconds: 1),
              )..show(context);
            }
            if (state is CupomNotFoundState) {
              print('aaaaa');
              Flushbar(
                message: "Cupom ${state.cupomCode} não encontrado",
                icon: Icon(
                  Icons.error_outline,
                  size: 28.0,
                  color: Colors.yellowAccent,
                ),
                duration: Duration(seconds: 1),
              )..show(context);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: homeBloc,
            builder: (_, state) => Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderItemsSummary(bloc.order),
                  Divider(height: 10),
                  ListTile(
                    leading: homeBloc.choosedCupom != null
                        ? Column(
                            children: <Widget>[
                              Text(
                                'Cupom: ${homeBloc.choosedCupom.code}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'valor: ',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    TextSpan(
                                      text:
                                          'R\$ ${double.parse(homeBloc.choosedCupom.value).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Text('Tem cupom?', style: TextStyle(fontSize: 18)),
                    trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            final cupomTextEditingController =
                                TextEditingController();
                            return SimpleDialog(
                              children: <Widget>[
                                BlocBuilder(
                                  bloc: homeBloc,
                                  builder: (_, state) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller:
                                              cupomTextEditingController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Código do Cupom'),
                                        ),
                                        SizedBox(height: 8),
                                        RaisedButton(
                                          onPressed: () {
                                            print('xxxxxxxx');
                                            homeBloc.add(
                                                TentaAdicionarCupomEvent(
                                                    cupomTextEditingController
                                                        .text));
                                            print('yyyyyyyy');
                                          },
                                          color: Theme.of(context).primaryColor,
                                          child: Text(
                                            'Adicionar Cupom',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'add',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  Divider(height: 20),
                  Column(
                    children: <Widget>[
                      Text(
                        'Observação',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 6),
                      TextField(
                        maxLines: 2,
                        minLines: 2,
                        maxLength: 180,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ex: tirar molho, sem picles, etc...'),
                      ),
                    ],
                  ),
                  Divider(
                    height: 60,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Subtotal:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'R\$ ${(bloc.order.totalValue).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Frete Padrão:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'R\$ ${(3.0).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cupom:',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'R\$ ${double.parse(homeBloc.choosedCupom?.value ?? '0').toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'R\$ ${(bloc.order.totalValue + 3.0 - double.parse(homeBloc.choosedCupom?.value ?? '0')).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'ACABEI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItemsSummary extends StatelessWidget {
  OrderItemsSummary(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, i) => ListTile(
          leading: Text('${order.items[i].qtd} x'),
          title: Text(order.items[i].name),
          trailing: Text('R\$ ${order.items[i].value.toStringAsFixed(2)}'),
          subtitle: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('subtotal: '),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'R\$ ${(order.items[i].value * order.items[i].qtd).toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: order.items.length,
      ),
    );
  }
}
