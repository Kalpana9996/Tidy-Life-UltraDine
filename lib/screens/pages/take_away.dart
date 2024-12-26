import 'package:flutter/material.dart';
import 'package:ultradine/screens/pages/bill_page.dart';
import 'package:ultradine/utils/constants.dart';
import 'package:ultradine/utils/custom_appbar.dart';
import 'package:ultradine/utils/customcolor.dart';

import 'dine_in_seating.dart';

class Seating_Page extends StatefulWidget {

  final List<Map<String, dynamic>> cartItems;
  final bool isTakeAway;

  const Seating_Page({super.key, required this.cartItems, required this.isTakeAway});


  @override
  State<Seating_Page> createState() => _Seating_PageState();
}

class _Seating_PageState extends State<Seating_Page> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Define the animation
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInCubic,
    );

    // Start the animation
    _controller!.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Constants.appName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              homeWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeWidget() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              AnimatedBuilder(
                animation: _animation!,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - _animation!.value) * 50), // Slide in
                    child: Opacity(
                      opacity: _animation!.value,
                      child: child,
                    ),
                  );
                },
                child: cardWidget(
                  text: Constants.dineIn,
                  imagePath: "assets/images/dining.png",
                  onTap: () {
                    // Navigate to the seating page when Dine-In is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SeatingPage(cartItems: [], isTakeAway: true,)), // Assuming SeatingPage is the seat selection page
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                animation: _animation!,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - _animation!.value) * 50),
                    child: Opacity(
                      opacity: _animation!.value,
                      child: child,
                    ),
                  );
                },
                child: cardWidget(
                  text: Constants.takeAway,
                  imagePath: "assets/images/takeaway.png",
                  onTap: () {
                    // Navigate to the billing page when Take Away is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BillPage(selectedSeats: [], cartItems: [], totalPrice: 400, isTakeAway: true,)), // Assuming BillingPage is the billing page
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cardWidget({
    required String text,
    required VoidCallback onTap,
    required String imagePath, // Add imagePath parameter
  }) {
    return Card(
      color: CustomColors.lightPurple1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath, // Display the image
              height: 80, // Adjust the size of the image
              width: 80,
              fit: BoxFit.cover,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
