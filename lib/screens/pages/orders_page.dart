import 'package:flutter/material.dart';
import 'package:ultradine/screens/pages/bill_page.dart';
import 'package:ultradine/screens/pages/take_away.dart';
import '../../utils/customcolor.dart';

class OrdersPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final bool isTakeAway;

  const OrdersPage({super.key, required this.cartItems, required this.isTakeAway});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late List<int> itemCounts;

  @override
  void initState() {
    super.initState();
    itemCounts = List.filled(widget.cartItems.length, 1, growable: true);
  }

  int _calculateTotalPrice() {
    int total = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      final price = (widget.cartItems[i]['price'] as num).toInt();
      final itemCount = (i < itemCounts.length) ? itemCounts[i] : 1;
      total += price * itemCount;
    }
    return total;
  }

  void _incrementItemCount(int index) {
    setState(() {
      itemCounts[index]++;
    });
  }

  void _decrementItemCount(int index) {
    setState(() {
      if (itemCounts[index] > 1) {
        itemCounts[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final item = widget.cartItems[index];
          return ListTile(
            leading: Image.asset(
              item['image'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item['name']),
            subtitle: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => _decrementItemCount(index),
                ),
                Text('${itemCounts[index]}'),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => _incrementItemCount(index),
                ),
              ],
            ),
            trailing: Text('₹${item['price'] * itemCounts[index]}'),
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!widget.isTakeAway) // Show only for dine-in orders
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: CustomColors.black,
                  backgroundColor: CustomColors.lightPurple1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BillPage(
                        cartItems: widget.cartItems,
                        totalPrice: _calculateTotalPrice(),
                        isTakeAway: widget.isTakeAway, selectedSeats: [],
                      ),
                    ),
                  );
                },
                child: const Text('Select Seating'),
              ),
            if (widget.isTakeAway) // For take-away, show a billing button directly
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: CustomColors.black,
                  backgroundColor: CustomColors.lightPurple1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Seating_Page(cartItems: [], isTakeAway: true,),
                    ),
                  );
                },
                child: const Text('Proceed'),
              ),
            Text(
              'Total: ₹${_calculateTotalPrice()}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
