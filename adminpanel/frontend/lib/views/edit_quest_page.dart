import 'package:flutter/material.dart';
import 'package:adminpanel/models/quest.dart';
import 'package:adminpanel/views/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:adminpanel/controllers/quest_controller.dart';

class EditQuestPage extends StatefulWidget {
  final Quest quest;
  const EditQuestPage({Key? key, required this.quest}) : super(key: key);

  @override
  State<EditQuestPage> createState() => _EditQuestPageState();
}

class _EditQuestPageState extends State<EditQuestPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _progressController;
  late TextEditingController _targetController;
  late TextEditingController _rewardCoinsController;
  late TextEditingController _rewardPacksController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.quest.name);
    _descController = TextEditingController(text: widget.quest.description);
    _progressController = TextEditingController(text: widget.quest.progress.toString());
    _targetController = TextEditingController(text: widget.quest.target.toString());
    _rewardCoinsController = TextEditingController(text: widget.quest.rewardCoins.toString());
    _rewardPacksController = TextEditingController(text: widget.quest.rewardPacks.join(", "));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final quest = Quest(
      quest_ID: widget.quest.quest_ID,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      progress: int.tryParse(_progressController.text.trim()) ?? 0,
      target: int.tryParse(_targetController.text.trim()) ?? 0,
      rewardCoins: int.tryParse(_rewardCoinsController.text.trim()) ?? 0,
      rewardPacks: _rewardPacksController.text.trim().isEmpty ? [] : _rewardPacksController.text.trim().split(',').map((e) => e.trim()).toList(),
      isCompleted: widget.quest.isCompleted,
      isClaimed: widget.quest.isClaimed,
    );
    Provider.of<QuestController>(context, listen: false).editQuest(quest);
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
                const Text('Редактировать квест', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                    child: const Text('Сохранить изменения', style: TextStyle(fontSize: 16)),
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