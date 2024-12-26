import 'package:flutter/material.dart';
import 'package:ultradine/screens/pages/bill_page.dart';

import '../../utils/customcolor.dart';

class SeatingPage extends StatefulWidget {

  final List<Map<String, dynamic>> cartItems;
  final bool isTakeAway;

  const SeatingPage({super.key, required this.cartItems, required this.isTakeAway});
  @override
  _SeatingPageState createState() => _SeatingPageState();
}

class _SeatingPageState extends State<SeatingPage> {
  int totalSeats = 20; // Total number of seats
  List<int> availableSeats = List.generate(20, (index) => index + 1); // List of seat numbers
  List<int> selectedSeats = []; // List of selected seat numbers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Seat"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section: Display available, selected, and total seats
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Available Seats: ${availableSeats.length}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text("Selected Seats: ${selectedSeats.length}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text("Total Seats: $totalSeats",
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Middle Section: Seat selection grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of seats per row
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: totalSeats,
              itemBuilder: (context, index) {
                final seatNumber = index + 1;
                final isAvailable = availableSeats.contains(seatNumber);
                final isSelected = selectedSeats.contains(seatNumber);

                return GestureDetector(
                  onTap: isAvailable
                      ? () {
                    setState(() {
                      if (isSelected) {
                        selectedSeats.remove(seatNumber);
                      } else {
                        selectedSeats.add(seatNumber);
                      }
                    });
                  }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? Colors.green
                            : isAvailable
                            ? Colors.black
                            : Colors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/dining.png', // Add your chair image to the assets folder
                            height: 40,
                            color: isSelected
                                ? CustomColors.green
                                : isAvailable
                                ? CustomColors.black
                                : Colors.red,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            seatNumber.toString(),
                            style: TextStyle(
                              color: isSelected || isAvailable
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Section: Button to navigate to billing page
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: CustomColors.lightPurple1,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: selectedSeats.isNotEmpty
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BillPage(
                        cartItems: widget.cartItems,
                        //totalPrice: _calculateTotalPrice(),
                        isTakeAway: widget.isTakeAway, selectedSeats: [], totalPrice: 300,

                    ),
                  ),
                );
              }
                  : null, // Disable button if no seat is selected
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: const Text("Proceed to Billing"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
