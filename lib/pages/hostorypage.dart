import 'package:ai_saas_application/constant/colors.dart';
import 'package:ai_saas_application/constant/textstyles.dart';
import 'package:ai_saas_application/provider/premium_user.dart';
import 'package:ai_saas_application/widget/subscription_portal.dart';
import 'package:ai_saas_application/widget/user_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  @override
  Widget build(BuildContext context) {
    final isPremiumUser = Provider.of<PremiumUser>(context);
    //check user state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPremiumUser.checkPremiumUser();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History",
          style: Typhography().title,
        ),
      
        actions:  [isPremiumUser.isPremium ?
          const Padding(
            padding: EdgeInsets.only(right: verticalPadding),
            child: Icon(
              Icons.workspace_premium,
              color: Colors.yellowAccent,
              size: 24,
            ),
          ) : const SizedBox()
        ]
      ),
      body: isPremiumUser.isPremium
          ? const UserHistory()
          : const SubscriptionPortal(),
    );
  }
}
