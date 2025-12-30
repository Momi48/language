import 'package:flutter/material.dart';
import 'package:language/widget/khwar_keyboard.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final uri =
      "https://play.google.com/store/apps/details?id=com.fli.kho.flikhowarkeyboard";
  Future<void> launchPlayStoreUrl() async {
    if (await canLaunchUrl(Uri.parse(uri))) {
      launchUrl(Uri.parse(uri), mode: LaunchMode.externalApplication);
    } else {
      print('Error Launching app');
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => KhwarKeyboardDialog(
          onPressed: () {
            print("Hello World");
            launchPlayStoreUrl();
          },
        ),
      );
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20,),
          /// FIRST TEXT FIELD
          TextFormField(
            minLines: 4,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Enter first text",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// SECOND TEXT FIELD
          TextFormField(
            minLines: 4,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Enter second text",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// BUTTON ROW
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Save"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}
