import 'package:adminpanel/models/pack.dart';
import 'package:adminpanel/models/card.dart';

class PackController {
  final List<Pack> _packs = [];

  List<Pack> get packs => List.unmodifiable(_packs);

  void addPack(Pack pack) {
    _packs.add(pack);
  }

  void editPack(int packId, List<CardModel> newCards) {
    final index = _packs.indexWhere((p) => p.packId == packId);
    if (index != -1) {
      final oldPack = _packs[index];
      _packs[index] = Pack(
        packId: oldPack.packId,
        name: oldPack.name,
        imageUrl: oldPack.imageUrl,
        cards: newCards,
        price: oldPack.price,
      );
    }
  }

  void deletePack(int packId) {
    _packs.removeWhere((p) => p.packId == packId);
  }

  void changePackTexture(int packId, String imageUrl) {
    final index = _packs.indexWhere((p) => p.packId == packId);
    if (index != -1) {
      final oldPack = _packs[index];
      _packs[index] = Pack(
        packId: oldPack.packId,
        name: oldPack.name,
        imageUrl: imageUrl,
        cards: oldPack.cards,
        price: oldPack.price,
      );
    }
  }
} 