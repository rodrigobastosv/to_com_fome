import 'package:flutter/material.dart';

class OrderSummaryPage extends StatelessWidget {
  OrderSummaryPage({this.order, this.totalPedido});

  final Map<String, int> order;
  final double totalPedido;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do Pedido'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pop(true),
            icon: Icon(Icons.check_circle),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OrderItemsSummary(order),
              Divider(height: 10),
              ListTile(
                leading: Text(
                  'Tem cupom?',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Text(
                  'add',
                  style: TextStyle(color: Colors.red),
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
                        'R\$ ${(totalPedido).toStringAsFixed(2)}',
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
                        'Total:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'R\$ ${(totalPedido + 3.0).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItemsSummary extends StatelessWidget {
  OrderItemsSummary(this.order);

  final Map<String, int> order;

  List<String> get keys => order.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, i) => ListTile(
          leading: Text('${order[keys[i]]} x'),
          title: Text(keys[i]),
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: order.length,
      ),
    );
  }
}
