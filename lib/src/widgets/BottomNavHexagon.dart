import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:uber_doctor_flutter/src/pages/home_page.dart';
import 'package:uber_doctor_flutter/src/pages/phone_page.dart';
import 'package:uber_doctor_flutter/src/widgets/Visit_Provider.dart';

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    title: 'Home',
    
  ),
  TabItem(
    icon: Icons.phone,
    title: 'phone',
  ),
  TabItem(
    icon: Icons.coronavirus,
    title: 'symptom',
  ),
  TabItem(
    icon: Icons.calendar_month,
    title: 'Booking',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];



class CurrentPage extends StatelessWidget {
    Color colorSelect =const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const  Color(0XFF1752FE);
  final int selectedIndex;
  final void Function(int) onItemTapped;

  

  CurrentPage({super.key, required this.selectedIndex, required this.onItemTapped});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context), 
      bottomNavigationBar: BottomBarInspiredOutside(
        items: items,
        backgroundColor: bgColor,
        color: color2,
        colorSelected: Colors.white,
        indexSelected: context.watch<VisitProvider>().visit, 
        onTap: (int index) {
          context.read<VisitProvider>().updateVisit(index); 
        },
      ),
      
    );
  }

  Widget _buildContent(BuildContext context) {
    final visit = context.watch<VisitProvider>().visit; 

    switch (visit) {
      case 0:
        return HomePage();
      case 1:
        return Phone();
      case 2:
        return HomePage();
      default:
        // Trang mặc định hoặc xử lý ngoại lệ
        return Container();
    }
  }
}

