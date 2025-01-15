import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorageFacade {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload ảnh lên Firebase Storage và trả về URL
  Future<String?> uploadImage(String folderName) async {
    try {
      // Chọn ảnh từ thư viện
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File file = File(pickedFile.path);

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
      } else {
        print("No image selected.");
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
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