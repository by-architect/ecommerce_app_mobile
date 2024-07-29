import 'package:ecommerce_app_mobile/sddklibrary/constant/firebase_error_messages.dart';

class AppText{


  //common
  static const marketName = "Perfect Market";
  static const commonContinue = "Continue";
  static const commonNext = "Next";
  static const dismiss = "Dismiss";
  static const loading = "Loading";
  static const unselected = "Unselected";

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
  static const accountCreatedSuccessfully= "Account created successfully";

}