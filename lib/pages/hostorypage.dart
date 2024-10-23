import 'package:ai_saas_application/constant/textstyles.dart';
import 'package:flutter/material.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text("AI Text Recognizer",style: Typhography().title,),
      ),
    );
  }
}
