import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../serves/auth_service.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isConfirmPasswordVisible = false;
  String? _errorMessage;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Registration method
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      // If form is not valid, return
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authProvider.notifier).register(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => _errorMessage = "Registration failed: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Set the form key for validation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Name TextFormField with validation
                TextFormField(
                  controller: _firstNameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Center(
                      child: Text("First name"),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Center(
                      child: Text("Last name"),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Center(
                      child: Text("Email"),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Simple email format
                    if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Center(
                      child: Text("Password"),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 10) {
                      return 'Password must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  textAlign: TextAlign.center,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    label: const Center(child: Text("Confirm Password")),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons
                        .visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible =
                      !_isConfirmPasswordVisible;
                    });
                  },
                ),

                if (_errorMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(_errorMessage!, style: TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _register,
                  child: const Text("Register"),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text("Back to login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
