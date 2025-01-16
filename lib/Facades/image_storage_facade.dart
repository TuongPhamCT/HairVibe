import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorageFacade {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<XFile?> pickImage() async {
    // Chọn ảnh từ thư viện
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    return pickedFile;
  }

  Future<String?> uploadImage(String folderName, File file) async {
    try {
        // Tham chiếu Firebase Storage
        Reference ref = _storage
            .ref()
            .child("$folderName/${DateTime.now().millisecondsSinceEpoch}.jpg");

        // Upload ảnh
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot snapshot = await uploadTask;

        // Lấy URL sau khi upload
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // Upload ảnh lên Firebase Storage và trả về URL
  Future<String?> pickAndUploadImage(String folderName) async {
    final XFile? pickedFile = await pickImage();

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      return await uploadImage(folderName, file);
    } else {
      print("No image selected.");
      return null;
    }
  }

  // Xóa ảnh khỏi Firebase Storage
  Future<void> deleteImage(String imageUrl) async {
    try {
      // Xóa ảnh từ Storage
      await _storage.ref(imageUrl).delete();
      print("Image deleted from Storage.");
    } catch (e) {
      print("Error deleting image: $e");
    }
  }
}

abstract class StorageFolderNames {
  static const String BARBER_IMAGES = "barberImages";
}