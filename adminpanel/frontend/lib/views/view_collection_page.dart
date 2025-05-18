import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/collection_controller.dart';
import 'package:adminpanel/models/collection.dart';

class ViewCollectionPage extends StatelessWidget {
  final Collection collection;
  const ViewCollectionPage({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final collectionController = Provider.of<CollectionController>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Главная', showBack: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              collection.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                collectionController.deleteCollection(collection.collection_ID);
                Navigator.of(context).pop();
              },
              child: const Text('Удалить коллекцию'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
} 