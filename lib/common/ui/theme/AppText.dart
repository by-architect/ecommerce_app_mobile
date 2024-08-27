import '../../../sddklibrary/helper/string_helper.dart';

/*
class AppText{


  //common
  static const marketName = "Perfect Market";
  static const commonContinue = "Continue";
  static const commonNext = "Next";
  static const dismiss = "Dismiss";
  static const loading = "Loading";
  static const unselected = "Unselected";
  static const refresh = "Refresh";
  static const done = "Done";
  static const color = "Color";


  //user
  static const name = "Name";
  static const surname = "Surname";
  static const age = "Age";
  static const username = "Username";
  static const password = "Password";
  static const passwordConfirm = "Confirm Password";
  static const signIn = "Sign In";
  static const signUp = "Sign Up";
  static const phoneNo = "Phone Number";
  static const email = "Email";
  static const birthYear = "Birth year";
  static const gender = "Gender";
  static const man= "Man";
  static const woman= "Woman";

  //time
  static const second= "s";
  static const minute= "m";
  static const hour= "h";
  static const day= "d";
  static const month= "M";
  static const year= "Y";
  static const ago = "Ago";


  //errors
  static const errorTitle = "Error"; //todo: make it more soft
  static const errorEmptyPhone = "Please fill phone no";
  static const errorEmailHasTaken = "This email has taken";
  static const errorFetchingData = "Error occurred while fetching data from server";
  static const errorTimeout = "Connection timed out"; // bağlantı zaman aşımına uğradı
  static const errorNetworkRequestFailed = "Network request failed, please check your connection";
  static const errorEmptyField = "Please fill the blank fields";
  static const errorEmailIsNotValid = "Email is not valid ";
  static const errorPasswordLength = "Password length must be between 8 - 16";
  static const errorPhoneNoIsNotValid = "Phone no is not valid";
  static const errorNetworkDeviceIsDown = "Network device is down, please open your wifi or mobile hotspot";
  static const errorVerificationCodeIsWrong = "Verification code is wrong, please check it again";
  static const errorSomethingWentWrong = "Something went wrong";
  static const errorAuthenticate = "Please Authenticate Again";
  static const errorEmailNotVerified = "Email not verified";
  static const errorPasswordsAreNotMatching = "Passwords are not matching";
  static const errorBirthYearIsNotValid = "Please enter valid date of birth";
  static const errorProductDoesNotExist = "Product doesn't exist";
  static const errorLoadingCategories = "Error loading categories";
  static const errorStarMustBeSelected = "You must give rating";
  static const errorTitleCanNotBeEmpty = "Title can not be empty";
  static const errorContentCanNotBeEmpty = "Content can not be empty";

  //navigation
  static const navigationHome = "Home";
  static const navigationDiscover = "Discover";
  static const navigationCart = "Cart";
  static const navigationAccount = "Account";


  //welcome Page
  static const welcomePageOneTitle = "Welcome to $marketName";
  static const welcomePageOneContent = "Discover a world of exclusive deals and top-quality products at your fingertips. Shop with ease and enjoy seamless browsing";
  static const welcomePageTwoTitle = "Shop Smarter, Not Harder";
  static const welcomePageTwoContent = "Explore personalized recommendations, easy search options, and secure checkout processes designed to enhance your shopping experience.";
  static const welcomePageThreeTitle = "Ready to Shop?";
  static const welcomePageThreeContent = "Sign up or log in now to start your shopping journey. Enjoy exclusive member benefits, track your orders, and more!";

  //sign up screen
  static const signUpScreenAlreadyHaveAnAccount = "Already have an account? ";

  //sign in screen
  static const signInPageDoNotHaveAnAccount = "Don't have an account?";

  //verification page
  static const verificationEmail = "Email Verification";
  static const verificationPageEmailTitle = "Please enter the verification code";
  static const verificationPageEmailBody = "We sent a link to your email";
  static const verificationPageCheckYourEmail = "Check your emails, We are waiting for you";
  static const verificationPageSendEmailAgain = "Send email again";
  static const verificationPageAccountCreatedSuccessfully= "Account created successfully";


  //Discover page
  static const discoverPageFindSomething = "Find Something...";

  //search screen
  static const searchPageRecentSearches = "Recent Searches";


  //filter page
  static const filterPageAvailableInStock = "Available in stock";

  //home screen
  static const homePageNewProducts= "New Products"; // if it is food, new Foods
  static const homePageShopNow = "Shop now";
  static const homePageAllCategories = "All Categories";
  static const homePageDiscountProducts= "Flash Sale";
  static const homePageBestSellerProducts= "Best Seller";
  static const homePageLastAddedProducts= "Last Added";

  //product page
  static const productPageBuyNow= "Buy Now";
  static const productPageUnitPrice= "Unit Price";
  static const productPageNotifyMe= "Notify when product back to stock.";
  static const productPageAvailableInStock= "Available in stock";
  static const productPageUnAvailableInStock= "Currently unavailable";
  static const productPageStorePickupAvailability= "Store Pickup Availability";

  //product details page
  static const productDetailsPageDetails= "Product Details";
  static const productDetailsPageReviews ="Reviews";
  static const productDetailsPageUserReviews ="User Reviews";
  static const productDetailsPageReturns  = "Returns"; //iade
  static const productDetailsPageReturn  = "Return";
  static const productDetailsPageYouMayAlsoLike  = "You May Also Like";
  static const productDetailsPageAddToCart  = "Add To Cart";
  static const productDetailsPageTotalPrice  = "Total Price";
  static const productPageQuantity = "Quantity";
  static const productDetailsPageProductInfo = "Product Info";
  static const productDetailsPageBasedOn = "Based on";
  static const productDetailsPageStar = "Star";
  static const productDetailsPageAddReview = "Add Review";
  static const productDetailsPageOverallRating = "Your overall rating of this product";
  static const productDetailsPageSetATitle = "Set a title for your review";
  static const productDetailsPageSummarizeReview = "Summarize review";
  static const productDetailsPageWhatShouldShoppersKnow = "What should shoppers know before?";
  static const productDetailsPageCharacterMax = "Character Max";
  static const productDetailsPageWhatDidYouLike = "What did you like or dislike?";
  static const productDetailsPageSubmitReview = "Submit Review";
  static const productDetailsPageReviewSubmitted = "Review Submitted Successfully";



  //pages common
  static const commonPageFilter = "Filter";
  static const commonPageClearAll = "Clear All";
  static const commonPageCategory = "Category";
  static const commonPageOff = "off"; // indirim
  static const commonPageCategories = "Categories";

  static const productDetailsPageSelectedColor = "Selected Color";
}
*/

class AppText {
  final String _text;

  const AppText(this._text); //common

  String get capitalizeFirstWord => StringHelper.capitalizeFirstWord(_text);

  String get capitalizeEveryWord => StringHelper.capitalizeEveryWord(_text);

  String get allLower => _text.toLowerCase();

  String get allUpper => _text.toUpperCase();

  @override
  String toString() {
    return capitalizeFirstWord;
  } // String get text => _text;

  ///write string values first words first character big

  static const marketName = AppText("Perfect Market");

// Common
  static const commonContinue = AppText("Continue");
  static const commonNext = AppText("Next");
  static const dismiss = AppText("Dismiss");
  static const loading = AppText("Loading");
  static const unselected = AppText("Unselected");
  static const refresh = AppText("Refresh");
  static const done = AppText("Done");
  static const color = AppText("Color");

// User
  static const name = AppText("Name");
  static const surname = AppText("Surname");
  static const age = AppText("Age");
  static const username = AppText("Username");
  static const password = AppText("Password");
  static const passwordConfirm = AppText("Confirm password");
  static const signIn = AppText("Sign in");
  static const signUp = AppText("Sign up");
  static const phoneNo = AppText("Phone number");
  static const email = AppText("Email");
  static const birthYear = AppText("Birth year");
  static const gender = AppText("Gender");
  static const man = AppText("Man");
  static const woman = AppText("Woman");

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
  static const errorEmailNotVerified = AppText("Email not verified");
  static const errorPasswordsAreNotMatching = AppText("Passwords are not matching");
  static const errorBirthYearIsNotValid = AppText("Please enter valid date of birth");
  static const errorProductDoesNotExist = AppText("Product doesn't exist");
  static const errorLoadingCategories = AppText("Error loading categories");
  static const errorStarMustBeSelected = AppText("You must give rating");
  static const errorTitleCanNotBeEmpty = AppText("Title can not be empty");
  static const errorContentCanNotBeEmpty = AppText("Content can not be empty");

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
  static const welcomePageThreeContent =
      AppText("Sign up or log in now to start your shopping journey. Enjoy exclusive member benefits, track your orders, and more!");

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
  static const verificationPageAccountCreatedSuccessfully = AppText("Account created successfully");

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
  static const productPageUnAvailableInStock = AppText("Currently unavailable");
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

  //Cart Page
  static const cartPageReviewYourOrder = AppText("Review your order");
  static const cartPageOrderSummary = AppText("Order Summary");
  static const cartPageSubtotal = AppText("Subtotal");
  static const cartPageShippingFee = AppText("Shipping Fee");
  static const cartPageDiscount = AppText("Discount");
  static const cartPageTotal = AppText("Total");
  static const cartPageFree = AppText("Free");

// Pages Common
  static const commonPageFilter = AppText("Filter");
  static const commonPageClearAll = AppText("Clear all");
  static const commonPageCategory = AppText("Category");
  static const commonPageOff = AppText("Off"); // indirim
  static const commonPageCategories = AppText("Categories");
}
