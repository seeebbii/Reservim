class ApiPaths {
  // static const String liveBaseURL = "https://dev.reservim.com/api/";
  static const String liveBaseURL = "https://reservim.com/api/";
  static const String imageBaseUrl = "https://reservim.com";

  static const String defaultImage =
      "https://ik.imagekit.io/eulvgq3uklbd/listing-image_ozWRnkzow.svg";

  static const String localBaseURL = "http://192.168.9.214:8080/api/v1/";
  static const String assetsPath = "";

  static const String baseURL = liveBaseURL;

  // endpoints
  static const String auth = "auth/";

  // user auth
  static const String login = baseURL + auth + "login/";
  static const String signup = baseURL + auth + "register/";
  static const String logout = baseURL + auth + "logout/";
  static const String userProfile = baseURL + auth + 'user-profile';
  static const String updateUserProfile =
      baseURL + auth + "update-user-profile/";
  static const String updateUserLogo = baseURL + auth + "update-logo/";
  static const String resetPassword = baseURL + auth + "reset-password/";
  static const String userAppointments = baseURL + auth + "user-appointment/";
  static const String userLatestAppointments =
      baseURL + auth + "user-latest-appointment/";
  static const String userPayments = baseURL + auth + "user-payment/";
  static const String userReviews = baseURL + auth + "user-review/";
  static const String addUserReview = baseURL + auth + "add-user-review/";
  static const String userAppointmentDetails =
      baseURL + auth + "user-appointment-detail/";
  static const String cancelUserAppointment =
      baseURL + auth + "cancel-user-appointment/";
  static const String bookUserAppointment =
      baseURL + auth + "save-frontend-appointment";
  static const String userNotifications = baseURL + "get-user-notification/";
  static const String removeUserNotifications =
      baseURL + "remove-user-notification/";

  // home page
  static const String recommendedList = baseURL + "recommended/shops/";
  static const String shopDetails = baseURL + "get-shop-detail/";
  static const String specialOffers = baseURL + "get-discount-shop-list/";
  static const String likeShop = baseURL + auth + "make-user-favorite-shop/";
  static const String unLikeShop =
      baseURL + auth + "make-user-unfavorite-shop/";
  static const String getUserLikedShops =
      baseURL + auth + "user-favorite-shop/";
  static const String reportShop = baseURL + "shop/report";
  static const String slotsOfShop = baseURL + "list-of-slots-shop/";
  static const String allDeals = baseURL + "deals/";
  static const String dealDetails = baseURL + "get-deal/";
  static const String cityDeals = baseURL + "get-city-deal/";

  static const String searchService = baseURL + "s/";
  static const String nearMe = "/near-me/";
  static const String searchShopAndService = "/near-me/";

  static const String getSelectedCategories =
      baseURL + "get-selected-categories";
  static const String getSearchedServices = baseURL + "get-Searched-Services/";
  static const String homePageBlogs = baseURL + "get-homepage-blogs/";
  static const String categoryBlogs = baseURL + "click-category-blog/";
  static const String getBlogCategories = baseURL + "get-blog-categories/";

  // cities
  static const String getCities = baseURL + "get-cities/";
}
