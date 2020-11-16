import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoppinglist/validators/common.validator.dart';

class ItemCreate extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  final _nameNode = FocusNode();
  final _quantityNode = FocusNode();

  ItemCreate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_grocery_store),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Ny vare'),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Navn',
                  border: UnderlineInputBorder(),
                ),
                style: Theme.of(context).primaryTextTheme.headline6,
                controller: _nameController,
                textCapitalization: TextCapitalization.sentences,
                validator: CommonValidator.notEmpty,
                autofocus: true,
                focusNode: _nameNode,
                onFieldSubmitted: (_) => _quantityNode.requestFocus(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mængde',
                  border: UnderlineInputBorder(),
                ),
                style: Theme.of(context).primaryTextTheme.headline6,
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: CommonValidator.betweenValuesAndNotEmpty,
                focusNode: _quantityNode,
                onFieldSubmitted: (_) => _quantityNode.unfocus(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.check),
          onPressed: () async {
            if (!_formKey.currentState.validate()) {
              return;
            }

            await FirebaseFirestore.instance.collection('items').add({
              'name': _nameController.text,
              'quantity': int.parse(_quantityController.text)
            });
            Navigator.of(context).pop();
          },
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
