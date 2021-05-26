import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_instagram/widgets/widgets.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/signup/cubit/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<SignupCubit>(
          create: (context) => SignupCubit(
                authRepository: context.read<AuthRepository>(),
              ),
          child: SignupScreen()),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(listener: (context, state) {
      if (state.status == SignupStatus.error) {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            content: state.failure.message,
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backwardsCompatibility: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  'Enter Email Signup',
                  style: TextStyle(fontSize: 26.0),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SignupForm(formKey: _formKey),
                const SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () => _submittingSignup(
                        context, state.status == SignupStatus.submitting),
                    child: Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _submittingSignup(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<SignupCubit>().signupWithCredentials();
    }
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
            onChanged: (value) =>
                context.read<SignupCubit>().usernameChanged(value),
            validator: (value) =>
                value.trim().isEmpty ? 'Please enter your username' : null,
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              onChanged: (value) =>
                  context.read<SignupCubit>().emailChanged(value),
              validator: (value) =>
                  !value.contains('@') ? 'Please enter your email' : null),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              suffixIcon: Icon(MdiIcons.eyeOff),
            ),
            onChanged: (value) =>
                context.read<SignupCubit>().passwordChanged(value),
            validator: (value) => value.trim().length > 6
                ? 'Password must be at least 6 characters'
                : null,
          ),
        ],
      ),
    );
  }
}
