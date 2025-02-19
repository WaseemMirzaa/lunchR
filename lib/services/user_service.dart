import 'package:firebase_auth/firebase_auth.dart';
import 'package:luncher/models/user_model.dart';
import 'package:luncher/config/app_const.dart';
import 'base_service.dart';

class UserService extends BaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser(UserModel user) async {
    // Get the currently authenticated user's UID
    String? userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not authenticated");
    }

    // Ensure the user model contains the correct userID
    final updatedUser = UserModel(
      userID: userId, // Set userID as Firebase Auth UID
      phoneNumber: user.phoneNumber,
      role: user.role,
      userAccountCreatedTime: user.userAccountCreatedTime,
    );

    // Store user data in Firestore with UID as the document ID
    await createDocument(
      CollectionKey.USER_COLLECTION,
      userId,
      updatedUser.toJson(),
    );
  }
}
