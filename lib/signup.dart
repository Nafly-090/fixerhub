import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'colors.dart'; // Make sure you have this file with your color constants

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  XFile? _selectedImage; // Variable to store the selected image
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    // Add listeners for real-time validation
    _nameController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
    _confirmPasswordController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Validate all fields in real-time
  void _validateFields() {
    setState(() {
      autovalidateMode: AutovalidateMode.onUserInteraction;
      // Validate NAME
      _nameError = _nameController.text.isEmpty ? 'Name is required' : null;

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
          ? 'Password must be at least 8 characters,\ninclude an uppercase letter and a special symbol'
          : null;

      // Validate CONFIRM PASSWORD
      _confirmPasswordError = _confirmPasswordController.text.isEmpty
          ? 'Confirm password is required'
          : !passwordPattern.hasMatch(_confirmPasswordController.text)
          ? 'Confirm password must be at least 8 characters, include an uppercase letter and a special symbol'
          : _passwordController.text != _confirmPasswordController.text
          ? 'Passwords do not match'
          : null;
    });
  }

  // Check if all fields are valid
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

  // --- WIDGET for the top overlapping circle ---
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
              const SizedBox(height: 40),
              _buildHeaderText(context),
              const SizedBox(height: 20),
              _buildProfileIcon(),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("NAME", style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hint: 'Jiara Martins',
                        controller: _nameController,
                        errorText: _nameError,
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      const Text("CONFIRM PASSWORD",
                          style: TextStyle(color: kGreyText)),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hint: '******',
                        obscureText: true,
                        controller: _confirmPasswordController,
                        errorText: _confirmPasswordError,
                      ),
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

  // --- ALL HELPER WIDGETS BELOW ---
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
        onTap: _pickImage,
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kGreyText, width: 1.5),
            image: _selectedImage != null
                ? DecorationImage(
              image: FileImage(File(_selectedImage!.path)),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: _selectedImage == null
              ? const Icon(Icons.person_outline, color: kGreyText, size: 30)
              : null,
        ),
      ),
    );
  }

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

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _validateFields(); // Re-validate all fields
          if (!_isFormValid()) {
            return; // Prevent submission if any field is invalid
          }
          // Proceed with sign-up logic
          print("Sign Up button pressed with valid data");
          print("Name: ${_nameController.text}");
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