import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }
}


// Future<void> pickImage() async {
//   try {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         imagePath = image.path;
//       });
//     } else {
//       // User canceled the picker
//       print("No image selected.");
//     }
//   } catch (e) {
//     print("Failed to pick image: $e");
//   }
// }
