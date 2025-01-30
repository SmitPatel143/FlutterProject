import "package:flutter/material.dart";
import "package:flutter_project/core/controllers/category_controller.dart";
import "package:get/get.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryAdd extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CategoryAdd({super.key}) {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      _loadInitialData();
    });
  }

  void _loadInitialData() async {
    try {
      isLoading.value = true;
      categoryController.availableCategory;
    } finally {
      isLoading.value = false;
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
                    heightFactor: 30,
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white10,
                      elevation: 2,
                      child: Container(
                          height: 250,
                          width: 300,
                          padding: const EdgeInsets.all(20),
                          child: Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Step-1: Category",
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
                                  Obx(() {
                                    final categoryDetails =
                                        categoryController.availableCategory;
                                    isLoading = ValueNotifier(false);
                                    return DropdownButtonFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          labelText: "Category",
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          )),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        print(value);
                                        if (value == null || value.isEmpty) {
                                          return "Required Field";
                                        }
                                        return null;
                                      },
                                      items: categoryDetails
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      elevation: 0,
                                      onChanged: (value) {},
                                    );
                                  }),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {

                                          }
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
