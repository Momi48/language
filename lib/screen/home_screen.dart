import 'dart:math';

import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language/model/user_model.dart';
import 'package:language/widget/buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
final rand = Random();
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final khowarController = TextEditingController();
  final englishController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, String>> wordPairs = [];
  int? currentIndex;

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
    showExcelData();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => KhwarKeyboardDialog(
    //       onPressed: () {
    //         print("Hello World");
    //      //   launchPlayStoreUrl();
    //       },
    //     ),
    //   );
    // });
  }

  String selectedLanguage = 'Khowar → English';
  final List<String> languageOptions = [
    'Khowar → Roman Urdu',
    'Khowar → English',
  ];
  // final List<String> languageOptions = [

  //   'English → Roman Khowar',
  //   //'Urdu → Roman Khowar',
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()async{
          await FirebaseAuth.instance.signOut();
        }, icon: Icon(Icons.logout)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: wordPairs.isEmpty
            ? Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Dropdown stays the same
                      SizedBox(height: 25),
                      DropdownButtonFormField<String>(
                        initialValue: selectedLanguage,
                        decoration: InputDecoration(
                          labelText: 'Select Language',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: languageOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                            //print(' and slected $value');
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // First TextFormField
                      TextFormField(
                        controller: selectedLanguage == "English → Roman Khowar"
                            ? englishController
                            : khowarController,
                        readOnly: selectedLanguage == "English → Roman Khowar"
                            ? false
                            : true,
                        style: selectedLanguage == "English → Roman Khowar"
                            ? null
                            : TextStyle(fontSize: 30),
                        minLines: 4,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: selectedLanguage == "English → Roman Khowar"
                            ? (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Khowar sentence cannot be empty';
                                }
                                return null;
                              }
                            : null,
                      ),

                      const SizedBox(height: 16),

                      // Second TextFormField
                      TextFormField(
                        controller: selectedLanguage == "English → Roman Khowar"
                            ? khowarController
                            : englishController,
                        minLines: 4,
                        maxLines: 4,
                        readOnly: selectedLanguage == "English → Roman Khowar"
                            ? true
                            : false,
                        style: selectedLanguage == "English → Roman Khowar"
                            ? TextStyle(fontSize: 30)
                            : null,
                        decoration: InputDecoration(
                          hintText: "Enter second text",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: selectedLanguage == "English → Roman Khowar"
                            ? null
                            : (value) {
                              return null;
                            
                                // if (value == null || value.isEmpty) {
                                //   return 'Second text cannot be empty';
                                // }
                                // return null;
                              },
                      ),
                      SizedBox(height: 20),
                      Buttons(text: "Save", onPressed: () {}),
                      SizedBox(height: 15),
                      Buttons(
                        text: "Next",
                        onPressed: () {
                          print("Current index $currentIndex");
                          if (_formKey.currentState!.validate()) {
                            if (currentIndex! < wordPairs.length - 1) {
                              
                              final randomNumber = rand.nextInt(
                                wordPairs.length,
                              );
                              currentIndex = randomNumber;
                              khowarController.text =
                                  wordPairs[currentIndex!]['khowar'].toString();
                            } else {
                              currentIndex = 0;
                            }
                          }
                          if (englishController.text.isEmpty) {
                            // showSkipDialog(context);
                            englishController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> showExcelData() async {
    print('This is working');
    ByteData data = await rootBundle.load('assets/Molana Sir.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    print("this is working also ${excel.tables.length} ");
    for (var table in excel.tables.keys) {
      print("this is working also 3 ");
      print("Data is $table"); //sheet Name
      //   print("Max Columns ${excel.tables[table]!.maxColumns}");
      for (var rowss in excel.tables[table]!.rows) {
        if (rowss.isEmpty || rowss[1]?.value == null) continue;
        // print("Khwar :${rowss[0]!.value} || English ${rowss[1]!.value} ");
        wordPairs.add({
          'khowar': rowss[0]!.value.toString(),
          'english': rowss[1]!.value.toString(),
        });
      }
    }
    setState(() {});
    currentIndex = rand.nextInt(wordPairs.length);
    for (int i = 0; i < wordPairs.length; i++) {
      if (wordPairs[currentIndex!] == wordPairs[0] && wordPairs[currentIndex!] == wordPairs[1]) {
        continue;
      }
      if (wordPairs.isNotEmpty) {
        //print("Random Number $randomNumber");
        
        khowarController.text = wordPairs[currentIndex!]['khowar'].toString();
       final user = UserModel(
          currentIndex: currentIndex,
          currentSentence: khowarController.text,
        );
        print("Current index is ${user.currentIndex} ${user.currentSentence}");
      }
    }
    
    setState(() {});
  }
}
