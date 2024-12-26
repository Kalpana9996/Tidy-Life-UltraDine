import 'package:flutter/material.dart';
import 'package:ultradine/screens/pages/bill_page.dart';
import 'package:ultradine/screens/pages/menu_page.dart';
import 'package:ultradine/screens/pages/orders_page.dart';
import 'package:ultradine/screens/pages/take_away.dart';
import 'package:ultradine/utils/customcolor.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MenuPage(),
    OrdersPage(cartItems: [], isTakeAway: true,),
    Seating_Page(cartItems: [], isTakeAway: true,),
    BillPage(selectedSeats: [], cartItems: [], totalPrice: 400, isTakeAway: true,),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.lightPurple1,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Take Away/Dine-In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Bill',
          ),
        ],
      ),
    );
  }
}
