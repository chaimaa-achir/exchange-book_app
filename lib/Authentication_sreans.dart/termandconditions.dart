import 'package:flutter/material.dart';
import 'package:mini_project/Authentication_sreans.dart/signupscrean.dart';

class TermsAndConditionsPage extends StatelessWidget {
  
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SectionTitle("📚 Exchange Book – Terms & Conditions"),
                    SectionText(
                        "Welcome to Exchange Book! Please read these terms and conditions carefully before using the app."),
                    SizedBox(height: 16),
                    SectionTitle("👋 1. About the App"),
                    SectionText(
                        "Exchange Book is a free platform that allows users to exchange, sell, and borrow books. It also includes a comment system and a community space for book lovers to connect and share."),
                    SectionTitle("👶 2. Who Can Use the App"),
                    SectionText(
                        "The app is suitable for users of all ages! However, we recommend parental guidance for younger users, especially when interacting with others in the community."),
                    SectionTitle("🔐 3. Account & Personal Information"),
                    SectionText(
                        "To use Exchange Book, you need to create an account using your name and email. We respect your privacy and will never share your personal information without your permission."),
                    SectionTitle("💬 4. Content & Interactions"),
                    SectionText(
                        "• Users can list books, add descriptions, and share details.\n"
                        "• You can comment on books and participate in forum discussions.\n"
                        "• Please keep all interactions respectful. Inappropriate content or language is not allowed and may be removed.\n"
                        "⚠️ Note: There is no rating system for books."),
                    SectionTitle("💸 5. Fees & Subscriptions"),
                    SectionText(
                        "Exchange Book is 100% free to use. There are no paid subscriptions or hidden charges."),
                    SectionTitle("🌐 6. Community & Forum"),
                    SectionText(
                        "We offer a community space and forums where users can engage, share thoughts, and help each other. Please be kind, constructive, and supportive."),
                    SectionTitle("⚖️ 7. Responsibility & Safety"),
                    SectionText(
                        "• We do not take responsibility for book exchanges or sales made between users.\n"
                        "• Be cautious and ensure safe exchanges.\n"
                        "• Report any suspicious or inappropriate behavior to us immediately."),
                    SectionText(
                        "By using Exchange Book, you agree to these terms and help us keep this a safe and enjoyable platform for everyone. Happy reading! 📖✨"),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                
                Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>Signupscrean(isAgree:true,)),
                          );
                    
                },
                child: const Text(
                  "✅ I Agree",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class SectionText extends StatelessWidget {
  final String text;
  const SectionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
