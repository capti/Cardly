import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'dart:typed_data';
import 'dart:html' as html;

class CreateNewsPage extends StatefulWidget {
  const CreateNewsPage({Key? key}) : super(key: key);

  @override
  State<CreateNewsPage> createState() => _CreateNewsPageState();
}

class _CreateNewsPageState extends State<CreateNewsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  Uint8List? _imageBytes;
  bool _saving = false;
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();

  Future<void> _pickImage() async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          setState(() {
            _imageBytes = reader.result as Uint8List;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _titleFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canSave = _titleController.text.isNotEmpty && _descController.text.isNotEmpty;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Новости', showBack: false),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2A86F),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back, size: 28, color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 700,
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7E5CF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Заголовок
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text('Заголовок', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _titleFocus.hasFocus ? const Color(0xFFE2A86F) : Colors.black26,
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _titleController,
                        focusNode: _titleFocus,
                        decoration: const InputDecoration(
                          hintText: 'Введите заголовок',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        ),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Картинка
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text('Картинка', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 450,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2A86F),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black26,
                            width: 2,
                          ),
                        ),
                        child: _imageBytes == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add, size: 36, color: Colors.black),
                                  const SizedBox(height: 8),
                                  const Text('Добавить картинку', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(_imageBytes!, fit: BoxFit.cover, width: 450, height: 180),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Описание
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text('Описание', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _descFocus.hasFocus ? const Color(0xFFE2A86F) : Colors.black26,
                          width: 2,
                        ),
                      ),
                      child: TextField(
                        controller: _descController,
                        focusNode: _descFocus,
                        decoration: const InputDecoration(
                          hintText: 'Введите описание новости',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        ),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        maxLines: 3,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: canSave && !_saving
                            ? () {
                                setState(() => _saving = true);
                                // TODO: добавить сохранение новости
                                Navigator.of(context).pop();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE2A86F),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                        ),
                        child: _saving
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                              )
                            : const Text('Сохранить', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 