import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/shoppinglists/shoppinglists_bloc.dart';

class SettingsScreen extends StatelessWidget {
  final String shoppinglistId;

  const SettingsScreen({
    Key key,
    @required this.shoppinglistId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Indkøbsliste detaljer',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
            ),
            child: Column(
              children: [
                _buildTextFormField(
                  'Indkøbslistens navn',
                  'Indtast indkøbslistens navn..',
                ),
                _buildTextFormField(
                  'Indkøbslistens navn',
                  'Indtast indkøbslistens navn..',
                ),
                _buildTextFormField(
                  'Indkøbslistens navn',
                  'Indtast indkøbslistens navn..',
                ),
                const SizedBox(height: 64.0),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton.icon(
                        color: Colors.green,
                        icon: const Icon(Icons.check),
                        label: const Text('Gem'),
                        onPressed: () {},
                      ),
                      RaisedButton.icon(
                        color: Theme.of(context).errorColor,
                        icon: const Icon(Icons.delete),
                        label: const Text('Slet'),
                        onPressed: () {
                          BlocProvider.of<ShoppinglistsBloc>(context)
                              .add(DeleteShoppinglist());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String fieldName, String fieldHint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: ListTile(
        title: Text(
          fieldName,
          style: const TextStyle().copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: TextFormField(
          initialValue: 'Test',
          decoration: InputDecoration(
            hintText: fieldHint,
          ),
        ),
      ),
    );
  }
}
