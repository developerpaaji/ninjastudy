import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study/blocs/auth.dart';
import 'package:study/utils/meta/text.dart';
import 'package:study/utils/validator.dart';
import 'package:study/widgets/app_banner.dart';
import 'package:study/widgets/button.dart';
import 'package:study/widgets/common_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _username = '';
  String _password = '';

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBanner(height: 50),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Text(
                MetaText.of(context).getStarted,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 12),
              Text(
                MetaText.of(context).getStartedDescription,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),
              CommonInputField(
                label: MetaText.of(context).username,
                hintText: MetaText.of(context).usernameHint,
                textInputAction: TextInputAction.next,
                required: true,
                onChanged: (val) {
                  setState(() {
                    _username = val;
                  });
                },
                validator: (val) => createValidator(val, [hasMinLength(4)]),
              ),
              const SizedBox(height: 24),
              CommonInputField(
                label: MetaText.of(context).password,
                obscureText: true,
                hintText: MetaText.of(context).passwordHint,
                validator: (val) => createValidator(val, [hasMinLength(4)]),
                required: true,
                onChanged: (val) {
                  setState(() {
                    _password = val;
                  });
                },
              ),
              const SizedBox(height: 45),
              AppButton(
                text: MetaText.of(context).submit,
                loading: _loading,
                onPressed: _login,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() {
      _loading = true;
    });
    final error =
        await BlocProvider.of<AuthBloc>(context).signin(_username, _password);
    _loading = false;
    if (error != null) {
      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$error")));
      return;
    }
  }
}
