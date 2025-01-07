import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String cuisines;
  final String price;
  final double rating;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.cuisines,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image Section (No margin between image and details)
        Container(
          width: double.infinity,
          height: 250,
          margin: const EdgeInsets.symmetric(
              horizontal: 16), // Removed vertical margin
          child: Image.asset("assets/images/restaurant1.png"),
        ),
        // Details Section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              Text(
                cuisines,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              const Text(
                "Zomato funds environmental projects to offset delivery carbon footprint",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              Text(
                price,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xff2b7d0e),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.star,
                        size: 10,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xff196b43),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Text(
                          "DELIVERY",
                          style: TextStyle(fontSize: 7, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xffecd824),
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: const Text(
                          "MAX SAFETY",
                          style: TextStyle(fontSize: 7, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
