import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jumper/logic/cubits/product_cubit/product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/product_cubit/product_state.dart';

class AddProductProvider with ChangeNotifier {
  final BuildContext context;
  AddProductProvider(this.context) {
    _listenToProductCubit();
  }

  bool isLoading = false;
  String error = "";
  String? category;
  File? imageFile;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  StreamSubscription? _productSubscription;

  void _listenToProductCubit() {
    _productSubscription = BlocProvider.of<ProductCubit>(context).stream.listen(
      (productState) {
        if (productState is ProductLoadingState) {
          isLoading = true;
          error = "";
        } else if (productState is ProductErrorState) {
          isLoading = false;
          error = productState.message;
        } else if (productState is ProductAddedState) {
          isLoading = false;
          resetForm();
          showMessage("Product successfully added!");
        } else {
          isLoading = false;
        }
        notifyListeners();
      },
    );
  }

  void setImageFile(File newFile) {
    imageFile = newFile;
    notifyListeners();
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    category = null;
    imageFile = null;
    formKey.currentState?.reset();
    notifyListeners();
  }

  void addProduct() {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();

    String category = this.category ?? "";
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String price = priceController.text.trim();

    BlocProvider.of<ProductCubit>(context).addProduct(
      category: category,
      title: title,
      description: description,
      price: price,
      imageFile: imageFile,
    );
  }

  String? validateForm() {
    if (imageFile == null) return "Please upload an image for the product.";
    if (titleController.text.trim().isEmpty) {
      return "Please enter the name of the product.";
    }
    if (category == null || category!.isEmpty) {
      return "Please select a category for the product.";
    }
    if (descriptionController.text.trim().isEmpty) {
      return "Please provide a description for the product.";
    }
    if (priceController.text.trim().isEmpty) {
      return "Please enter the price of the product.";
    }
    final price = double.tryParse(priceController.text.trim());
    if (price == null) return "Price must be a valid number.";
    return null; // If all validations pass
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _productSubscription?.cancel();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
