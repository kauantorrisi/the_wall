import 'package:flutter/material.dart';

import 'package:the_wall/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final Function()? onLogout;
  final Function()? onProfileTap;
  const MyDrawer({
    super.key,
    required this.onLogout,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),
              MyListTile(
                icon: Icons.home,
                text: 'I N Í C I O',
                onTap: () => Navigator.of(context).pop(),
              ),
              MyListTile(
                icon: Icons.person,
                text: 'P E R F I L',
                onTap: onProfileTap,
              ),
            ],
          ),
          MyListTile(
            icon: Icons.logout,
            text: 'S A I R',
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
