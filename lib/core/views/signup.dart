import "package:flutter/material.dart";

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white10,
        elevation: 2,
        child: SizedBox(
          width: 350,
          height: 400,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                            labelText: "FirstName", icon: Icons.person),
                      )),
                      SizedBox(width: 20),
                      Expanded(
                          child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: _buildInputDecoration(
                          labelText: "LastName",
                          icon: Icons.person,
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: _buildInputDecoration(
                          labelText: "Email", icon: Icons.email)),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: _buildInputDecoration(
                        labelText: "Password", icon: Icons.password_sharp),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.transparent,
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('SIGN UP'),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
        ),
      )),
    );
  }
}

InputDecoration _buildInputDecoration(
    {required String labelText, required IconData icon}) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(icon),
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
