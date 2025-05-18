import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:adminpanel/models/card.dart';
import 'package:adminpanel/views/create_card_page.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/collection_controller.dart';
import 'package:adminpanel/models/collection.dart';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({Key? key}) : super(key: key);

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  List<CardModel> _cards = [];

  void _addCard() async {
    final card = await Navigator.of(context).push<CardModel>(
      MaterialPageRoute(builder: (context) => const CreateCardPage()),
    );
    if (card != null) {
      setState(() {
        _cards.add(card);
      });
    }
  }

  void _submit() {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        _errorText = 'Название не может быть пустым';
      });
      return;
    }
    final collection = Collection(
      collection_ID: DateTime.now().millisecondsSinceEpoch,
      name: _controller.text.trim(),
      cards: _cards,
      imageURL: '',
    );
    Provider.of<CollectionController>(context, listen: false).createCollection(collection);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Главная', showBack: true),
      body: Center(
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFFF7E5CF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Добавить название коллекции',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Название коллекции',
                  errorText: _errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Карты в коллекции:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _cards.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    if (index == _cards.length) {
                      return GestureDetector(
                        onTap: _addCard,
                        child: Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2A86F),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black26),
                          ),
                          child: const Center(
                            child: Icon(Icons.add, size: 36, color: Colors.black),
                          ),
                        ),
                      );
                    }
                    final card = _cards[index];
                    return Container(
                      width: 90,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(card.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(card.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2A86F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  onPressed: _submit,
                  child: const Text('Создать коллекцию', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddCardDialog extends StatefulWidget {
  @override
  State<_AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<_AddCardDialog> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _imageURLController = TextEditingController();
  final TextEditingController _rarityController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  String? _errorText;
  String _selectedTheme = 'Животные';
  bool _isGenerated = false;

  final List<String> _themes = [
    'Животные',
    'Машины',
    'Города',
    'Еда',
    'Спорт',
    'Другое',
  ];

  void _submit() {
    if (_idController.text.trim().isEmpty ||
        _nameController.text.trim().isEmpty ||
        _descController.text.trim().isEmpty ||
        _imageURLController.text.trim().isEmpty ||
        _rarityController.text.trim().isEmpty ||
        _minPriceController.text.trim().isEmpty) {
      setState(() {
        _errorText = 'Все поля должны быть заполнены';
      });
      return;
    }
    final int? id = int.tryParse(_idController.text.trim());
    final int? minPrice = int.tryParse(_minPriceController.text.trim());
    if (id == null || minPrice == null) {
      setState(() {
        _errorText = 'ID и минимальная цена должны быть числами';
      });
      return;
    }
    Navigator.of(context).pop(CardModel(
      card_ID: id,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      imageURL: _imageURLController.text.trim(),
      rarity: _rarityController.text.trim(),
      min_price: minPrice,
      theme: ThemeModel(name: _selectedTheme),
      isGenerated: _isGenerated,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить карту'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(hintText: 'ID карты'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Название карты'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(hintText: 'Описание'),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _imageURLController,
              decoration: const InputDecoration(hintText: 'URL изображения'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _rarityController,
              decoration: const InputDecoration(hintText: 'Редкость'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _minPriceController,
              decoration: const InputDecoration(hintText: 'Минимальная цена'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedTheme,
              items: _themes.map((theme) => DropdownMenuItem(
                value: theme,
                child: Text(theme),
              )).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedTheme = val);
              },
              decoration: const InputDecoration(hintText: 'Тематика'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _isGenerated,
                  onChanged: (val) => setState(() => _isGenerated = val ?? false),
                ),
                const Text('Сгенерирована'),
              ],
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_errorText!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Добавить'),
        ),
      ],
    );
  }
} 