import 'package:ai_saas_application/stripe/stripe_storage.dart';
import 'package:flutter/material.dart';

class PremiumUser with ChangeNotifier {
  bool _isPremium = false;
  bool get isPremium => _isPremium;

  //check is user primium
  Future<void> checkPremiumUser() async {
    _isPremium = await StripeStorage().checkPremiumUser();
    notifyListeners();
  }
//activate primum user
  void activatePremium() {
    _isPremium = true;
    notifyListeners();
  }
}
