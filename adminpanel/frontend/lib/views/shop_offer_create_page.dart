import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';

class ShopOfferCreatePage extends StatefulWidget {
  const ShopOfferCreatePage({Key? key}) : super(key: key);

  @override
  State<ShopOfferCreatePage> createState() => _ShopOfferCreatePageState();
}

class _ShopOfferCreatePageState extends State<ShopOfferCreatePage> {
  final TextEditingController _priceController = TextEditingController();
  final List<String> _allPacks = List.generate(5, (i) => 'Набор #${i + 1}');
  final List<String> _selectedPacks = [];
  String? _selectedPack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Магазин', showBack: true),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFF7E5CF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2A86F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 32, color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Выбор наборов', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Цена:', style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Введите цену',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: _selectedPacks.isEmpty
                      ? [
                          const Center(child: Text('Нет выбранных наборов', style: TextStyle(color: Colors.black54))),
                        ]
                      : _selectedPacks.map((pack) => ListTile(
                            dense: true,
                            title: Text(pack),
                            trailing: IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () {
                                setState(() => _selectedPacks.remove(pack));
                              },
                            ),
                          )).toList(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPack,
                      items: _allPacks
                          .where((p) => !_selectedPacks.contains(p))
                          .map((pack) => DropdownMenuItem(
                                value: pack,
                                child: Text(pack),
                              ))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedPack = val),
                      decoration: const InputDecoration(
                        hintText: 'Выбрать набор',
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _selectedPack == null
                        ? null
                        : () {
                            if (_selectedPack != null && !_selectedPacks.contains(_selectedPack)) {
                              setState(() {
                                _selectedPacks.add(_selectedPack!);
                                _selectedPack = null;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE2A86F),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      elevation: 0,
                    ),
                    child: const Text('Добавить'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2A86F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  child: const Text('Создать'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 