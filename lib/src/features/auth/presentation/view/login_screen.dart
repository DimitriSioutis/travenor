import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common_widgets/general_button.dart';
import '../../../../constants/colors.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_event.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../widgets/email_textformfield.dart';
import '../widgets/password_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<FavoritesBloc>().add(LoadFavorites(state.user.uid));
            Navigator.of(context).pushReplacementNamed('/main');
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator(color: mainColor))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildFormFields(),
                            const SizedBox(height: 24),
                            _buildFooterLinks(context),
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Sign in now', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(
          'Please sign in to continue our app',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: EmailTextFormField(emailController: _emailController),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: PasswordTextFormField(passwordController: _passwordController),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 12),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Navigator.pushNamed(context, '/forget_password'),
              child: Text(
                'Forget Password?',
                style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 12),
          child: GeneralButton(
            onTap: () => _authenticateWithEmailAndPassword(context),
            buttonText: 'Sign In',
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyle(color: grey, fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 10),
        TextButton(
          // splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          onPressed: () => Navigator.of(context).pushReplacementNamed('/signup'),
          child: Text(
            'Sign up',
            style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  void _authenticateWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(SignInRequested(_emailController.text, _passwordController.text));
    }
  }
}
