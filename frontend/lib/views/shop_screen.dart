import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'search_players_screen.dart';
import 'inventory_screen.dart';
import 'pack_content_screen.dart';
import '../services/api_service.dart';
import '../models/shop_model.dart';
import '../models/card_model.dart';
import '../utils/error_formatter.dart';
import '../utils/auth_utils.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../services/analytics_service.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late bool _isLoading;
  late List<Pack> _packs;
  late List<CoinOffer> _coinOffers;
  late String _error;
  
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _packs = [];
    _coinOffers = [];
    _error = '';
    _loadShopData();
    AnalyticsService.trackScreenView('shop_screen');
  }

  Future<void> _loadShopData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final packs = await ApiService().getAllPacks();
      final coinOffers = await ApiService().getCoinOffers();
      
      setState(() {
        _packs = packs;
        _coinOffers = coinOffers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = ErrorFormatter.formatError(e);
      });
    }
  }

  Future<void> _buyPack(Pack pack) async {
    try {
      final result = await ApiService().buyPack(pack.pack_ID);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Набор успешно куплен!')),
      );
      
      // Открываем экран с содержимым набора
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PackContentScreen(
            setName: pack.name,
            cards: (result['receivedCards'] as List).map((item) => CardModel.fromJson(item)).toList(),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  Future<void> _buyCoinOffer(CoinOffer offer) async {
    try {
      final paymentUrl = await ApiService().purchaseCoins(
        offer.offer_ID,
        'cardly://payment-callback', // URL схема для возврата в приложение
      );
      
      // Здесь нужно реализовать открытие URL для оплаты
      // Это может быть WebView или переход в браузер
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ErrorFormatter.formatError(e))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EF),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                if (AuthUtils.checkGuestAccess(context, 'profile_screen')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                }
              },
              child: Image.asset('assets/icons/профиль.png', height: 24),
            ),
          ),
        ),
        title: null,
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEAD7C3),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '1000',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost',
                  ),
                ),
                SizedBox(width: 6.0),
                Image.asset('assets/icons/монеты.png', height: 20),
              ],
            ),
          ),
          IconButton(
            icon: Image.asset('assets/icons/поиск.png', height: 26),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const SearchPlayersModal(),
              );
            },
          ),
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                      _buildPacksSection(),
                      _buildCoinOffersSection(),
                    ],
                  ),
      ),
      bottomNavigationBar: null,
    );
  }
  
  Widget _buildPacksSection() {
        return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Наборы карт',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: _packs.length,
          itemBuilder: (context, index) {
            final pack = _packs[index];
            return Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      pack.imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
            Text(
                          pack.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${pack.price} монет'),
                        ElevatedButton(
                          onPressed: () => _buyPack(pack),
                          child: const Text('Купить'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCoinOffersSection() {
          return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Монеты',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _coinOffers.length,
          itemBuilder: (context, index) {
            final offer = _coinOffers[index];
            return ListTile(
              title: Text('${offer.coins} монет'),
              subtitle: Text('${offer.price} ₽'),
              trailing: ElevatedButton(
                onPressed: () => _buyCoinOffer(offer),
                child: const Text('Купить'),
              ),
          );
        },
      ),
      ],
    );
  }
} 