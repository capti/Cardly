import 'package:flutter/material.dart';
import 'package:adminpanel/models/quest.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/quest_controller.dart';

class CreateQuestPage extends StatefulWidget {
  const CreateQuestPage({Key? key}) : super(key: key);

  @override
  State<CreateQuestPage> createState() => _CreateQuestPageState();
}

class _CreateQuestPageState extends State<CreateQuestPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _progressController = TextEditingController(text: '0');
  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _rewardCoinsController = TextEditingController();
  final TextEditingController _rewardPacksController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final quest = Quest(
      quest_ID: DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      progress: int.tryParse(_progressController.text.trim()) ?? 0,
      target: int.tryParse(_targetController.text.trim()) ?? 0,
      rewardCoins: int.tryParse(_rewardCoinsController.text.trim()) ?? 0,
      rewardPacks: _rewardPacksController.text.trim().isEmpty ? [] : [_rewardPacksController.text.trim()],
      isCompleted: false,
      isClaimed: false,
    );
    Provider.of<QuestController>(context, listen: false).addQuest(quest);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: const NavBar(active: 'Главная', showBack: true),
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: const Color(0xFFF7E5CF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Создать квест', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                  validator: (v) => v == null || v.isEmpty ? 'Введите название' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _progressController,
                        decoration: const InputDecoration(labelText: 'Прогресс'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _targetController,
                        decoration: const InputDecoration(labelText: 'Цель'),
                        keyboardType: TextInputType.number,
                        validator: (v) => v == null || v.isEmpty ? 'Введите цель' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _rewardCoinsController,
                        decoration: const InputDecoration(labelText: 'Награда (монеты)'),
                        keyboardType: TextInputType.number,
                        validator: (v) => v == null || v.isEmpty ? 'Введите награду' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _rewardPacksController,
                        decoration: const InputDecoration(labelText: 'Награда (паки, через запятую)'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
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
                    child: const Text('Создать квест', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 