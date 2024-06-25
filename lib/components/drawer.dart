import 'package:flutter/material.dart';
import 'package:notes/components/drawer_tile.dart';
import 'package:notes/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //header
          DrawerHeader(
              child: Image.asset('lib/images/notes.png',
                  color: Color.fromARGB(255, 104, 101, 107))),

          //notes tile
          DrawerTile(
              title: "N O T E S",
              leading: const Icon(Icons.home,
                  color: Color.fromARGB(255, 104, 101, 107)),
              onTap: () => Navigator.pop(context)),

          // settings tile
          const SizedBox(
            height: 20,
          ),
          DrawerTile(
              title: "S E T T I N G S",
              leading: const Icon(Icons.settings,
                  color: Color.fromARGB(255, 104, 101, 107)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              }),
          const SizedBox(
            height: 450,
          ),
          DrawerTile(
              title: " S A N ",
              leading: const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 218, 20, 96),
              ),
              onTap: () {}),
        ],
      ),
    );
  }
}
