import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search_cep/search_cep.dart';
import 'package:to_com_fome/core/dio_builder.dart';
import 'package:to_com_fome/model/order.dart';
import 'package:to_com_fome/model/user_model.dart';

import '../../home.dart';
import '../home/bloc/bloc.dart';
import 'bloc/restaurant_picked_bloc.dart';
import 'bloc/restaurant_picked_event.dart';
import 'bloc/restaurant_picked_state.dart';
import 'repository/restaurant_picked_repository.dart';

class OrderSummaryPage extends StatefulWidget {
  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  GlobalKey<FormState> _formKey;

  String mobile;
  String address;
  String district;
  String numero;
  String complemento;
  String cepEscolhido;
  bool liberaPesquisaCep = false;
  bool isLoading = false;

  TextEditingController addressController;
  TextEditingController districtController;

  HomeBloc homeBloc;
  RestaurantPickedBloc restaurantPickedBloc;
  UserModel user;

  RestaurantPickedRepository _repository;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    restaurantPickedBloc = BlocProvider.of<RestaurantPickedBloc>(context);
    user = Provider.of<UserModel>(context, listen: false);
    addressController = TextEditingController(text: user.address ?? '');
    districtController = TextEditingController(text: user.district ?? '');
    _formKey = GlobalKey<FormState>();
    _repository = RestaurantPickedRepository(client: DioBuilder.getDio());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do Pedido'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocListener<RestaurantPickedBloc, RestaurantPickedState>(
          bloc: restaurantPickedBloc,
          listener: (_, state) {
            if (state is OrderSavedState) {
              Flushbar(
                message: "Pedido salvo com sucesso",
                icon: Icon(
                  Icons.check,
                  size: 28.0,
                  color: Colors.white,
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              )..show(_).then(
                  (__) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => Provider.value(
                          value: Provider.of<UserModel>(context, listen: false),
                          child: Home()),
                    ),
                  ),
                );
            }
            if (state is ItemRemovedFromOrderState) {
              Flushbar(
                message: "Item Removido do pedido",
                icon: Icon(
                  Icons.delete,
                  size: 28.0,
                  color: Colors.yellowAccent,
                ),
                duration: Duration(seconds: 1),
              )..show(context);
            }
          },
          child: BlocBuilder<RestaurantPickedBloc, RestaurantPickedState>(
            bloc: restaurantPickedBloc,
            builder: (_, state) => BlocListener<HomeBloc, HomeState>(
              bloc: homeBloc,
              listener: (_, state) {
                if (state is CupomChoosedState) {
                  Navigator.of(context).pop();

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
                  Flushbar(
                    message: "CUPOM INVÁLIDO",
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
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: OrderItemsSummary(restaurantPickedBloc.order),
                        ),
                        Divider(height: 10),
                        Expanded(
                          child: ListTile(
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
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                            TextSpan(
                                              text:
                                                  'R\$ ${double.parse(homeBloc.choosedCupom.value).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Text('Tem cupom?',
                                    style: TextStyle(fontSize: 18)),
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
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Código do Cupom'),
                                                ),
                                                SizedBox(height: 8),
                                                RaisedButton(
                                                  onPressed: () {
                                                    homeBloc.add(
                                                        TentaAdicionarCupomEvent(
                                                            cupomTextEditingController
                                                                .text));
                                                  },
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
                        ),
                        Divider(height: 10),
                        Expanded(
                          child: ListTile(
                              title: Text('Meio de Pagamento'),
                              subtitle: Text(homeBloc.choosedPaymentType != null
                                  ? homeBloc.choosedPaymentType.name
                                  : ''),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return SimpleDialog(
                                      children: <Widget>[
                                        BlocBuilder(
                                          bloc: homeBloc,
                                          builder: (_, state) => Container(
                                            child: ListView.separated(
                                              itemBuilder: (_, i) => ListTile(
                                                key: ValueKey(homeBloc
                                                    .paymentTypes[i].id),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  homeBloc.add(
                                                      ChoosePaymentTypeEvent(
                                                          homeBloc.paymentTypes[
                                                              i]));
                                                },
                                                title: Text(
                                                  homeBloc.paymentTypes[i].name,
                                                  style: TextStyle(
                                                      color: homeBloc.paymentTypes[
                                                                  i] ==
                                                              homeBloc
                                                                  .choosedPaymentType
                                                          ? Colors.blue
                                                          : Colors.black),
                                                ),
                                              ),
                                              separatorBuilder: (_, i) =>
                                                  Divider(),
                                              itemCount: homeBloc
                                                      .paymentTypes?.length ??
                                                  0,
                                            ),
                                            height: 300,
                                            width: 150,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                        ),
                        Divider(height: 10),
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Dados de Entrega',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        child: TextFormField(
                                          maxLength: 8,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'EX: 60129042',
                                            labelText: 'CEP',
                                          ),
                                          onChanged: (cep) async {
                                            setState(() {
                                              cepEscolhido = cep;
                                              if (cepEscolhido.trim().length ==
                                                  8) {
                                                liberaPesquisaCep = true;
                                              } else {
                                                liberaPesquisaCep = false;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      liberaPesquisaCep
                                          ? isLoading
                                              ? CircularProgressIndicator()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, bottom: 20),
                                                  child: RaisedButton(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    onPressed: () async {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      final info = await SearchCep
                                                          .searchInfoByCep(
                                                              cep:
                                                                  cepEscolhido);
                                                      setState(() {
                                                        addressController.text =
                                                            info.logradouro;
                                                        districtController
                                                            .text = info.bairro;
                                                        isLoading = false;
                                                      });
                                                    },
                                                    child: Text(
                                                      'Localizar',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                          : SizedBox.shrink(),
                                      Spacer(),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Digite aqui seu Endereço',
                                      labelText: 'Endereço',
                                    ),
                                    validator: (endereco) => endereco.isEmpty
                                        ? 'campo obrigatório'
                                        : null,
                                    onSaved: (endereco) => address = endereco,
                                    controller: addressController,
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText:
                                          'Digite aqui o número do endereço',
                                      labelText: 'Número Endereço',
                                    ),
                                    onSaved: (num) => numero = num,
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Digite aqui o Complemento',
                                      labelText: 'Complemento',
                                    ),
                                    onSaved: (comp) => complemento = comp,
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Digite aqui seu Bairro',
                                      labelText: 'Bairro',
                                    ),
                                    validator: (bairro) => bairro.isEmpty
                                        ? 'campo obrigatório'
                                        : null,
                                    onSaved: (bairro) => district = bairro,
                                    controller: districtController,
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Digite aqui seu Telefone',
                                      labelText: 'Telefone',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (celular) => celular.isEmpty
                                        ? 'campo obrigatório'
                                        : null,
                                    onSaved: (celular) => mobile = celular,
                                    initialValue: user.mobile,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  'R\$ ${(restaurantPickedBloc.order.totalValue).toStringAsFixed(2)}',
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
                                  'R\$ ${(restaurantPickedBloc.order.totalValue + 3.0 - double.parse(homeBloc.choosedCupom?.value ?? '0')).toStringAsFixed(2)}',
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
                              onPressed: restaurantPickedBloc
                                      .order.items.isEmpty
                                  ? null
                                  : () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        String finalAddress =
                                            '${(address ?? user.address)}';
                                        if (numero.isNotEmpty) {
                                          finalAddress =
                                              '$finalAddress, Número: $numero';
                                        }
                                        if (complemento.isNotEmpty) {
                                          finalAddress =
                                              '$finalAddress, Complemento: $complemento';
                                        }
                                        final choosedPaymentType =
                                            homeBloc.choosedPaymentType;
                                        if (choosedPaymentType != null) {
                                          await _repository.saveOrder(
                                            restaurant: restaurantPickedBloc
                                                .restaurantPicked,
                                            order: restaurantPickedBloc.order,
                                            address: finalAddress,
                                            district: district ?? user.district,
                                            mobile: mobile ?? user.mobile,
                                            paymentType: choosedPaymentType,
                                            cliente: Provider.of<UserModel>(
                                                context,
                                                listen: false),
                                            cupom: homeBloc.choosedCupom,
                                          );
                                          Flushbar(
                                            message: "Pedido salvo com sucesso",
                                            icon: Icon(
                                              Icons.check,
                                              size: 28.0,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 1),
                                          )..show(_).then(
                                              (__) => Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      Provider.value(
                                                          value: Provider.of<
                                                                  UserModel>(
                                                              context,
                                                              listen: false),
                                                          child: Home()),
                                                ),
                                              ),
                                            );
                                        } else {
                                          Flushbar(
                                            message:
                                                "Escolha um meio de pagamento",
                                            icon: Icon(
                                              Icons.warning,
                                              size: 28.0,
                                              color: Colors.yellowAccent,
                                            ),
                                            duration: Duration(seconds: 1),
                                          )..show(context);
                                        }
                                      }
                                    },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'ACABEI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
        itemBuilder: (_, i) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Text(order.items[i].name),
                ),
                Expanded(
                  flex: 1,
                  child: Text('${order.items[i].qtd} x'),
                ),
                Expanded(
                  flex: 2,
                  child: Text('R\$ ${order.items[i].value.toStringAsFixed(2)}'),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => context.bloc<RestaurantPickedBloc>().add(
                          RemoveItemFromOrder(
                            order.items[i],
                          ),
                        ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Observação: ${order.items[i].obs ?? 'Sem observação'}'),
              ],
            )
          ],
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: order.items.length,
      ),
    );
  }
}
