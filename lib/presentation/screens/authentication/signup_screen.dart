import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/presentation/screens/authentication/widgets/username_textformfield.dart';
import 'package:travenor/widgets/general_button.dart';

import '../../../constants/constants.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import 'widgets/email_textformfield.dart';
import 'widgets/password_textformfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacementNamed('/main');
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator(color: mainColor));
          }
          return Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sign up now', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Text(
                    'Please fill the details and create account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: grey),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: UsernameTextFormField(usernameController: _usernameController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: EmailTextFormField(emailController: _emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: PasswordTextFormField(
                      passwordController: _passwordController,
                      helper: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Password must be 8 characters',
                          style: TextStyle(
                            fontSize: 14,
                            color: grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: GeneralButton(onTap: () => _createAccountWithEmailAndPassword(context), buttonText: 'Sign Up'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account',
                        style: TextStyle(color: grey, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => Navigator.of(context).pushReplacementNamed('/login'),
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(SignUpRequested(_usernameController.text, _emailController.text, _passwordController.text));
    }
  }
}
