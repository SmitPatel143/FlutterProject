import "package:flutter/material.dart";
import "package:flutter_project/core/controllers/category_controller.dart";
import "package:flutter_project/core/views/quiz.dart";
import "package:get/get.dart";
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CategoryAdd extends StatelessWidget {
  const CategoryAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final CategoryController categoryController =
        Get.find<CategoryController>();

    if (categoryController.isLoading.value) {
      return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black,
          size: 50,
        ),
      );
    }
    ;

    return Scaffold(
      body: Center(
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
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  const SizedBox(height: 30),
                  Obx(() {
                    final categoryDetails = categoryController.availableCategory;
                    return DropdownButtonFormField(
                      value: categoryDetails.isNotEmpty
                          ? categoryDetails[0]
                          : null,
                      onSaved: (value) =>
                          categoryController.selectedCategory.value = value!,
                      decoration: InputDecoration(
                        labelText: "Category",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Required Field";
                        }
                        return null;
                      },
                      items: categoryDetails
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        categoryController.selectedCategory.value = value!;
                      },
                    );
                  }),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Get.to(() => Quiz(), arguments: {
                            "selectedCategory":
                                categoryController.selectedCategory.value
                          });
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
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Next"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
