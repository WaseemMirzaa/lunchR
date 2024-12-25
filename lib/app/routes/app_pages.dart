import 'package:get/get.dart';

import '../modules/cafeteria/bindings/cafeteria_binding.dart';
import '../modules/cafeteria/views/cafeteria_view.dart';
import '../modules/cafeteria_child_verification/bindings/cafeteria_child_verification_binding.dart';
import '../modules/cafeteria_child_verification/views/cafeteria_child_verification_view.dart';
import '../modules/cafeteria_child_verification_home/bindings/cafeteria_child_verification_home_binding.dart';
import '../modules/cafeteria_child_verification_home/views/cafeteria_child_verification_home_view.dart';
import '../modules/cafeteria_detail/bindings/cafeteria_detail_binding.dart';
import '../modules/cafeteria_detail/views/cafeteria_detail_view.dart';
import '../modules/cafeteria_history/bindings/cafeteria_history_binding.dart';
import '../modules/cafeteria_history/views/cafeteria_history_view.dart';
import '../modules/cafeteria_history_details/bindings/cafeteria_history_details_binding.dart';
import '../modules/cafeteria_history_details/views/cafeteria_history_details_view.dart';
import '../modules/cafeteria_history_list/bindings/cafeteria_history_list_binding.dart';
import '../modules/cafeteria_history_list/views/cafeteria_history_list_view.dart';
import '../modules/cafeteria_history_select_date/bindings/cafeteria_history_select_date_binding.dart';
import '../modules/cafeteria_history_select_date/views/cafeteria_history_select_date_view.dart';
import '../modules/cafeteria_landing_page/bindings/cafeteria_landing_page_binding.dart';
import '../modules/cafeteria_landing_page/views/cafeteria_landing_page_view.dart';
import '../modules/cafeteria_meal_details/bindings/cafeteria_meal_details_binding.dart';
import '../modules/cafeteria_meal_details/views/cafeteria_meal_details_view.dart';
import '../modules/cafeteria_menu_page/bindings/cafeteria_menu_page_binding.dart';
import '../modules/cafeteria_menu_page/views/cafeteria_menu_page_view.dart';
import '../modules/cafeteria_phone_authenication/bindings/cafeteria_phone_authenication_binding.dart';
import '../modules/cafeteria_phone_authenication/views/cafeteria_phone_authenication_view.dart';
import '../modules/cafeteria_phone_verification/bindings/cafeteria_phone_verification_binding.dart';
import '../modules/cafeteria_phone_verification/views/cafeteria_phone_verification_view.dart';
import '../modules/child_verification_upload_info/bindings/child_verification_upload_info_binding.dart';
import '../modules/child_verification_upload_info/views/child_verification_upload_info_view.dart';
import '../modules/children_details/bindings/children_details_binding.dart';
import '../modules/children_details/views/children_details_view.dart';
import '../modules/email_verification/bindings/email_verification_binding.dart';
import '../modules/email_verification/views/email_verification_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/home_settings/bindings/home_settings_binding.dart';
import '../modules/home_settings/views/home_settings_view.dart';
import '../modules/landing_page/bindings/landing_page_binding.dart';
import '../modules/landing_page/views/landing_page_view.dart';
import '../modules/menu_page/bindings/menu_page_binding.dart';
import '../modules/menu_page/views/menu_page_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/parent_name/bindings/parent_name_binding.dart';
import '../modules/parent_name/views/parent_name_view.dart';
import '../modules/parents_children_details/bindings/parents_children_details_binding.dart';
import '../modules/parents_children_details/views/parents_children_details_view.dart';
import '../modules/parents_history/bindings/parents_history_binding.dart';
import '../modules/parents_history/views/parents_history_view.dart';
import '../modules/parents_history_details/bindings/parents_history_details_binding.dart';
import '../modules/parents_history_details/views/parents_history_details_view.dart';
import '../modules/parents_history_list/bindings/parents_history_list_binding.dart';
import '../modules/parents_history_list/views/parents_history_list_view.dart';
import '../modules/parents_history_select_date/bindings/parents_history_select_date_binding.dart';
import '../modules/parents_history_select_date/views/parents_history_select_date_view.dart';
import '../modules/parents_home/bindings/parents_home_binding.dart';
import '../modules/parents_home/views/parents_home_view.dart';
import '../modules/phone_authentication/bindings/phone_authentication_binding.dart';
import '../modules/phone_authentication/views/phone_authentication_view.dart';
import '../modules/phone_verification/bindings/phone_verification_binding.dart';
import '../modules/phone_verification/views/phone_verification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/qr_code/bindings/qr_code_binding.dart';
import '../modules/qr_code/views/qr_code_view.dart';
import '../modules/selection/bindings/selection_binding.dart';
import '../modules/selection/views/selection_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SELECTION,
      page: () => const SelectionView(),
      binding: SelectionBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL_VERIFICATION,
      page: () => const EmailVerificationView(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA,
      page: () => const CafeteriaView(),
      binding: CafeteriaBinding(),
    ),
    GetPage(
      name: _Paths.CHILDREN_DETAILS,
      page: () => const ChildrenDetailsView(),
      binding: ChildrenDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MENU_PAGE,
      page: () => const MenuPageView(),
      binding: MenuPageBinding(),
    ),
    GetPage(
      name: _Paths.QR_CODE,
      page: () => const QrCodeView(),
      binding: QrCodeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.PARENTS_HOME,
      page: () => const ParentsHomeView(),
      binding: ParentsHomeBinding(),
    ),
    GetPage(
      name: _Paths.PARENTS_HISTORY,
      page: () => const ParentsHistoryView(),
      binding: ParentsHistoryBinding(),
    ),
    GetPage(
      name: _Paths.PARENTS_HISTORY_LIST,
      page: () => const ParentsHistoryListView(),
      binding: ParentsHistoryListBinding(),
    ),
    GetPage(
      name: _Paths.PARENTS_HISTORY_SELECT_DATE,
      page: () => const ParentsHistorySelectDateView(),
      binding: ParentsHistorySelectDateBinding(),
    ),
    GetPage(
      name: _Paths.PARENTS_HISTORY_DETAILS,
      page: () => const ParentsHistoryDetailsView(),
      binding: ParentsHistoryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_MEAL_DETAILS,
      page: () => const CafeteriaMealDetailsView(),
      binding: CafeteriaMealDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_MENU_PAGE,
      page: () => const CafeteriaMenuPageView(),
      binding: CafeteriaMenuPageBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_HISTORY,
      page: () => const CafeteriaHistoryView(),
      binding: CafeteriaHistoryBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_HISTORY_LIST,
      page: () => const CafeteriaHistoryListView(),
      binding: CafeteriaHistoryListBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_HISTORY_SELECT_DATE,
      page: () => const CafeteriaHistorySelectDateView(),
      binding: CafeteriaHistorySelectDateBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_AUTHENTICATION,
      page: () => const PhoneAuthenticationView(),
      binding: PhoneAuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_VERIFICATION,
      page: () => const PhoneVerificationView(),
      binding: PhoneVerificationBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_PAGE,
      page: () => const LandingPageView(),
      binding: LandingPageBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_DETAIL,
      page: () => const CafeteriaDetailView(),
      binding: CafeteriaDetailBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_LANDING_PAGE,
      page: () => const CafeteriaLandingPageView(),
      binding: CafeteriaLandingPageBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_CHILD_VERIFICATION,
      page: () => const CafeteriaChildVerificationView(),
      binding: CafeteriaChildVerificationBinding(),
    ),
    GetPage(
      name: _Paths.PARENTS_CHILDREN_DETAILS,
      page: () => const ParentsChildrenDetailsView(),
      binding: ParentsChildrenDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_PHONE_AUTHENICATION,
      page: () => const CafeteriaPhoneAuthenicationView(),
      binding: CafeteriaPhoneAuthenicationBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_PHONE_VERIFICATION,
      page: () => const CafeteriaPhoneVerificationView(),
      binding: CafeteriaPhoneVerificationBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_HISTORY_DETAILS,
      page: () => const CafeteriaHistoryDetailsView(),
      binding: CafeteriaHistoryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PARENT_NAME,
      page: () => const ParentNameView(),
      binding: ParentNameBinding(),
    ),
    GetPage(
      name: _Paths.CHILD_VERIFICATION_UPLOAD_INFO,
      page: () => const ChildVerificationUploadInfoView(),
      binding: ChildVerificationUploadInfoBinding(),
    ),
    GetPage(
      name: _Paths.CAFETERIA_CHILD_VERIFICATION_HOME,
      page: () => const CafeteriaChildVerificationHomeView(),
      binding: CafeteriaChildVerificationHomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SETTINGS,
      page: () => const HomeSettingsView(),
      binding: HomeSettingsBinding(),
    ),
  ];
}
