import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/logic/cubits/category_cubit/category_cubit.dart';
import 'package:jumper/logic/cubits/category_cubit/category_state.dart';
import 'package:jumper/presentation/screens/vendors/providers/add_products_provider.dart';
import 'package:jumper/presentation/widgets/user/dropdown_textfield.dart';
import 'package:jumper/presentation/widgets/user/primary_button.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

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
          key: provider.formKey, // Using form key for form validation
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Add Product",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                    return DropDownTextField(
                        labelText: "Category", categories: state.categories);
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  PrimaryTextField(
                    controller: provider.titleController,
                    labelText: "Name of Product",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  PrimaryTextField(
                    // Text field for password input
                    controller: provider.descriptionController,

                    labelText: "Description",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  PrimaryTextField(
                    // Text field for password input
                    controller: provider.priceController,
                    labelText: "Price",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  PrimaryButton(
                    // Button for login action
                    onPressed: provider.addProduct,
                    text: (provider.isLoading) ? "..." : "Add Product",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
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
