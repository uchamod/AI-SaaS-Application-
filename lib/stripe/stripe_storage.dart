import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StripeStorage {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //store premium user data in firestore
  Future<void> storePremiumData({
    required String customerId,
    required String email,
    required String userName,
    required String subscriptionId,
    required String paymentStatus,
    required DateTime startDate,
    required DateTime endDate,
    required String planId,
    required double amountPaid,
    required String currency,
    String? paymentMethod,
    String? subscriptionType,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? autoRenewal,
    String? cancellationReason,
    String? promoCode,
    Map<String, dynamic>? metadata,
  }) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      _firebaseFirestore.collection("premium user").doc(customerId).set({
        "userId": userId,
        'customerId': customerId,
        'email': email,
        'userName': userName,
        'subscriptionId': subscriptionId,
        'paymentStatus': paymentStatus,
        'startDate': startDate,
        'endDate': endDate,
        'planId': planId,
        'amountPaid': amountPaid,
        'currency': currency,
        'paymentMethod': paymentMethod ?? '',
        'subscriptionType': subscriptionType ?? 'premium',
        'createdAt': createdAt ?? DateTime.now(),
        'updatedAt': updatedAt ?? DateTime.now(),
        'autoRenewal': autoRenewal ?? true,
        'cancellationReason': cancellationReason ?? '',
        'promoCode': promoCode ?? '',
        'metadata': metadata ?? {},
      });
      print("store premium user data succsussfuly");
    } catch (err) {
      print("data storing error $err");
    }
  }

  Future<bool> checkPremiumUser() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("premium user")
          .where("userId", isEqualTo: userId)
          .get();
      return documentSnapshot.docs.isNotEmpty;
    } catch (err) {
      print("check user primum error $err");
      return false;
    }
  }
}
