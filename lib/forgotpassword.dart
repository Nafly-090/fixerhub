import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'colors.dart'; // This now correctly uses your k-constants file

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetInstructions() {
    // We still keep this check as a final safeguard before submitting.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, show a confirmation and proceed
      print('Sending reset instructions to ${_emailController.text}');

      // Show CherryToast instead of SnackBar
      CherryToast.success(
        title: Text('Success'),
        description: Text('Reset instructions sent to ${_emailController.text}'),
        animationType: AnimationType.fromTop,
        autoDismiss: true,
      ).show(context);

      Navigator.of(context).pop(); // Go back to login screen
    } else {
      print('Form is invalid.');
      // Optionally show an error toast
      CherryToast.error(
        title: Text('Error'),
        description: Text('Form is invalid.'),
        animationType: AnimationType.fromTop,
        autoDismiss: true,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite, // Using your kWhite color
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              _buildTopCircle(context),
              _buildHeaderContent(context),
              _buildFormSheet(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET for the top overlapping circle ---
  Widget _buildTopCircle(BuildContext context) {
    return Positioned(
      top: -80,
      right: -80,
      child: Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          color: kPrimaryBlue,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 40,
              child: IconButton(
                icon: const Icon(Icons.close, color: kWhite, size: 28),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET for the header content (lock icon, title, subtitle) ---
  Widget _buildHeaderContent(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15,
      left: 0,
      right: 0,
      child: Column(
        children: [
          const Icon(Icons.lock, color: kPrimaryBlue, size: 64),
          const SizedBox(height: 24),
          const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: kPrimaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "No worries, we'll send you\nreset instructions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: kTaglineColor,
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET for the main form sheet ---
  Widget _buildFormSheet(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kDarkBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          // MODIFICATION HERE
          child: Form(
            key: _formKey,
            // This line enables real-time validation as the user types.
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 1),
                const Text("Email", style: TextStyle(color: kGreyText, fontSize: 16)),
                const SizedBox(height: 8),
                _buildEmailField(),
                const SizedBox(height: 32),
                _buildResetButton(),
                const SizedBox(height: 24),
                _buildBackToLoginButton(context),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for the Email TextField
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: kWhite),
      decoration: InputDecoration(
        fillColor: kTextFieldBackground,
        filled: true,
        hintText: 'hello@reallygreatsite.com',
        hintStyle: const TextStyle(color: kGreyText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      // This validator logic is now run in real-time thanks to autovalidateMode
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailPattern.hasMatch(value)) {
          return 'Enter a valid email address'; // A slightly more user-friendly message
        }
        return null;
      },
    );
  }

  // Helper widget for the "Reset Password" button
  Widget _buildResetButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _sendResetInstructions,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: const Text(
          'Reset Password',
          style: TextStyle(fontSize: 18, color: kWhite),
        ),
      ),
    );
  }

  // Helper widget for the "Back to Login" text button
  Widget _buildBackToLoginButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          'Back to Login',
          style: TextStyle(
            color: kGreyText,
            fontSize: 16,
            decoration: TextDecoration.underline,
            decorationColor: kGreyText,
          ),
        ),
      ),
    );
  }
}