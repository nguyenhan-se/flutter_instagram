import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_instagram/widgets/widgets.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/login/cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(
                authRepository: context.read<AuthRepository>(),
              ),
          child: LoginScreen()),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => Focus.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(
                  content: state.failure.message,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text(
                        'Instagram',
                        style: TextStyle(
                          fontFamily: 'Billabong',
                          fontSize: 60,
                          color: Colors.black,
                          wordSpacing: 10.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Email',
                                ),
                                onChanged: (value) => context
                                    .read<LoginCubit>()
                                    .emailChange(value),
                                validator: (value) => !value.contains('@')
                                    ? 'Please enter your email'
                                    : null),
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
                              onChanged: (value) => context
                                  .read<LoginCubit>()
                                  .passwordChange(value),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: ElevatedButton(
                          onPressed: () => _submittingLogin(
                              context, state.status == LoginStatus.submitting),
                          child: Text('Log In'),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      HorizontalOrLine(
                        labelMargin: 30.0,
                        label: 'OR',
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MdiIcons.facebook,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            'Continues as account facebook',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0),
                          )
                        ],
                      ),
                      const Spacer(),
                      LoginFooter(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submittingLogin(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<LoginCubit>().loginWithCredentials();
    }
  }
}

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Divider(
          color: Colors.black54,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Don\'t have an account?',
                  style: TextStyle(fontSize: 12.0),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                  text: ' Sign Up.',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class HorizontalOrLine extends StatelessWidget {
  final double labelMargin;
  final String label;

  const HorizontalOrLine({
    Key key,
    this.labelMargin,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: EdgeInsets.only(right: labelMargin),
          child: Divider(
            color: Colors.black54,
          ),
        )),
        Text(label),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: labelMargin),
          child: Divider(
            color: Colors.black54,
          ),
        )),
      ],
    );
  }
}
