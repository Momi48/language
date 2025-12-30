import 'package:flutter/material.dart';
import 'package:language/utils/global_variables.dart';

class KhwarKeyboardDialog extends StatefulWidget {
  final VoidCallback onPressed;
  const KhwarKeyboardDialog({super.key,required this.onPressed});

  @override
  State<KhwarKeyboardDialog> createState() => _KhwarKeyboardDialogState();
}

class _KhwarKeyboardDialogState extends State<KhwarKeyboardDialog> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
      return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text(
        "Khwar Keyboard Required",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "To continue, please navigate to the Play Store and download the Khwar keyboard.",
            style: TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 16),

          /// CHECKBOX ROW
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (val){
                  setState(() {
                  isChecked = val!;  
                  });
                  
                },
              ),
              const Expanded(
                child: Text(
                  "Don’t show this again",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
  onPressed: widget.onPressed,
  style: ElevatedButton.styleFrom(
    backgroundColor: greenButton,
  ),
  child: const Text(
    "Go to Play Store",
    style: TextStyle(color: Colors.white),
  ),
),

      ],
    );
  
  }
}