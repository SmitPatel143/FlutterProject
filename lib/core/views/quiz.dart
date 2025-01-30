import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter_project/core/controllers/category_controller.dart";
import "package:get/get.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Quiz extends StatelessWidget {
  // final CategoryController categoryController = Get.put(CategoryController());
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Quiz({super.key}) {
    // Future.delayed(const Duration(milliseconds: 3000), () async {
    //   _loadInitialData();
    // });
  }

  void _loadInitialData() async {
    try {
      // isLoading.value = true;
      // categoryController.availableCategory;
    } finally {
      // isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, value, child) {
          return Scaffold(
            body: value
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.black,
                      size: 50,
                    ),
                  )
                : Center(
                    child: Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white10,
                    elevation: 0,
                    child: Container(
                        height: 400,
                        width: 350,
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Step-2: Quiz",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Obx(() {
                                //   isLoading = ValueNotifier(false);
                                DropdownButtonFormField(
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      labelText: "Category",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      )),
                                  items: [],
                                  onChanged: (value) {},
                                  elevation: 0,
                                ),
                                // }),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .validate()) {}
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.blue,
                                        shadowColor: Colors.transparent,
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text("Next"),
                                    )),
                              ],
                            ))),
                  )),
          );
        });
  }
}
