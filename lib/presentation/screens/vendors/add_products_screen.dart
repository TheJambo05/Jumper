import 'package:flutter/material.dart';

class Don extends StatelessWidget {
  const Don({Key? key});

  static const String routeName = "don";

  // URL of the image
  final String imageUrl = 'http://localhost:5000/api/uploads/1712854725639.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: NetworkImage(imageUrl),
          // Optionally, you can specify width and height constraints
          width: 200, // Adjust according to your UI
          height: 200, // Adjust according to your UI
          // Other properties...
        ),
      ),
    );
  }
}




// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:jumper/logic/services/image_picker.dart';
// import 'package:jumper/presentation/widgets/user/dropdown_textfield.dart';
// import 'package:jumper/presentation/widgets/user/gap_widget.dart';
// import 'package:jumper/presentation/widgets/user/primary_button.dart';
// import 'package:jumper/presentation/widgets/user/primary_textfield.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);

//   static const String routeName = "add_product";

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   String? selectedCategory;
//   String? imagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(
//             parent: AlwaysScrollableScrollPhysics()),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const PrimaryTextField(
//                 labelText: "Product Name",
//               ),
//               const GapWidget(),
//               PrimaryDropdownField(
//                 labelText: "Category",
//                 value: selectedCategory,
//                 items: const [
//                   DropdownMenuItem(
//                     value: "Mens",
//                     child: Text("Mens"),
//                   ),
//                   DropdownMenuItem(
//                     value: "Womens",
//                     child: Text("Womens"),
//                   ),
//                   DropdownMenuItem(
//                     value: "Unisex",
//                     child: Text("Unisex"),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCategory = value;
//                   });
//                 },
//               ),
//               const GapWidget(),
//               const PrimaryTextField(
//                 labelText: "Price",
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final String? imagePath = await ImagePickerHelper.pickImage();
//                   setState(() {
//                     this.imagePath = imagePath;
//                   });
//                 },
//                 child: const Text("Pick Image"),
//               ),
//               if (imagePath != null)
//                 Column(
//                   children: [
//                     const GapWidget(),
//                     // Use a unique key to force the widget to rebuild when the image changes
//                     Image.file(File(imagePath!),
//                         key: UniqueKey()), // This line is crucial
//                   ],
//                 ),
//               const GapWidget(),
//               const PrimaryTextField(
//                 labelText: "Description",
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               PrimaryButton(onPressed: () {}, text: "Log In"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ImagePickerHelper class remains the same
