import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:to_com_fome/core/dio_builder.dart';
import 'package:to_com_fome/model/cartao.dart';
import 'package:to_com_fome/model/user_model.dart';
import 'package:to_com_fome/pages/restaurant/repository/restaurant_picked_repository.dart';

import 'widget/credit_card_form.dart';
import 'widget/credit_card_widget.dart';

class SaveCardPage extends StatefulWidget {
  SaveCardPage(this.user);

  final UserModel user;

  @override
  _SaveCardPageState createState() => _SaveCardPageState();
}

class _SaveCardPageState extends State<SaveCardPage> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused;

  @override
  void initState() {
    cardNumber = '';
    expiryDate = '';
    cardHolderName = '';
    cvvCode = '';
    isCvvFocused = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartão'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
            ),
            CreditCardForm(
              themeColor: Colors.red,
              onCreditCardModelChange: (data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                  isCvvFocused = data.isCvvFocused;
                });
              },
              cardHolderName: 'Nome no Cartão',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          if (cardNumber.length != 19 ||
              expiryDate.length != 5 ||
              cardHolderName.length == 0 ||
              cvvCode.length != 3) {
            Flushbar(
              message: "Dados Inválidos",
              icon: Icon(
                Icons.error,
                size: 28.0,
                color: Colors.red,
              ),
              duration: Duration(seconds: 1),
            )..show(context);
          } else {
            final card = Cartao(
              nameCard: cardHolderName,
              expirationCard: expiryDate,
              cvvCard: cvvCode,
              numberCard: cardNumber,
            );
            final _repository =
                RestaurantPickedRepository(client: DioBuilder.getDio());
            await _repository.saveCard(
              name: card.nameCard,
              userId: widget.user.id.toString(),
              cardNumber: card.numberCard,
              cpf: '03001053306',
              cvv: card.cvvCard,
              expiration: card.expirationCard,
            );
            Navigator.of(context).pop(card);
          }
        },
      ),
    );
  }
}
