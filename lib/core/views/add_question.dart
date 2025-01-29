import 'package:flutter/material.dart';

class AddQuestions extends StatelessWidget {
  AddQuestions({super.key});

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode? _autoValidateMode;

  setState(){
    print("Inside the setState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 30),
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white10,
              elevation: 2,
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidateMode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Add Question",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        minLines: 1,

                        maxLines: 3,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          value = value ?? ''.trim();
                          if (value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: _buildInputDecoration(
                          labelText: "Enter your question",
                          icon: Icons.question_answer,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: (value) {
                          value = value ?? ''.trim();
                          if (value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: _buildInputDecoration(
                          labelText: "Option-1",
                          icon: Icons.edit_note_outlined,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: (value) {
                          value = value ?? ''.trim();
                          if (value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: _buildInputDecoration(
                          labelText: "Option-2",
                          icon: Icons.edit_note_outlined,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: (value) {
                          value = value ?? ''.trim();
                          if (value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: _buildInputDecoration(
                          labelText: "Option-3",
                          icon: Icons.edit_note_outlined,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: (value) {
                          value = value ?? ''.trim();
                          if (value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: _buildInputDecoration(
                          labelText: "Option-4",
                          icon: Icons.edit_note_outlined,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          int? number = int.tryParse(value);
                          if (number == null) {
                            return "Please enter a valid number";
                          } else if (number < 1 || number > 4) {
                            return "Index must be in between 1 and 4";
                          }
                          return null;
                        },
                        decoration: _buildInputDecoration(
                          labelText: "Correct-option-index",
                          icon: Icons.edit_note_outlined,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                              } else {
                                _autoValidateMode =
                                    AutovalidateMode.onUserInteraction;

                              }
                            },
                            child: Text("Submit")),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
