import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetaText {
  final BuildContext context;

  MetaText(this.context);

  static MetaText of(BuildContext context) {
    return Provider.of<MetaText>(context, listen: false);
  }

  String get getStarted => "Get started";
  String get getStartedDescription =>
      "Please enter your username and password to continue";
  String get required => "Required";
  String get username => "Username";
  String get usernameHint => "singhbhavneet";
  String get password => "Password";
  String get passwordHint => "******";
  String get signin => "Signin";
  String get conversations => "Conversations";
  String get bySigningUp => "By signing up, You agree to our ";
  String get haveRead => " and have read and understood our ";
  String get privacyPolicy => "Privacy Policy.";
  String get termsOfService => "Terms of Service";
  String get chat => "Chat";
  String get cancel => "Cancel";
  String get listening => 'Listening...';
  String get startConversation => "Start conversation";
  String get micPermissionNotGiven => "Mic Permission not given";
  String get anonymous => "Anonymous";
  String get startConversationDescription =>
      "Click on '+' button to start your english training with A.I";
  String get agree => "Agree";
  String get doYouWantToLogout => "Do you want to logout";
  String get suggestion => "You can say";
  String get send => "Send";
}
