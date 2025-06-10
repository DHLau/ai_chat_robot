import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Remind me to buy groceries when I get to the store.Remind me to buy groceries when I get to the store.Remind me to buy groceries when I get to the store.",
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/header_image.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
