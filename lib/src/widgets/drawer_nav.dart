import 'package:flutter/material.dart';

class DrawerNav extends StatelessWidget{
  final int selectedIndex;
  final Function(int) onItemTapped;
  const DrawerNav({super.key , required this.selectedIndex , required this.onItemTapped});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/hitler.jpg')),
                color: Colors.blue,
              ),
              child: Text('Shopping note' , style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.red),),
            ),
            ListTile(
              title: const Text('Home'),
              selected: selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('phone'),
              selected: selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Setting'),
              selected: selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
  }

}