import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:adminpanel/models/achievement.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/achievement_controller.dart';

class AddAchievementPage extends StatefulWidget {
  const AddAchievementPage({Key? key}) : super(key: key);

  @override
  State<AddAchievementPage> createState() => _AddAchievementPageState();
}

class _AddAchievementPageState extends State<AddAchievementPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String imageURL = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Главная', showBack: true),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFFF7E5CF),
            borderRadius: BorderRadius.circular(16),
          ),
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Добавить достижение', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Название'),
                  onChanged: (v) => setState(() => name = v),
                  validator: (v) => v == null || v.isEmpty ? 'Введите название' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'URL изображения'),
                  onChanged: (v) => setState(() => imageURL = v),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Описание'),
                  onChanged: (v) => setState(() => description = v),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final achievement = Achievement(
                        achievement_ID: DateTime.now().millisecondsSinceEpoch,
                        name: name,
                        imageURL: imageURL,
                        description: description,
                        isUnlocked: false,
                      );
                      Provider.of<AchievementController>(context, listen: false).addAchievement(achievement);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2A86F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text('Сохранить', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 