import 'package:flutter/material.dart';
import 'package:to_com_fome/model/cartao.dart';
import 'package:to_com_fome/model/user_model.dart';
import 'package:to_com_fome/pages/cards/save_card_page.dart';

class ListCardPage extends StatefulWidget {
  ListCardPage(this.user, this.cards);

  final UserModel user;
  List<Cartao> cards;

  @override
  _ListCardPageState createState() => _ListCardPageState();
}

class _ListCardPageState extends State<ListCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartões Cadastrados'),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) => ListTile(
          title: Text(widget.cards[i].nameCard),
          subtitle: Text(widget.cards[i].numberCard),
          onTap: () {
            Navigator.of(context).pop(widget.cards[i]);
          },
        ),
        itemCount: widget.cards.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final card = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SaveCardPage(widget.user)),
          );
          if (card != null) {
            setState(() {
              widget.cards.add(card);
            });
          }
        },
      ),
    );
  }
}
