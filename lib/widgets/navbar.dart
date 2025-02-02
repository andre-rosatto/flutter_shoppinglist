import 'package:flutter/material.dart';
import 'package:shopping_list/pages/compare.dart';
import 'package:shopping_list/pages/home.dart';
import 'package:shopping_list/pages/notes.dart';

class Navbar extends StatefulWidget {
  final int index;

  const Navbar({
    super.key,
    required this.index,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<Map> pages = [
    {
      'label': 'Listas',
      'icon': Icon(Icons.list),
      'widget': Home(),
    },
    {
      'label': 'Anotações',
      'icon': Icon(Icons.text_snippet),
      'widget': Notes(),
    },
    {
      'label': 'Comparar',
      'icon': Icon(Icons.price_check),
      'widget': Compare(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      items: [
        for (int i = 0; i < pages.length; i++)
          BottomNavigationBarItem(
            icon: pages[i]['icon'],
            label: pages[i]['label'],
          ),
      ],
      currentIndex: widget.index,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
      onTap: (index) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => pages[index]['widget']));
      },
    );
  }
}
