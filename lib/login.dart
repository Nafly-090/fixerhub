import 'package:fixerhub/wellcome.dart';
import 'package:flutter/material.dart';
import 'colors.dart'; // Import our custom colors
import 'package:flutter/gestures.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a SingleChildScrollView to prevent overflow when keyboard appears
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: SizedBox(
          // Set a height that is at least the screen height
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // The main content of the form
              _buildForm(context),

              // The overlapping header circle
              _buildHeaderCircle(context),
            ],
          ),
        ),
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
              const SizedBox(height: 80), // Adjust spacing from the top edge
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20), // Adjust icon position
                    Icon(Icons.arrow_back, color: kWhite, size: 20),
                    SizedBox(width: 5),
                    Text(
                      'Back',
                      style: TextStyle(color: kWhite, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const Text(
                'Login',
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

  // --- WIDGET for the main login form section ---
  Widget _buildForm(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height:
        650, // Fixed height, adjust as needed or use a fraction of screen height
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kDarkBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),
              const Text(
                "Login",
                style: TextStyle(
                    color: kWhite, fontSize: 36, fontWeight: FontWeight.bold),
              ), 
            RichText(
              text: TextSpan(
                style: const TextStyle(color: kGreyText, fontSize: 14),
                children: [
                  const TextSpan(text: "Don't have an account "),
                  TextSpan(
                    text: 'Sign Up here.',
                    style: const TextStyle(
                      color: kPrimaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/signup');
                      },
                  ),
                ],
              ),
            ),
              const Spacer(flex: 1),
              const Text("EMAIL", style: TextStyle(color: kGreyText)),
              const SizedBox(height: 8),
              _buildTextField(hint: 'hello@reallygreatsite.com'),
              const SizedBox(height: 20),
              const Text("PASSWORD", style: TextStyle(color: kGreyText)),
              const SizedBox(height: 8),
              _buildTextField(hint: '******', obscureText: true),
              const SizedBox(height: 30),
              _buildLoginButton(),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: kGreyText, fontSize: 14),
                ),
              ),
              const Spacer(flex: 1),
              _buildOrDivider(),
              const Spacer(flex: 1),
              _buildGoogleButton(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for TextFields to reduce repetition
  Widget _buildTextField({required String hint, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: kWhite),
      decoration: InputDecoration(
        fillColor: kTextFieldBackground,
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

  // Helper widget for the main Login button
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement Login Logic
          print("Login button pressed");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: const Text(
          'Login', // Changed from "Sign Up" to "Login" for logical consistency
          style: TextStyle(fontSize: 18, color: kWhite),
        ),
      ),
    );
  }

  // Helper widget for the "OR" divider
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

  // Helper widget for the "Continue with Google" button
  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: Implement Google Sign-In
          print("Continue with Google pressed");
        },
        icon: Image.asset(
          'assets/images/google.png',
          height: 20.0,
        ),
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