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
        } else {
          isLoading = false;
          error = "";
        }
        notifyListeners();
      },
    );
  }

  void setImageFile(File newFile) {
    imageFile = newFile;
    notifyListeners();
  }

  void addProduct() async {
    if (!formKey.currentState!.validate()) return;

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

  @override
  void dispose() {
    _productSubscription?.cancel();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
