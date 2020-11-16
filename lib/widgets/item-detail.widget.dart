import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoppinglist/validators/common.validator.dart';

class ItemDetail extends StatefulWidget {
  final DocumentSnapshot document;

  ItemDetail({Key key, this.document}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  final _formKey = GlobalKey<FormState>();
  var _nameController;
  var _quantityController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.document['name']);
    _quantityController =
        TextEditingController(text: widget.document['quantity'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_grocery_store,
                    size: 32.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Navn',
                      border: UnderlineInputBorder(),
                    ),
                    style: Theme.of(context).primaryTextTheme.headline6,
                    controller: _nameController,
                    textCapitalization: TextCapitalization.sentences,
                    validator: CommonValidator.notEmpty,
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          await FirebaseFirestore.instance
                              .collection('items')
                              .doc(widget.document.id)
                              .set({
                            'name': _nameController.text,
                            'quantity': int.parse(_quantityController.text)
                          });
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
