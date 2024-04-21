import 'package:flutter/material.dart';
import 'package:jumper/presentation/screens/vendors/providers/add_products_provider.dart';
import 'package:jumper/presentation/widgets/user/dropdown_textfield.dart';
import 'package:jumper/presentation/widgets/user/gap_widget.dart';
import 'package:jumper/presentation/widgets/user/primary_button.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';
import 'package:jumper/presentation/widgets/vendor/image_picker';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  static const String routeName = "addProduct";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddProductProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: provider.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Product",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ImagePickerWidget(
                  onImagePicked: provider.setImageFile,
                ),
                const GapWidget(),
                const Text(
                  "Write your product name",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                PrimaryTextField(
                  controller: provider.titleController,
                  labelText: "Name of Product",
                ),
                const GapWidget(),
                const Text(
                  "Select your product Category",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                PrimaryDropdownField(
                  labelText: "Category",
                  value: provider.category,
                  items: const [
                    DropdownMenuItem(value: "Mens", child: Text("Mens")),
                    DropdownMenuItem(value: "Womens", child: Text("Womens")),
                    DropdownMenuItem(value: "Unisex", child: Text("Unisex")),
                  ],
                  onChanged: (String? newValue) {
                    provider.category = newValue;
                  },
                ),
                const GapWidget(),
                const Text(
                  "Describe your Product Here",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                PrimaryTextField(
                  controller: provider.descriptionController,
                  labelText: "Description",
                ),
                const GapWidget(),
                const Text(
                  "Enter the price of your product",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                PrimaryTextField(
                  controller: provider.priceController,
                  labelText: "Price",
                ),
                const GapWidget(),
                Center(
                  child: PrimaryButton(
                    onPressed: provider.isLoading
                        ? null
                        : () {
                            final validationMessage = provider.validateForm();
                            if (validationMessage != null) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Validation Error'),
                                  content: Text(validationMessage),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Dismiss the dialog
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              provider.addProduct();
                            }
                          },
                    text: provider.isLoading ? "Loading..." : "Add Product",
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
