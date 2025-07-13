import 'dart:async';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'colors.dart'; // Ensure this file exists with your color constants

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isLoading = false; // Loading state for sign-up button
  Timer? _debounce; // Debounce timer for validation

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
    _confirmPasswordController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateFields() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _nameError = _nameController.text.isEmpty ? 'Name is required' : null;
        final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        _emailError = _emailController.text.isEmpty
            ? 'Email is required'
            : !emailPattern.hasMatch(_emailController.text)
            ? 'Enter a valid email'
            : null;
        final passwordPattern = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}$');
        _passwordError = _passwordController.text.isEmpty
            ? 'Password is required'
            : !passwordPattern.hasMatch(_passwordController.text)
            ? 'Password must be at least 8 characters,\ninclude an uppercase letter and a special symbol'
            : null;
        _confirmPasswordError = _confirmPasswordController.text.isEmpty
            ? 'Confirm password is required'
            : !passwordPattern.hasMatch(_confirmPasswordController.text)
            ? 'Confirm password must be at least 8 characters,\ninclude an uppercase letter and a special symbol'
            : _passwordController.text != _confirmPasswordController.text
            ? 'Passwords do not match'
            : null;
      });
    });
  }

  bool _isFormValid() {
    return _nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Stack(
        children: [
          _buildForm(context),
          _buildHeaderCircle(context),
        ],
      ),
    );
  }

  Widget _buildHeaderCircle(BuildContext context) {
    return Positioned(
      top: -45,
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
                    Text('Back', style: TextStyle(color: kWhite, fontSize: 20)),
                  ],
                ),
              ),
              const Text(
                'Sign Up',
                style: TextStyle(color: kWhite, fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              const SizedBox(height: 40),
              _buildHeaderText(context),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("NAME", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: 'Jiara Martins', controller: _nameController, errorText: _nameError),
                      const SizedBox(height: 20),
                      const Text("EMAIL", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: 'hello@reallygreatsite.com', controller: _emailController, errorText: _emailError),
                      const SizedBox(height: 20),
                      const Text("PASSWORD", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: '******', obscureText: true, controller: _passwordController, errorText: _passwordError),
                      const SizedBox(height: 20),
                      const Text("CONFIRM PASSWORD", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(hint: '******', obscureText: true, controller: _confirmPasswordController, errorText: _confirmPasswordError),
                      const SizedBox(height: 30),
                      _buildSignUpButton(),
                      const SizedBox(height: 20),
                      _buildOrDivider(),
                      const SizedBox(height: 20),
                      _buildGoogleButton(),
                      const SizedBox(height: 20),
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

  Widget _buildHeaderText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Create new Account", style: TextStyle(color: kWhite, fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: kGreyText, fontSize: 14),
            children: [
              const TextSpan(text: "Already Registered? "),
              TextSpan(
                text: 'Log in here.',
                style: const TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({required String hint, bool obscureText = false, TextEditingController? controller, String? errorText}) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isObscured = obscureText;
        return TextField(
          controller: controller,
          obscureText: isObscured,
          style: const TextStyle(color: kWhite),
          decoration: InputDecoration(
            fillColor: kTextFieldBackground,
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(color: kGreyText),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            errorText: errorText,
            errorStyle: const TextStyle(color: Colors.redAccent),
            suffixIcon: obscureText
                ? IconButton(
              icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off, color: kGreyText),
              onPressed: () => setState(() => isObscured = !isObscured),
            )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () async {
          setState(() => _isLoading = true);
          _validateFields();
          if (!_isFormValid()) {
            setState(() => _isLoading = false);
            CherryToast.error(
              title: const Text('Error'),
              description: const Text('Please fix the errors in the form'),
              animationDuration: const Duration(milliseconds: 500),
              autoDismiss: true,
            ).show(context);
            return;
          }
          try {
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
            await userCredential.user?.updateDisplayName(_nameController.text.trim());
            CherryToast.success(
              title: const Text('Success'),
              description: Text('Account created for ${_emailController.text}'),
              animationDuration: const Duration(milliseconds: 500),
              autoDismiss: true,
            ).show(context);
            Navigator.pushReplacementNamed(context, '/login');
          } catch (e) {
            CherryToast.error(
              title: const Text('Error'),
              description: Text('Failed to create account: ${e.toString()}'),
              animationDuration: const Duration(milliseconds: 500),
              autoDismiss: true,
            ).show(context);
          } finally {
            setState(() => _isLoading = false);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryBlue,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: kWhite)
            : const Text('Sign Up', style: TextStyle(fontSize: 18, color: kWhite)),
      ),
    );
  }

  Widget _buildOrDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: kGreyText)),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("OR", style: TextStyle(color: kGreyText))),
        Expanded(child: Divider(color: kGreyText)),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _isLoading
            ? null
            : () async {
          setState(() => _isLoading = true);
          try {
            // Use singleton instance and initialize
            final GoogleSignIn googleSignIn = GoogleSignIn();
            final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
            if (googleUser == null) {
              // User canceled the sign-in
              setState(() => _isLoading = false);
              return;
            }

            // Obtain auth details
            final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

            // Create Firebase credential
            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            // Sign in to Firebase
            final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

            // Show success toast
            CherryToast.success(
              title: const Text('Success'),
              description: Text('Signed in as ${userCredential.user?.displayName ?? 'User'}'),
              animationDuration: const Duration(milliseconds: 500),
              autoDismiss: true,
            ).show(context);

            // Navigate to home screen
            Navigator.pushReplacementNamed(context, '/home');
          } catch (e) {
            // Show error toast
            CherryToast.error(
              title: const Text('Error'),
              description: Text('Google Sign-In failed: ${e.toString()}'),
              animationDuration: const Duration(milliseconds: 500),
              autoDismiss: true,
            ).show(context);
          } finally {
            setState(() => _isLoading = false);
          }
        },
        icon: Image.asset('assets/images/google.png', height: 20.0),
        label: const Text(
          'Continue with Google',
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