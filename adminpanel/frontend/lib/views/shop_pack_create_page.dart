import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';

class ShopPackCreatePage extends StatefulWidget {
  const ShopPackCreatePage({Key? key}) : super(key: key);

  @override
  State<ShopPackCreatePage> createState() => _ShopPackCreatePageState();
}

class _ShopPackCreatePageState extends State<ShopPackCreatePage> {
  final TextEditingController _nameController = TextEditingController();
  String _sort = 'По редкости';
  final List<String> _sortOptions = ['По редкости', 'По коллекциям'];
  final List<int> _cards = List.generate(20, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Магазин', showBack: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Container(
              width: 350,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF7E5CF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Название набора',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: _showCardPicker,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2A86F),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Center(
                          child: Icon(Icons.add, size: 28, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: SizedBox(
          width: 10,
          height: 52,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE2A86F),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              elevation: 0,
            ),
            child: const Text('Сохранить'),
          ),
        ),
      ),
    );
  }

  void _showCardPicker() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7E5CF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DropdownButton<String>(
                      value: _sort,
                      items: _sortOptions.map((s) => DropdownMenuItem(
                        value: s,
                        child: Text('Сортировка\n$s'),
                      )).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _sort = val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 5,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _cards.map((c) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2A86F),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 