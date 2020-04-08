import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'widget/credit_card_form.dart';
import 'widget/credit_card_widget.dart';

class SaveCardPage extends StatefulWidget {
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
        onPressed: () {
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
            Flushbar(
              message: "Cartão Salvo com sucesso",
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
        },
      ),
    );
  }
}
