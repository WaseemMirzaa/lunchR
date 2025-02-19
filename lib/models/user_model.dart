import 'package:luncher/config/app_const.dart';

class UserModel {
  final String? userID;
  final String? phoneNumber;
  final String? role;
  final DateTime? userAccountCreatedTime;

  UserModel({
    this.userID,
    this.phoneNumber,
    this.role,
    this.userAccountCreatedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      UserKey.USER_ID: userID,
      UserKey.PHONE_NUMBER: phoneNumber,
      UserKey.ROLE: role,
      UserKey.USER_ACCOUNT_CREATED_TIME:
          userAccountCreatedTime?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json[UserKey.USER_ID] as String?,
      phoneNumber: json[UserKey.PHONE_NUMBER] as String?,
      role: json[UserKey.ROLE] as String?,
      userAccountCreatedTime: json[UserKey.USER_ACCOUNT_CREATED_TIME] != null
          ? DateTime.tryParse(json[UserKey.USER_ACCOUNT_CREATED_TIME])
          : null,
    );
  }
}
