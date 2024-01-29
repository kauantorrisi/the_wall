import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String textOfButton;
  const RowButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.textOfButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onTap,
            child: Text(
              textOfButton,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
