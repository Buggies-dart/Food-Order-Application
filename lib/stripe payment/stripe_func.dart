import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class StripeService {
  static const String secretKey =
      'sk_test_51Ou1F2FagdMkNPNjlW8AATgajCIhYyhm7k5VLz5VmP9vqbgarwUptP4LHhGEsTbgN1b8Q8BUfjxBuGhON4gJuurQ00K64K1lJ9';

  Future<void> makePayment(BuildContext context, WidgetRef ref,String amount) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      // Make HTTP request to create a payment intent
      final paymentIntent = await _createPaymentIntent(amount);

      // Check if client_secret is valid
      final clientSecret = paymentIntent['client_secret'];
      if (clientSecret == null) {
        if (context.mounted) {
          _showErrorDialog(context, 'Payment intent client secret is missing.');
        }
        return; // Stop further execution if client secret is missing
      }

      // Initialize the payment sheet
      await _initPaymentSheet(clientSecret);

      // Present the payment sheet to the user
      await Stripe.instance.presentPaymentSheet();
       final double parsedAmount = double.parse(amount);
      ref.read(Providers.myNotifProvider).addWallet(parsedAmount);

      // Show success message
      if (context.mounted) {
        _showSuccessDialog(context);
      }
    } catch (e) {
      // Handle errors gracefully
      if (context.mounted) {
        _showErrorDialog(
          context,
          e is StripeException
              ? e.error.localizedMessage ?? 'Payment was cancelled'
              : 'An unexpected error occurred. Please try again.',
        );
      }
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(String amount) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

    try {
      // Send a POST request to Stripe API
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': (int.parse(amount) * 100).toString(), // Convert to cents
          'currency': 'usd', // Currency
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating payment intent: ${e.toString()}');
    }
  }

  Future<void> _initPaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your Business Name',
        ),
      );
    } catch (e) {
      throw Exception('Error initializing payment sheet: ${e.toString()}');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Payment was successful!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    print('error dialog');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(  
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
