import 'package:ai_saas_application/constant/colors.dart';
import 'package:ai_saas_application/constant/textstyles.dart';
import 'package:ai_saas_application/provider/premium_user.dart';
import 'package:ai_saas_application/stripe/stripe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionPortal extends StatefulWidget {
  const SubscriptionPortal({super.key});

  @override
  State<SubscriptionPortal> createState() => _SubscriptionPortalState();
}

class _SubscriptionPortalState extends State<SubscriptionPortal> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // Regular expression for email validation
  final RegExp _emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$', // Basic email regex
    caseSensitive: false,
  );

  // Form submission handler
  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Initiate payment process
      await initStripe(email: email, name: name);
      // Notify provider to update the premium status
      Provider.of<PremiumUser>(context, listen: false).checkPremiumUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activate the premium plan.See conversion history',
              style: Typhography().title.copyWith(color: terneryColor),
            ),
            Text(
              'user id:${FirebaseAuth.instance.currentUser?.uid}',
              style: Typhography().lable.copyWith(color: terneryColor),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!_emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Activate Premium for \$2.99',
                  style: Typhography().body),
            ),
          ],
        ),
      ),
    );
  }
}
