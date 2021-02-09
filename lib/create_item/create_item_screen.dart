import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/shared/number_input_field.dart';
import 'package:flutter_shoppinglist/utilities/common.validator.dart';

class CreateItemScreen extends StatelessWidget {
  final GlobalKey<FormState> createItemFormKey;
  final void Function(BuildContext context, String name, int quantity)
      onCreateItem;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  void _onSubmit(BuildContext context) {
    if (!createItemFormKey.currentState.validate()) {
      return;
    }

    onCreateItem(
      context,
      _nameController.text,
      int.parse(_quantityController.text),
    );

    Navigator.of(context).pop();
  }

  CreateItemScreen({
    Key key,
    @required this.createItemFormKey,
    @required this.onCreateItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Tilføj ny vare',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onSubmit(context),
          child: const Icon(Icons.done),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          child: Form(
            key: createItemFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextFormField(
                        autofocus: true,
                        controller: _nameController,
                        onFieldSubmitted: (_) => _onSubmit(context),
                        validator: (value) =>
                            CommonValidator.isRequiredAndMaxLength(value, 20),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    Flexible(
                      child: NumberInputField(
                        controller: _quantityController,
                        initial: 1,
                        min: 1,
                        max: 999,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
