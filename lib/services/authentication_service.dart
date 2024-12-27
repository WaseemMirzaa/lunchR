import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async'; // Import for Completer

class AuthenticationService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Handle phone number authentication
  Future<Result> authenticatePhoneNumber(String phoneNumber) async {
    final Completer<Result> completer =
        Completer<Result>(); // Create a Completer to handle async results

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            completer
                .complete(Result.success(message: "Verification completed"));
          } catch (e) {
            completer
                .complete(Result.error("Failed to sign in with credentials"));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.complete(Result.error(e.message ?? "Verification failed"));
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(Result.success(
              message: "Code sent", verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          completer.complete(Result.success(
              message: "Timeout", verificationId: verificationId));
        },
      );

      // Return the result once verification process completes (either success or failure)
      return completer.future;
    } catch (e) {
      return Result.error("An error occurred. Please try again.");
    }
  }

  // Verify OTP and complete the authentication
  Future<Result> verifyOTP(String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in the user with the credential
      await _auth.signInWithCredential(credential);
      return Result.success(message: "OTP verification successful");
    } catch (e) {
      return Result.error("Invalid OTP. Please try again.");
    }
  }
}

class Result {
  final bool success;
  final String message;
  final String? verificationId;

  Result.success({this.message = 'Success', this.verificationId})
      : success = true;
  Result.error(this.message)
      : success = false,
        verificationId = null;
}
