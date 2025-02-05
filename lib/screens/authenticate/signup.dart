import "package:flutter/material.dart";
import "package:flutter_project/service/auth_service.dart";
import "package:get/get.dart";

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 130, horizontal: 30),
              child: LayoutBuilder(builder: (context, constraints) {
                double maxWidth = constraints.maxWidth > 600 ? 500 : 300;
                return Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white10,
                  elevation: 2,
                  child: Container(
                    width: maxWidth,
                    constraints: const BoxConstraints(minHeight: 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 14),
                      child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  TextFormField(
                                    controller: _firstNameController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: _buildInputDecoration(
                                      labelText: "FirstName",
                                      icon: Icons.person,
                                    ),
                                    validator: (value) {
                                      value = (value ?? '');
                                      if (value.isEmpty) {
                                        return 'First name is required';
                                      } else if (value.length < 2) {
                                        return 'First name must be at least 2 characters';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _lastNameController,
                                    style: const TextStyle(color: Colors.black),
                                    validator: (value) {
                                      value = (value ?? '');
                                      if (value.isEmpty) {
                                        return 'Last name is required';
                                      } else if (value.length < 2) {
                                        return 'Last name must be at least 2 characters';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: _buildInputDecoration(
                                      labelText: "LastName",
                                      icon: Icons.person,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.black),
                                validator: (value) {
                                  value = value ?? '';
                                  if (value.isEmpty) {
                                    return 'Email is required';
                                  } else if (!GetUtils.isEmail(value)) {
                                    return 'Please enter a valid email';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: _buildInputDecoration(
                                  labelText: "Email",
                                  icon: Icons.email,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  value = value ?? '';
                                  if (value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: _buildInputDecoration(
                                  labelText: "Password",
                                  icon: Icons.password_sharp,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        auth.signUpWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            onSuccess: (success) {
                                              Get.snackbar("success",
                                                  success.toString());
                                            },
                                            onError: (error) {
                                              Get.snackbar(
                                                  "Error", error.toString());
                                            });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white30,
                                      foregroundColor: Colors.blue,
                                      shadowColor: Colors.transparent,
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("SIGN UP"),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Icon(
                                            Icons.arrow_forward,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await auth.signInWitGoogle(onSuccess: (success) {
                                    Get.snackbar("success", success.toString());
                                  }, onError: (error) {
                                    Get.snackbar("Error", error.toString());
                                  });
                                },
                                child: SizedBox(
                                  width: 250,
                                  height: 50,
                                  child: Card(
                                    shadowColor: Colors.grey,
                                    color: Colors.white,
                                    surfaceTintColor: Colors.white10,
                                    elevation: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Image.asset(
                                            'assets/images/google_logo.png',
                                            // Make sure to add this to your pubspec.yaml
                                            height: 24,
                                            width: 24,
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black87),
                                              "Sign up with Google",
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )),
                    ),
                  ),
                );
              })),
        )));
  }
}

InputDecoration _buildInputDecoration(
    {required String labelText, required IconData icon, String? errorText}) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(icon),
    errorText: errorText,
    labelStyle: TextStyle(color: Colors.black),
    errorStyle: TextStyle(color: Colors.red),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
