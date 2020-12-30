import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoppinglist/screens/home/widgets/item-create.widget.dart';
import 'package:flutter_shoppinglist/screens/home/widgets/item.widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 8,
        centerTitle: true,
        title: Text(
          'Personal',
          style: Theme.of(context).primaryTextTheme.headline3,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'Personal',
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            ListTile(
              title: Text('Personal'),
              selected: true,
              trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                onPressed: () {},
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Shopping List 1'),
              trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                onPressed: () {},
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('Shopping List 2'),
              trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                onPressed: () {},
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            child: ItemCreate(),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                icon: Icon(Icons.dashboard),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32.0),
            topLeft: Radius.circular(32.0),
          ),
        ),
        padding: const EdgeInsets.only(top: 40),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('lists')
                .doc('6DYnYvk6pDnfVmOE44uU')
                .collection('items')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    Item(document: snapshot.data.documents[index]),
              );
            }),
      ),
    );
  }
}
