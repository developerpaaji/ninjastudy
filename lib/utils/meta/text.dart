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
  String get submit => "Submit";
}
