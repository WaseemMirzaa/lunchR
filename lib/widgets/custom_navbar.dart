import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<String> imagePaths; // Use image paths instead of icons

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      padding: EdgeInsets.zero,
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      elevation: 8,
      child: Container(
        width: double.infinity, // Ensures full width
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -3), // Shadow upward
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(imagePaths.length, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onItemTapped(index),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center horizontally
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Align items at the top
                  children: [
                    // Gradient Indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 6,
                      width: selectedIndex == index
                          ? 43
                          : 0, // Hide if not selected
                      decoration: BoxDecoration(
                        gradient: selectedIndex == index
                            ? const LinearGradient(
                                colors: [Colors.pink, Colors.orange],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Image (Different sizes for different icons)
                    Image.asset(
                      imagePaths[index],
                      width: 24,
                      height: 24,
                      color: const Color(0xFF707070),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
