import '../../../sddklibrary/helper/string_helper.dart';

class AppText {
  final String _text;

  const AppText(this._text); //common

 AppText get capitalizeFirstWord => AppText(StringHelper.capitalizeFirstWord(_text));

  AppText get capitalizeEveryWord => AppText(StringHelper.capitalizeEveryWord(_text));

  AppText get addStar => AppText("$_text*");

  AppText get addSlash => AppText("$_text/");
  AppText get addSpace => AppText("$_text ");
  AppText combine(AppText nextText) => AppText("$_text${nextText.get}");

  AppText get allLower => AppText(_text.toLowerCase());

  AppText get allUpper => AppText(_text.toUpperCase());

  String get get => _text;

  @override
  String toString() {
    return capitalizeFirstWord.get;
  } // String get text => _text;

  ///write string values first words first character big

  static const marketName = AppText("Perfect Market");

// Common
  static const commonContinue = AppText("Continue");
  static const commonNext = AppText("Next");
  static const commonSkip = AppText("Skip");
  static const dismiss = AppText("Dismiss");
  static const loading = AppText("Loading");
  static const unselected = AppText("Unselected");
  static const refresh = AppText("Refresh");
  static const done = AppText("Done");
  static const save = AppText("Save");
  static const color = AppText("Color");

// User
  static const name = AppText("Name");
  static const surname = AppText("Surname");
  static const age = AppText("Age");
  static const username = AppText("Username");
  static const password = AppText("Password");
  static const oldPassword = AppText("Old Password");
  static const newPassword = AppText("New Password");
  static const passwordConfirm = AppText("Confirm password");
  static const signIn = AppText("Sign in");
  static const signUp = AppText("Sign up");
  static const phoneNo = AppText("Phone number");
  static const email = AppText("Email");
  static const birthYear = AppText("Birth year");
  static const gender = AppText("Gender");
  static const man = AppText("Man");
  static const woman = AppText("Woman");
  static const account = AppText("Account");
  static const logOut = AppText("Log out");

// Time
  static const second = AppText("s");
  static const minute = AppText("m");
  static const hour = AppText("h");
  static const day = AppText("d");
  static const month = AppText("M");
  static const year = AppText("Y");
  static const ago = AppText("Ago");

// Errors
  static const errorTitle = AppText("Error"); //todo: make it more soft
  static const errorEmptyPhone = AppText("Please fill phone no");
  static const errorEmailHasTaken = AppText("This email has taken");
  static const errorFetchingData = AppText("Error occurred while fetching data from server");
  static const errorTimeout = AppText("Connection timed out"); // bağlantı zaman aşımına uğradı
  static const errorNetworkRequestFailed = AppText("Network request failed, please check your connection");
  static const errorEmptyField = AppText("Please fill the blank fields");
  static const errorEmailIsNotValid = AppText("Email is not valid");
  static const errorPasswordLength = AppText("Password length must be between 8 - 16");
  static const errorPhoneNoIsNotValid = AppText("Phone no is not valid");
  static const errorNetworkDeviceIsDown = AppText("Network device is down, please open your wifi or mobile hotspot");
  static const errorVerificationCodeIsWrong = AppText("Verification code is wrong, please check it again");
  static const errorSomethingWentWrong = AppText("Something went wrong");
  static const errorAuthenticate = AppText("Please authenticate again");
  static const errorCouldNotChangedThePassword = AppText("Couldn't changed the password");
  static const errorEmailNotVerified = AppText("Email not verified");
  static const errorPasswordsAreNotMatching = AppText("Passwords are not matching");
  static const errorBirthYearIsNotValid = AppText("Please enter valid date of birth");
  static const errorProductDoesNotExist = AppText("Product doesn't exist");
  static const errorLoadingCategories = AppText("Error loading categories");
  static const errorStarMustBeSelected = AppText("You must give rating");
  static const errorTitleCanNotBeEmpty = AppText("Title can not be empty");
  static const errorContentCanNotBeEmpty = AppText("Content can not be empty");
  static const errorCategoriesNotFound = AppText("Categories not found, please try again later");
  static const errorPasswordIsIncorrect = AppText("Password is incorrect");
  static const errorPleaseSelectProductFeature = AppText("Please select");
  static const errorGettingLocationPermission =
      AppText("Location permission denied, please allow permission from settings if location needed");
  static const errorGettingLocation = AppText("Couldn't get location");
  static const errorOpeningLocationService = AppText("Please open the location service to proceed");
 static const errorAddingAddress = AppText("Address Couldn't be added");
 static const errorRemovingAddress = AppText("Address Couldn't be removed");

  //info
  static const infoPleaseLoginToSeeYourCart = AppText("Please login to see your cart");
  static const infoPleaseLoginToSeeYourProfile = AppText("Please login to see your profile");
  static const infoPasswordChangedSuccessfully = AppText("Password changed successfully");
  static const infoProfileSettingsChangedSuccessfully = AppText("Profile settings changed successfully");
  static const infoEmptyCart = AppText("Upps! Your bucket is empty, let's start to shop");
 static const infoAddressRemoved = AppText("Address removed successfully");

// Navigation
  static const navigationHome = AppText("Home");
  static const navigationDiscover = AppText("Discover");
  static const navigationCart = AppText("Cart");
  static const navigationAccount = AppText("Account");

// Welcome Page
  static final welcomePageOneTitle = AppText("Welcome to $marketName");
  static const welcomePageOneContent = AppText(
      "Discover a world of exclusive deals and top-quality products at your fingertips. Shop with ease and enjoy seamless browsing");
  static const welcomePageTwoTitle = AppText("Shop smarter, not harder");
  static const welcomePageTwoContent = AppText(
      "Explore personalized recommendations, easy search options, and secure checkout processes designed to enhance your shopping experience.");
  static const welcomePageThreeTitle = AppText("Ready to shop?");
  static const welcomePageThreeContent = AppText(
      "Sign up or log in now to start your shopping journey. Enjoy exclusive member benefits, track your orders, and more!");

// Sign Up Screen
  static const signUpScreenAlreadyHaveAnAccount = AppText("Already have an account?");

// Sign In Screen
  static const signInPageDoNotHaveAnAccount = AppText("Don't have an account?");

// Verification Page
  static const verificationEmail = AppText("Email verification");
  static const verificationPageEmailTitle = AppText("Please enter the verification code");
  static const verificationPageEmailBody = AppText("We sent a link to your email");
  static const verificationPageCheckYourEmail = AppText("Check your emails, we are waiting for you");
  static const verificationPageSendEmailAgain = AppText("Send email again");

  // static const verificationPageAccountCreatedSuccessfully = AppText("Account created successfully");
  static const verificationPageEmailVerifiedSuccessfully = AppText("Email verified successfully");

// Discover Page
  static const discoverPageFindSomething = AppText("Find something...");

// Search Screen
  static const searchPageRecentSearches = AppText("Recent searches");

// Filter Page
  static const filterPageAvailableInStock = AppText("Available in stock");

// Home Screen
  static const homePageNewProducts = AppText("New products"); // if it is food, new Foods
  static const homePageShopNow = AppText("Shop now");
  static const homePageAllCategories = AppText("All categories");
  static const homePageDiscountProducts = AppText("Flash sale");
  static const homePageBestSellerProducts = AppText("Best seller");
  static const homePageLastAddedProducts = AppText("Last added");

// Product Page
  static const productPageBuyNow = AppText("Buy now");
  static const productPageUnitPrice = AppText("Unit price");
  static const productPageNotifyMe = AppText("Notify when product back to stock.");
  static const productPageAvailableInStock = AppText("Available in stock");
  static const productPageAvailableInStockSmall = AppText("Available");
  static const productPageUnAvailableInStock = AppText("Currently unavailable");
  static const productPageUnAvailableInStockSmall = AppText("Unavailable");
  static const productPageStorePickupAvailability = AppText("Store pickup availability");

// Product Details Page
  static const productDetailsPageDetails = AppText("Product details");
  static const productDetailsPageReviews = AppText("Reviews");
  static const productDetailsPageUserReviews = AppText("User reviews");
  static const productDetailsPageReturns = AppText("Returns"); //iade
  static const productDetailsPageReturn = AppText("Return");
  static const productDetailsPageYouMayAlsoLike = AppText("You may also like");
  static const productDetailsPageAddToCart = AppText("Add to cart");
  static const productDetailsPageTotalPrice = AppText("Total price");
  static const productPageQuantity = AppText("Quantity");
  static const productDetailsPageProductInfo = AppText("Product info");
  static const productDetailsPageBasedOn = AppText("Based on");
  static const productDetailsPageStar = AppText("Star");
  static const productDetailsPageAddReview = AppText("Add review");
  static const productDetailsPageOverallRating = AppText("Your overall rating of this product");
  static const productDetailsPageSetATitle = AppText("Set a title for your review");
  static const productDetailsPageSummarizeReview = AppText("Summarize review");
  static const productDetailsPageWhatShouldShoppersKnow = AppText("What should shoppers know before?");
  static const productDetailsPageCharacterMax = AppText("Character max");
  static const productDetailsPageWhatDidYouLike = AppText("What did you like or dislike?");
  static const productDetailsPageSubmitReview = AppText("Submit review");
  static const productDetailsPageReviewSubmitted = AppText("Review submitted successfully");
  static const productDetailsPageSelectedColor = AppText("Selected color");
  static const productDetailsPageAddedToCart = AppText("Added to cart");
  static const productDetailsPageCompletePurchase =
      AppText("Click the checkout button to complete the purchase process.");
  static const productDetailsPageContinueShopping = AppText("Continue shopping");
  static const productDetailsPageCheckout = AppText("Checkout");

  //Cart Page
  static const cartPageReviewYourOrder = AppText("Review your order");
  static const cartPageOrderSummary = AppText("Order Summary");
  static const cartPageSubtotal = AppText("Subtotal");
  static const cartPageShippingFee = AppText("Shipping Fee");
  static const cartPageDiscount = AppText("Discount");
  static const cartPageTotal = AppText("Total");
  static const cartPageFree = AppText("Free");

  //Profile Page
  static const profilePageOrders = AppText("Orders");
  static const profilePageAddresses = AppText("Addresses");
  static const profilePageMarketing = AppText("Marketing");
  static const profilePageChangePassword = AppText("Change password");
  static const profilePageEditProfile = AppText("Edit profile");
  static const profilePageFAQ = AppText("FAQ");
  static const profilePageGetHelp = AppText("Get Help");
  static const profilePageHelpAndSupport = AppText("Help & Support");
  static const profilePageVerifyEmailText = AppText("Your email is not verified yet");
  static const profilePageVerifyNow = AppText("Verify now");

  //change password
  static const changePasswordPageChangePassword = AppText("Change Password");

  //edit profile
  static const editProfilePageEditProfile = AppText("Edit profile");

  //address page
  static const addressesPageAddresses = AppText("Addresses");
  static const addressesPageAddAddress = AppText("Add New Address");
  static const addressesPageAddressTitle = AppText("Address Title");
  static const addressesPagePhoneNo = AppText("Phone No");
  static const addressesPageStreet = AppText("Street");
  static const addressesPageArea = AppText("Area");
  static const addressesPageStreetNO = AppText("Street No");
  static const addressesPageFloor = AppText("Floor");
  static const addressesPageDoorNo = AppText("Door No");
 static const addressesPageState = AppText("State");
  static const addressesPageCity = AppText("City");
  static const addressesPageCountry = AppText("Country");
  static const addressesUserNote = AppText("Directions");

  //payment screen
  static const paymentPagePaymentMethod = AppText("Payment Method");
 static const paymentPageCompletePayment = AppText("Complete Payment");
  static const paymentPageCashOnDelivery = AppText("Cash on delivery");
  static const paymentPageCreditCard = AppText("Credit card");
  static const paymentPagePayWithCard = AppText("Pay with card");
  static const paymentPagePayWithCash = AppText("Pay with cash");
  static const paymentPagePay = AppText("Pay");
 static const paymentPageCardNumber = AppText("Card number");
 static const paymentPageExpiryDate = AppText("Expiry date");
 static const paymentPageCvcCvv = AppText("CVC / CVV");
 static const paymentPageSelectAddress = AppText("Select an address");
 static const paymentPageChangeAddress = AppText("Change address");



// Pages Common
  static const commonPageFilter = AppText("Filter");
  static const commonPageClearAll = AppText("Clear all");
  static const commonPageCategory = AppText("Category");
  static const commonPageOff = AppText("Off"); // indirim
  static const commonPageCategories = AppText("Categories");
  static const commonPagePhoneNoHintText = AppText("(555) 555 55 55");

}
