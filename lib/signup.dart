import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'colors.dart'; // Make sure you have this file with your color constants

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The Scaffold body is a Stack to layer the form and the header circle.
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          // The form is aligned to the bottom and contains our scroll logic.
          _buildForm(context),

          // The header circle floats on top.
          _buildHeaderCircle(context),
        ],
      ),
    );
  }

  // --- WIDGET for the top overlapping circle ---
  Widget _buildHeaderCircle(BuildContext context) {
    return Positioned(
      top: -60,
      left: -40,
      child: Container(
        height: 200,
        width: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryBlue,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.arrow_back, color: kWhite, size: 20),
                    SizedBox(width: 5),
                    Text(
                      'Back',
                      style: TextStyle(color: kWhite, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET FOR THE MAIN FORM WITH INTERNAL SCROLLING ---
  Widget _buildForm(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kDarkBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. THE FIXED PART (does not scroll) ---
              const SizedBox(height: 40), // Space from the container's top edge
              _buildHeaderText(context),
              const SizedBox(height: 20),
              _buildProfileIcon(),
              const SizedBox(height: 20),

              // --- 2. THE SCROLLABLE PART ---
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("NAME", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: 'Jiara Martins'),
                      const SizedBox(height: 20),
                      const Text("EMAIL", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: 'hello@reallygreatsite.com'),
                      const SizedBox(height: 20),
                      const Text("PASSWORD", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: '******', obscureText: true),
                      const SizedBox(height: 20),
                      const Text("CONFIRM PASSWORD",
                          style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: '******', obscureText: true),
                      const SizedBox(height: 30),
                      _buildSignUpButton(),
                      const SizedBox(height: 20),
                      _buildOrDivider(),
                      const SizedBox(height: 20),
                      _buildGoogleButton(),
                      const SizedBox(height: 20), // Bottom padding for scroll
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ALL HELPER WIDGETS BELOW ARE UNCHANGED ---

  Widget _buildHeaderText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Create new Account",
          style: TextStyle(
              color: kWhite, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: kGreyText, fontSize: 14),
            children: [
              const TextSpan(text: "Already Registered? "),
              TextSpan(
                text: 'Log in here.',
                style: const TextStyle(
                    color: kPrimaryBlue, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/login');
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileIcon() {
    return Center(
      child: GestureDetector(
        onTap: () {
          print("Profile icon tapped");
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kGreyText, width: 1.5),
          ),
          child: const Icon(Icons.person_outline, color: kGreyText, size: 30),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: kWhite),
      decoration: InputDecoration(
        fillColor: kTextFieldBackground, // Make sure this color is in colors.dart
        filled: true,
        hintText: hint,
        hintStyle: const TextStyle(color: kGreyText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print("Sign Up button pressed");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 18, color: kWhite),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: kGreyText)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("OR", style: TextStyle(color: kGreyText)),
        ),
        Expanded(child: Divider(color: kGreyText)),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          print("Continue with Google pressed");
        },
        icon: Image.asset('assets/images/google.png', height: 20.0),
        label: const Text(
          'Continue with google',
          style: TextStyle(fontSize: 16, color: kWhite),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: kWhite,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          side: const BorderSide(color: kPrimaryBlue, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}