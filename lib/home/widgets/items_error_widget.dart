import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoppinglist/providers/blocs/items/items_bloc.dart';

class ItemsErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Der skete en fejl'),
            TextButton(
              onPressed: () => BlocProvider.of<ItemsBloc>(context).add(
                GetItems(),
              ),
              child: const Text('Genindlæs siden'),
            ),
          ],
        ),
      ),
    );
  }
}
