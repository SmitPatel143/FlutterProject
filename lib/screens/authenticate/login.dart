import "package:flutter/material.dart";
import "package:flutter_project/core/services/api_service.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? emailValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? passwordValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      authService.loginUser(_emailController.text, _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Processing Login for ${_emailController.text}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            elevation: 20,
            color: Color.fromRGBO(40, 40, 40, 1.0),
            child: SizedBox(
                width: 300, // Specify desired width
                height: 400,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: _emailController,
                              validator: emailValidation,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white),
                              decoration: _buildInputDecoration(
                                labelText: 'Email',
                                icon: Icons.email,
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              validator: passwordValidation,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: _buildInputDecoration(
                                  labelText: 'Password',
                                  icon: Icons.lock,
                                  isPassword: true),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: 200, // Set desired width
                              child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  textStyle: TextStyle(fontSize: 16),
                                ),
                                child: Text('Login'),
                              ),
                            ),
                            SizedBox(height: 5),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.white70),
                                )),
                          ]),
                    )))));
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon, color: Colors.white),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            )
          : null,
      labelStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.red),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white54, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
