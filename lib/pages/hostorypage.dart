import 'package:ai_saas_application/constant/textstyles.dart';
import 'package:ai_saas_application/widget/user_history.dart';
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
        title: Text(
          "History",
          style: Typhography().title,
        ),
      ),
      body: const UserHistory(),
    );
  }
}
