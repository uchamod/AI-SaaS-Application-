import 'package:ai_saas_application/stripe/stripe_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> initStripe({required String name, required String email}) async {
  //create stripe user
  Map<String, dynamic>? userDetails =
      await createNewUser(email: email, name: name);
  if (userDetails == null || userDetails["id"] == null) {
    throw Exception("failed to create coustomer");
  }
  //cretae pyment intent
  Map<String, dynamic>? pymentIntent =
      await createPymentIntent(customerId: userDetails["id"]);
  if (pymentIntent == null || pymentIntent["client_secret"]) {
    throw Exception("failed to create pymentIntent");
  }

  //create credit card
  createCreditCard(
      customerId: userDetails["id"], secretCode: pymentIntent["client_secret"]);
  //get pyment data
  Map<String, dynamic>? pymentData =
      await getPymentData(customerId: userDetails["id"]);
  if (pymentData == null || pymentData["data"].isEmpty) {
    throw Exception("failed to get pymentmethod");
  }

  //create subscription
  Map<String, dynamic>? subscription = await createSubscription(
      customerId: userDetails["id"], paymentId: pymentData["data"][0]["id"]);

  if (subscription == null || subscription["id"] == null) {
    throw Exception("failed to create subscription");
  }
  
}

//create stripe user
Future<Map<String, dynamic>?> createNewUser(
    {required String email, required String name}) async {
  final Map<String, dynamic>? response = await apiServiceMethod(
      apiMethod: APISERVICES.post,
      endPoint: "customers",
      body: {
        name: name,
        email: email,
        'description': 'Text Extractor Pro Plan',
      });
  return response;
}

//cretae pyment intent
Future<Map<String, dynamic>?> createPymentIntent(
    {required String customerId}) async {
  final pymentIntent = await apiServiceMethod(
      apiMethod: APISERVICES.post,
      endPoint: "setup_intents",
      body: {
        'customer': customerId,
        'automatic_payment_methods[enabled]': 'true',
      });
  return pymentIntent;
}

//create credit card
Future<void> createCreditCard(
    {required String customerId, required String secretCode}) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      primaryButtonLabel: 'Subscribe \$4.99 monthly',
      style: ThemeMode.light,
      merchantDisplayName: 'Text Extractor Pro Plan',
      customerId: customerId,
      setupIntentClientSecret: secretCode,
    ),
  );

  await Stripe.instance.presentPaymentSheet();
}

//get pyment data
Future<Map<String, dynamic>?> getPymentData(
    {required String customerId}) async {
  final pymentData = await apiServiceMethod(
    apiMethod: APISERVICES.get,
    endPoint: 'customers/$customerId/payment_methods',
  );
  return pymentData;
}

//create subscription
Future<Map<String, dynamic>?> createSubscription(
    {required String customerId, required String paymentId}) async {
  final subscription = await apiServiceMethod(
      apiMethod: APISERVICES.post,
      endPoint: 'subscriptions',
      body: {
        'customer': customerId,
        'items[0][price]': 'price_1QECsQDy5aw4UDrv5q0tWBwl',
        'default_payment_method': paymentId,
      });

  return subscription;
}
