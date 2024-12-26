import 'package:flutter/material.dart';
import 'package:ultradine/screens/pages/orders_page.dart';

import '../../utils/constants.dart';
import '../../utils/custom_appbar.dart';
import '../../utils/customcolor.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Map<String, dynamic>> _menuItems = [
    {'name': 'Chicken', 'price': 250, 'image': 'assets/images/christmas-dinner.png'},
    {'name': 'Fries', 'price': 150, 'image': 'assets/images/fast-food.png'},
    {'name': 'Fish', 'price': 350, 'image': 'assets/images/fish-and-chips.png'},
    {'name': 'pizza', 'price': 199, 'image': 'assets/images/pizza.png'},
    {'name': 'Ice_Cream', 'price': 100, 'image': 'assets/images/sweets.png'},
    {'name': 'Drinks', 'price': 100, 'image': 'assets/images/drink.png'},
    {'name': 'Burger', 'price': 299, 'image': 'assets/images/hamburger.png'},
  ];

  final List<Map<String, dynamic>> _cartItems = [];

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      _cartItems.add(item);
    });
  }

  void _navigateToOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersPage(cartItems: _cartItems, isTakeAway: true,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightPurple1,
      appBar: CustomAppBar(
        title: Constants.appName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _menuItems.length,
          itemBuilder: (context, index) {
            final item = _menuItems[index];
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Add ${item['name']} to Cart'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            item['image'],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text('Price: ₹${item['price']}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _addToCart(item);
                            Navigator.pop(context);
                          },
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    );
                  },
                );

              },
              child: Card(
                elevation: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        item['image'],
                        height: 100,
                        width: 100,

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹${item['price']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomSheet: _cartItems.isEmpty
          ? const SizedBox.shrink()
          : Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cart Items:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: CustomColors.black,
                      backgroundColor: CustomColors.lightPurple1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),
                  onPressed: _navigateToOrders,
                  child: const Text('Proceed to Orders'),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = _cartItems[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(cartItem['name']),
                        const SizedBox(width: 4),
                        Text(
                          '₹${cartItem['price']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

