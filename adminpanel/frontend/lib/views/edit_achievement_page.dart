import 'package:flutter/material.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:adminpanel/models/achievement.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/achievement_controller.dart';

class EditAchievementPage extends StatefulWidget {
  final Achievement achievement;
  const EditAchievementPage({Key? key, required this.achievement}) : super(key: key);

  @override
  State<EditAchievementPage> createState() => _EditAchievementPageState();
}

class _EditAchievementPageState extends State<EditAchievementPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String imageURL;
  late String description;

  @override
  void initState() {
    super.initState();
    name = widget.achievement.name;
    imageURL = widget.achievement.imageURL;
    description = widget.achievement.description;
  }

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
                const Text('Редактировать достижение', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: 'Название'),
                  onChanged: (v) => setState(() => name = v),
                  validator: (v) => v == null || v.isEmpty ? 'Введите название' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: imageURL,
                  decoration: const InputDecoration(labelText: 'URL изображения'),
                  onChanged: (v) => setState(() => imageURL = v),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(labelText: 'Описание'),
                  onChanged: (v) => setState(() => description = v),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final achievement = Achievement(
                        achievement_ID: widget.achievement.achievement_ID,
                        name: name,
                        imageURL: imageURL,
                        description: description,
                        isUnlocked: widget.achievement.isUnlocked,
                      );
                      Provider.of<AchievementController>(context, listen: false).editAchievement(achievement);
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