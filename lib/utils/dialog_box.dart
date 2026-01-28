import 'package:flutter/material.dart';

Future<bool?> showSkipDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap a button
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text(
        'Are you sure?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text(
        'Do you want to skip this?',
        style: TextStyle(fontSize: 16),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // No pressed
          },
          child: const Text(
            'No',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true); // Yes pressed
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
