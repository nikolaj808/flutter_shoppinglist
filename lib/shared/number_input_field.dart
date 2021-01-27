import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shoppinglist/shared/common_snackbar.dart';

class NumberInputField extends StatefulWidget {
  final TextEditingController controller;
  final int initial;
  final int min;
  final int max;

  const NumberInputField({
    Key key,
    @required this.controller,
    @required this.initial,
    @required this.min,
    @required this.max,
  }) : super(key: key);

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  int current;

  void _increment() {
    if (current >= widget.max) {
      return;
    }
    setState(() {
      current++;
      widget.controller.text = current.toString();
    });
  }

  void _decrement() {
    if (current <= widget.min) {
      return;
    }
    setState(() {
      current--;
      widget.controller.text = current.toString();
    });
  }

  void _onSubmit(String value) {
    FocusScope.of(context).unfocus();

    final quantity = int.tryParse(value);

    if (quantity == null) {
      widget.controller.text = current.toString();

      Scaffold.of(context).showSnackBar(
        CommonSnackBar.error('Ikke en gyldig værdi'),
      );
      return;
    }

    if (quantity >= widget.min && quantity <= widget.max) {
      setState(() {
        current = quantity;
        widget.controller.text = quantity.toString();
      });
      return;
    }

    widget.controller.text = current.toString();

    Scaffold.of(context).showSnackBar(
      CommonSnackBar.error('Ikke en gyldig værdi'),
    );
    return;
  }

  @override
  void initState() {
    current = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: widget.controller,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.none,
            onFieldSubmitted: _onSubmit,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _increment,
                child: const Icon(Icons.arrow_upward),
              ),
              GestureDetector(
                onTap: _decrement,
                child: const Icon(Icons.arrow_downward),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
