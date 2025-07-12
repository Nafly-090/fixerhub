import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'colors.dart'; // Import our custom colors

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              _buildForm(context),
              _buildHeaderCircle(context), // Pass context for navigation
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
              const SizedBox(height: 80),
              GestureDetector(
                onTap: () {
                  // Navigate back when "Back" is tapped
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
                      style: TextStyle(color: kWhite, fontSize: 20),
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

  // --- WIDGET for the main sign up form section ---
  Widget _buildForm(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // Using a fraction of the screen height to be more responsive
        height:
        MediaQuery.of(context).size.height * 0.8,
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
              const Spacer(),
              _buildHeaderText(context), // Using a helper for the header text
              const SizedBox(height: 20),
              _buildProfileIcon(), // New widget for the profile icon
              const SizedBox(height: 25),
              const Text("NAME", style: TextStyle(color: kGreyText)),
              const SizedBox(height: 8),
              _buildTextField(hint: 'Jiara Martins'), // New Name field
              const SizedBox(height: 20),
              const Text("EMAIL", style: TextStyle(color: kGreyText)),
              const SizedBox(height: 8),
              _buildTextField(hint: 'hello@reallygreatsite.com'),
              const SizedBox(height: 20),
              const Text("PASSWORD", style: TextStyle(color: kGreyText)),
              const SizedBox(height: 8),
              _buildTextField(hint: '******', obscureText: true),
              const Spacer(),
              _buildSignUpButton(),
              const SizedBox(height: 20),
              _buildOrDivider(),
              const SizedBox(height: 20),
              _buildGoogleButton(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for the "Create new Account" header
  Widget _buildHeaderText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Create new Account",
          style: TextStyle(
            color: kWhite,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
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
                  color: kPrimaryBlue,
                  fontWeight: FontWeight.bold,
                ),
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

  // Helper for the circular profile icon
  Widget _buildProfileIcon() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // TODO: Implement image picker
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

  // Reusable TextField widget
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

  // Helper for the main "Sign Up" button
  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement Sign Up Logic
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

  // Reusable "OR" divider
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

  // Reusable Google button
  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: Implement Google Sign-In
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