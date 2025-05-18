import 'package:flutter/material.dart';
import 'package:adminpanel/views/collections_page.dart';
import 'package:adminpanel/views/news_page.dart';
import 'package:adminpanel/views/users_page.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String active;
  final VoidCallback? onLogout;
  final bool showBack;
  const NavBar({required this.active, this.onLogout, this.showBack = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget navItem(String label, Widget page) {
      final bool selected = label == active;
      return GestureDetector(
        onTap: selected
            ? null
            : () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => page),
                );
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      );
    }

    return AppBar(
      backgroundColor: const Color(0xFFE2A86F),
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: const SizedBox.shrink(),
      title: Row(
        children: [
          if (showBack)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).maybePop(),
            )
          else
            const SizedBox(width: 8),
          navItem('Главная', const CollectionsPage()),
          navItem('Новости', const NewsPage()),
          navItem('Пользователи', const UsersPage()),
          navItem('Обмены', const CollectionsPage()), // TODO: заменить на ExchangesPage
          navItem('Жалобы', const CollectionsPage()), // TODO: заменить на ComplaintsPage
          navItem('Магазин', const CollectionsPage()), // TODO: заменить на ShopPage
          const Spacer(),
          TextButton(
            onPressed: onLogout ?? () {},
            child: const Text(
              'Выйти',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
} 