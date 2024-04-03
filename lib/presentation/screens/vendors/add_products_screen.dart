import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jumper/presentation/screens/auth/login_screen.dart';
import 'package:jumper/presentation/screens/auth/providers/signup_provider.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static const String routeName = "add_Product";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PrimaryTextField(
        labelText: "Sandip",
        obscureText: true,
      ),
    );
  }
}
//     final provider = Provider.of<AddProductProvider>(context);
//     return Scaffold(
//       body: SafeArea(
//         child: Form(
//           key: provider.formKey, // Using form key for form validation
//           child: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//               child: Column(
//                 children: [
//                   const Text("Jumper"),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.02,
//                   ),
//                   const Row(
//                     children: [
//                       Text(
//                         "Add Product",
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.02,
//                   ),
//                   PrimaryTextField(
//                     controller: provider.titleController,
//                     labelText: "Name of Product",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.02,
//                   ),
//                   PrimaryTextField(
//                     // Text field for password input
//                     controller: provider.descriptionController,

//                     labelText: "Description",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.02,
//                   ),
//                   PrimaryTextField(
//                     // Text field for password input
//                     controller: provider.priceController,
//                     labelText: "Price",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.03,
//                   ),
//                   LoginButton(
//                     // Button for login action
//                     onPressed: provider.addProduct,
//                     text: (provider.isLoading) ? "..." : "Add Product",
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.04,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }