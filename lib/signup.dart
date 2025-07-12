import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'colors.dart'; // Import our custom colors

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The Scaffold body is now a Stack. This allows us to layer the
    // scrollable form and the floating header circle.
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          // The form is now the primary widget, and it is scrollable.
          _buildForm(context),

          // The header circle floats on top of the scrollable form.
          _buildHeaderCircle(context),
        ],
      ),
    );
  }

  // --- WIDGET for the top overlapping circle ---
  // This widget is perfect as is. It's positioned relative to the Stack.
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

  // --- WIDGET for the main sign up form (REFACTORED FOR SCROLLING) ---
  Widget _buildForm(BuildContext context) {
    // We return a SingleChildScrollView directly. This is the key change.
    // It allows all the content inside the Column to scroll.
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // This SizedBox creates the empty white space at the top,
          // pushing the dark form container down so it starts below the circle.
          // Adjust this height to control how much the circle overlaps.
          const SizedBox(height: 140),

          // This is our main form container.
          // NOTICE: IT HAS NO FIXED HEIGHT! It will grow as tall as it needs to be.
          Container(
            decoration: const BoxDecoration(
              color: kDarkBlue,
              // The design shows only the top-left corner rounded.
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.0),
                topRight: Radius.circular(60.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              // The content of the form itself.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // This SizedBox creates padding inside the container
                  // to push the title down from the curved edge.
                  const SizedBox(height: 80.0),

                  _buildHeaderText(context),
                  const SizedBox(height: 20),
                  _buildProfileIcon(),
                  const SizedBox(height: 25),

                  // --- All your form fields ---
                  // We use SizedBox for spacing instead of Spacer, because
                  // Spacers don't work well in an infinitely tall scroll view.
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
                  // Your new field fits perfectly now.
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

                  // Add some padding at the very bottom so the last item
                  // doesn't stick to the edge when you scroll.
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- ALL HELPER WIDGETS BELOW ARE UNCHANGED ---
  // They were already well-built.

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
        icon: Image.asset('assets/images/google.png', height: 20.0), // make sure this path is correct
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