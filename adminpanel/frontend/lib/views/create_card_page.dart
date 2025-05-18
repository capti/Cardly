import 'package:flutter/material.dart';
import 'package:adminpanel/models/card.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'dart:html' as html;
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/card_controller.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({Key? key}) : super(key: key);

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  String _rarity = 'Обычная';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _imageUrl;
  String _theme = '';

  Future<void> _pickImage() async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen((event) {
          setState(() {
            _imageUrl = reader.result as String;
          });
        });
      }
    });
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty || _descController.text.trim().isEmpty || _imageUrl == null) {
      // Можно добавить вывод ошибки
      return;
    }
    final card = CardModel(
      card_ID: DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      imageURL: _imageUrl!,
      rarity: _rarity,
      min_price: 0,
      theme: ThemeModel(name: _theme),
      isGenerated: false,
    );
    Provider.of<CardController>(context, listen: false).addCard(card);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    int rarityCount = 1;
    switch (_rarity) {
      case 'Редкая':
        rarityCount = 2;
        break;
      case 'Эпическая':
        rarityCount = 3;
        break;
      case 'Легендарная':
        rarityCount = 4;
        break;
      default:
        rarityCount = 1;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Главная', showBack: true),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Карточка
            Container(
              width: 370,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFFF7E5CF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 300,
                    height: 460,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2A86F),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black, width: 4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Stack(
                          children: [
                            // Верхнее поле для названия
                            Positioned(
                              top: 12,
                              left: 12,
                              right: 12,
                              height: 36,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 2),
                                  color: Colors.transparent,
                                ),
                                child: TextField(
                                  controller: _nameController,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Название карточки',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                              ),
                            ),
                            // Центральная зона с картинкой/плюсом
                            Positioned(
                              top: 60,
                              left: 12,
                              right: 12,
                              height: 220,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: _imageUrl == null
                                        ? Container(
                                            width: 64,
                                            height: 64,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF7E5CF),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: Colors.black, width: 2),
                                            ),
                                            child: const Center(
                                              child: Icon(Icons.add, size: 40, color: Colors.black),
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(_imageUrl!, fit: BoxFit.cover, width: 180, height: 180),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            // Нижнее поле для описания
                            Positioned(
                              left: 12,
                              right: 12,
                              bottom: 48,
                              height: 56,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 2),
                                  color: Colors.transparent,
                                ),
                                child: TextField(
                                  controller: _descController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Описание',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  ),
                                  style: const TextStyle(fontSize: 13),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            // Тематика и иконки внизу
                            Positioned(
                              left: 16,
                              bottom: 12,
                              child: Row(
                                children: List.generate(
                                  rarityCount,
                                  (i) => Padding(
                                    padding: EdgeInsets.only(right: i < rarityCount - 1 ? 4 : 0),
                                    child: Image.asset(
                                      'assets/icons/редкость.png',
                                      width: 20,
                                      height: 28,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 16,
                              bottom: 12,
                              child: SizedBox(
                                width: 100,
                                child: TextField(
                                  onChanged: (v) => setState(() => _theme = v),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Тематика',
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: const TextStyle(fontSize: 15),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE2A86F),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      onPressed: _submit,
                      child: const Text('Добавить карточку', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
            // Блок с радиокнопками редкости
            Container(
              margin: const EdgeInsets.only(top: 60),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7E5CF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RarityRadio('Обычная', _rarity, (v) => setState(() => _rarity = v)),
                  const SizedBox(height: 8),
                  _RarityRadio('Редкая', _rarity, (v) => setState(() => _rarity = v)),
                  const SizedBox(height: 8),
                  _RarityRadio('Эпическая', _rarity, (v) => setState(() => _rarity = v)),
                  const SizedBox(height: 8),
                  _RarityRadio('Легендарная', _rarity, (v) => setState(() => _rarity = v)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RarityRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  const _RarityRadio(this.value, this.groupValue, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: (v) => onChanged(v!),
        ),
        Text(value),
      ],
    );
  }
} 