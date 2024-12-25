import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luncher/config/app_text_style.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<ChatItem> chatItems = [
      ChatItem(
        name: "Kate Austen",
        message:
            "Hey Cody, you should definitely check out Yoga Six for hot yoga! They have amazing instructors...",
        timestamp: "11:23 AM",
        imageUrl: "https://via.placeholder.com/150",
      ),
      ChatItem(
        name: "Scott Middough",
        message: "Yeah sounds good man. 👍",
        timestamp: "Aug 21",
        imageUrl: "https://via.placeholder.com/150",
      ),
      ChatItem(
        name: "Thomas Hidalgo",
        message: "Hmm… good question. I'm not sure",
        timestamp: "Aug 19",
        imageUrl: "https://via.placeholder.com/150",
      ),
      ChatItem(
        name: "Jamie Allender",
        message:
            "What type of surfboard did you end up buying? I was thinking of getting something similar.",
        timestamp: "Jul 19",
        imageUrl: "https://via.placeholder.com/150",
      ),
      ChatItem(
        name: "Angel Hernandez",
        message: "You down to hit up TCP? Let me know when you’re free.",
        timestamp: "Jul 19",
        imageUrl: "https://via.placeholder.com/150",
      ),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),

                  // Settings Title
                  Text(
                    'NOFITICATIONS', // Title text
                    style: AppTextStyles.MetropolisMedium.copyWith(
                      fontSize: 18,
                      color: const Color(0xFF434343),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: chatItems.length,
                      itemBuilder: (context, index) {
                        final chat = chatItems[index];
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    // Avatar
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: Image.asset(
                                        'assets/images/userimg.png',
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Chat Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Title and Date Row
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                chat.name,
                                                style: AppTextStyles.EuropaBold
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                chat.timestamp,
                                                style: AppTextStyles.EuropaLight
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          // Message (Subtitle)
                                          Text(
                                            chat.message,
                                            style: AppTextStyles.EuropaLight
                                                .copyWith(
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Divider(
                                color: Color(0xFFEEEEEE),
                                thickness: 1,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ])));
  }
}

class ChatItem {
  final String name;
  final String message;
  final String timestamp;
  final String imageUrl;

  ChatItem({
    required this.name,
    required this.message,
    required this.timestamp,
    required this.imageUrl,
  });
}
