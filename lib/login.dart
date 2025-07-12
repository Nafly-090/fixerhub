import 'package:fixerhub/wellcome.dart';
import 'package:flutter/material.dart';
import 'colors.dart'; // Import our custom colors
import 'package:flutter/gestures.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    // Add listeners for real-time validation
    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validate all fields in real-time
  void _validateFields() {
    setState(() {
      // Validate EMAIL
      final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      _emailError = _emailController.text.isEmpty
          ? 'Email is required'
          : !emailPattern.hasMatch(_emailController.text)
          ? 'Enter a valid email'
          : null;

      // Validate PASSWORD
      final passwordPattern = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$');
      _passwordError = _passwordController.text.isEmpty
          ? 'Password is required'
          : !passwordPattern.hasMatch(_passwordController.text)
          ? 'Password must be at least 8 characters, \ninclude an uppercase letter and a special symbol'
          : null;
    });
  }

  // Check if all fields are valid
  bool _isFormValid() {
    return _emailError == null &&
        _passwordError == null &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

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
              const SizedBox(height: 80),
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
        height: 650,
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
              _buildTextField(
                hint: 'hello@reallygreatsite.com',
                controller: _emailController,
                errorText: _emailError,
              ),
              const SizedBox(height: 20),
              const Text("PASSWORD", style: TextStyle(color: kGreyText)),
              const SizedBox(height: 8),
              _buildTextField(
                hint: '******',
                obscureText: true,
                controller: _passwordController,
                errorText: _passwordError,
              ),
              const SizedBox(height: 30),
              _buildLoginButton(),
              const SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: () {
                    print("Forgot Password tapped");
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: kGreyText, fontSize: 14),
                  ),
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
  Widget _buildTextField({
    required String hint,
    bool obscureText = false,
    TextEditingController? controller,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
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
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
    );
  }

  // Helper widget for the main Login button
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _validateFields(); // Re-validate all fields
          if (!_isFormValid()) {
            return; // Prevent submission if any field is invalid
          }
          // Proceed with login logic
          print("Login button pressed with valid data");
          print("Email: ${_emailController.text}");
          print("Password: ${_passwordController.text}");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: const Text(
          'Login',
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