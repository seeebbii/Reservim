import 'package:flutter/material.dart';
import 'package:reservim/core/model/blog_model.dart';
import 'package:reservim/core/model/blogs_category.model.dart';
import 'package:reservim/core/model/user/appointments.model.dart';
import 'package:reservim/meta/views/authentication/create_new_password.dart';
import 'package:reservim/meta/views/authentication/login_screen.dart';
import 'package:reservim/meta/views/authentication/signup_screen.dart';
import 'package:reservim/meta/views/authentication/welcome_screen.dart';
import 'package:reservim/meta/views/main/appointments/appointment_details.dart';
import 'package:reservim/meta/views/main/explore/book/calender.book.screen.dart';
import 'package:reservim/meta/views/main/explore/book/confirm.book.screen.dart';
import 'package:reservim/meta/views/main/explore/book/form.book.screen.dart';
import 'package:reservim/meta/views/main/explore/book/payment_screen.dart';
import 'package:reservim/meta/views/main/explore/pageview/report.screen.dart';
import 'package:reservim/meta/views/main/explore/recommended_service.explore.dart';
import 'package:reservim/meta/views/main/home/blog_category_list.dart';
import 'package:reservim/meta/views/main/profile/account_settings.profile.dart';
import 'package:reservim/meta/views/main/profile/privacy_policy.profile.dart';
import 'package:reservim/meta/views/main/profile/reviews.profile.dart';
import 'package:reservim/meta/views/main/profile/terms_of_service.profile.dart';
import 'package:reservim/meta/views/main/root/nav_bar_root.dart';
import 'package:reservim/meta/views/splash/splash_screen.dart';

import '../../meta/views/authentication/enter_phone_number_screen.dart';
import '../../meta/views/authentication/forgot_password_screen.dart';
import '../../meta/views/main/home/blog_details.dart';
import '../../meta/views/main/home/category.blog.details.dart';
import '../../meta/views/main/home/widgets/all_deals.listview.dart';
import '../../meta/views/main/profile/payments.profile.dart';

class RouteGenerator {
  // TODO : ROUTES GENERATOR CLASS THAT CONTROLS THE FLOW OF NAVIGATION/ROUTING

  // WELCOME ROUTE
  static const String splashScreen = '/splash-screen';

  // AUTH ROUTE
  static const String welcomeScreen = '/welcome-screen';
  static const String loginScreen = '/login-screen';
  static const String signupScreen = '/signup-screen';
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String enterPhoneNumberScreen = '/enter-phone-number-screen';
  static const String createNewPassword = '/create-new-password-screen';

  // HOME ROUTES
  static const String homePageRoot = '/main-page-root';
  static const String blogDetails = '/blog-details-screen';
  static const String categoryBlogDetails = '/category-blog-details';
  static const String allDealsScreen = '/all-deals-screen';
  static const String blogCategoryList = '/blog-category-list-screen';

  // EXPLORE ROUTES
  static const String recommendedServiceExploreScreen =
      '/recommended-service-explore-screen';
  static const String calenderBookScreen = '/calender-book-screen';
  static const String formBookScreen = '/form-book-screen';
  static const String confirmBookScreen = '/confirm-book-screen';
  static const String reportScreen = '/report-screen';
  static const String paymentScree = '/payment-screen';

  // PROFILE ROUTES
  static const String profilePayment = '/profile-payment-screen';
  static const String termsOfService = '/profile-terms-screen';
  static const String privacyPolicy = '/profile-privacy-screen';
  static const String reviewsScreen = '/profile-reviews-screen';
  static const String accountsScreen = '/profile-accounts-screen';

  // APPOINTMENT ROUTES
  static const String appointmentDetails = '/appointment-details-screen';

  // FUNCTION THAT HANDLES ROUTING
  static Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
    Map<String, dynamic> args = {};
    // GETTING ARGUMENTS IF PASSED
    if (settings.arguments != null) {
      args = settings.arguments as Map<String, dynamic>;
      debugPrint("${settings.arguments}");
    }
    debugPrint(settings.name);

    switch (settings.name) {
      case splashScreen:
        return _getPageRoute(const SplashScreen());

      case welcomeScreen:
        return _getPageRoute(const WelcomeScreen());

      case loginScreen:
        return _getPageRoute(const LoginScreen());

      case signupScreen:
        return _getPageRoute(const SignupScreen());

      case forgotPasswordScreen:
        return _getPageRoute(ForgotPasswordScreen(phoneNumber: args['phoneNumber'], verificationId: args['verificationId'],));

        case enterPhoneNumberScreen:
        return _getPageRoute(EnterPhoneNumberScreen(clientId: args['clientId'],));

      case createNewPassword:
        return _getPageRoute(CreateNewPassword(
          isFromProfile: args['isFromProfile'],
        ));

      case homePageRoot:
        return _getPageRoute(const NavBarRoot());

      case profilePayment:
        return _getPageRoute(const PaymentsProfileScreen());

      case termsOfService:
        return _getPageRoute(const TermsOfServiceProfileScreen());

      case privacyPolicy:
        return _getPageRoute(const PrivacyPolicyProfileScreen());

      case reviewsScreen:
        return _getPageRoute(ReviewsProfileScreen());

      case accountsScreen:
        return _getPageRoute(const AccountSettingsProfileScreen());

      case recommendedServiceExploreScreen:
        return _getPageRoute(const RecommendedServiceExploreScreen());

      case calenderBookScreen:
        return _getPageRoute(CalenderBookScreen(
          durationHour: args['durationHour'],
          durationMinute: args['durationMinute'],
        ));

      case formBookScreen:
        return _getPageRoute(const FormBookScreen());

      case confirmBookScreen:
        return _getPageRoute(const ConfirmBookScreen());

      case allDealsScreen:
        return _getPageRoute(const AllDealsListView());

        case blogCategoryList:
        return _getPageRoute(BlogCategoryList(id: args['id'], categoryName: args['categoryName'],));

      case paymentScree:
        return _getPageRoute(PaymentScreen(
            appointmentId: args['appointmentId'],
            totalAmount: args['totalAmount']));

      case reportScreen:
        return _getPageRoute(ReportScreen(
          shopId: args['shopId'],
          clientId: args['clientId'],
          reviewId: args['reviewId'],
        ));

      case appointmentDetails:
        return _getPageRoute(AppointmentDetails(
            appointment: args['appointmentModel'] as FinishedAppointment));

      case blogDetails:
        return _getPageRoute(BlogDetails(
          blogData: args['blogs'],
          imagePath: args['imagePath'],
        ));

      case categoryBlogDetails:
        return _getPageRoute(CategoryBlogDetails(
          blogData: args['blogs'],
            imagePath: args['imagePath'],
          category: args['category'],
        ));

      default:
        return _errorRoute();
    }
  }

  // FUNCTION THAT HANDLES NAVIGATION
  static PageRoute _getPageRoute(Widget child) {
    return MaterialPageRoute(builder: (ctx) => child);
  }

  // 404 PAGE
  static PageRoute _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('ERROR 404: Not Found'),
        ),
      );
    });
  }
}
