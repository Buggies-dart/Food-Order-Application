import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
        backgroundColor: ShowColors.secondary(), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Halle's Dining - Terms and Conditions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: ShowColors.primary(),
                ),
              ),
              const SizedBox(height: 16),
             const Text(
                "Welcome to Halle's Dining! These terms and conditions govern your use of our app. By downloading or using Halle's Dining, you agree to comply with the following terms.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
             const SizedBox(height: 16),
              buildSectionTitle("1. Use of the App"),
              buildSectionContent(
                  "- Halle's Dining provides features for browsing menus, placing orders, making reservations, and accessing restaurant services.\n"
                  "- You must be at least 18 years old or have parental consent to use the app.\n"
                  "- Use the app responsibly and only for its intended purposes."),
             const SizedBox(height: 16),
              buildSectionTitle("2. Account and Security"),
              buildSectionContent(
                  "- You are responsible for maintaining the confidentiality of your account details.\n"
                  "- Notify us immediately if you suspect unauthorized access to your account.\n"
                  "- We reserve the right to suspend or terminate accounts that violate our terms."),
               const SizedBox(height: 16),
              buildSectionTitle("3. Orders and Payments"),
              buildSectionContent(
                  "- All orders made through the app are subject to availability and confirmation.\n"
                  "- Prices may vary based on location and other factors. Taxes and service charges may apply.\n"
                  "- Payments are processed securely through authorized payment gateways. Ensure all payment details provided are accurate."),
             const SizedBox(height: 16),
              buildSectionTitle("4. Cancellations and Refunds"),
              buildSectionContent(
                  "- Cancellation policies may vary depending on the restaurant and services selected.\n"
                  "- Refunds, if applicable, will be processed according to our refund policy and at the restaurant's discretion."),
             const SizedBox(height: 16),
              buildSectionTitle("5. Intellectual Property"),
              buildSectionContent(
                  "- All content, logos, and trademarks in the app belong to Halle's Dining or its licensors.\n"
                  "- You are prohibited from copying, distributing, or exploiting any app content without prior written consent."),
              const SizedBox(height: 16),
              buildSectionTitle("6. User Conduct"),
              buildSectionContent(
                  "- You agree not to misuse the app, including engaging in fraudulent activity or disrupting its functionality.\n"
                  "- Offensive, discriminatory, or harmful behavior is strictly prohibited."),
const SizedBox(height: 16),
              buildSectionTitle("7. Privacy"),
              buildSectionContent(
                  "- By using Halle's Dining, you consent to our collection and use of personal data as outlined in our Privacy Policy."),
           const   SizedBox(height: 16),
              buildSectionTitle("8. Limitation of Liability"),
              buildSectionContent(
                  "- Halle's Dining is provided \"as is.\" We are not liable for any errors, interruptions, or damages resulting from app use."),
             const SizedBox(height: 16),
              buildSectionTitle("9. Modifications to Terms"),
              buildSectionContent(
                  "- Halle's Dining reserves the right to update these terms at any time. Continued use of the app implies acceptance of the updated terms."),
             const SizedBox(height: 16),
              buildSectionTitle("10. Contact Us"),
              buildSectionContent(
                  "If you have any questions or concerns about these terms, please contact us at support@hallesdining.com."),
             const SizedBox(height: 24),
            const  Text(
                "Last updated: 21/11/2024",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black54),
    );
  }
}

