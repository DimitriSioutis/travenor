import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/common_widgets/general_button.dart';
import '../../../../extensions/color_scheme_extension.dart';
import '../../../booking/presentation/bloc/booking_bloc.dart';
import '../../../booking/presentation/bloc/booking_event.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_event.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../widgets/email_textformfield.dart';
import '../widgets/password_textformfield.dart';
import '../widgets/username_textformfield.dart';

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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<FavoritesBloc>().add(LoadFavorites(state.user.uid));
            context.read<BookingBloc>().add(LoadBookedPlaces(state.user.uid));
            Navigator.of(context).pushReplacementNamed('/main');
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
          }
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
                      ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildFormFields(context),

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
        Text('Sign up now', style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 12),
        Text(
          'Please fill the details and create account',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 12),
          child: GeneralButton(onTap: () => _createAccountWithEmailAndPassword(context), buttonText: 'Sign Up'),
        ),
      ],
    );
  }

  Widget _buildFooterLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
          child: Text(
            'Sign in',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(SignUpRequested(_usernameController.text, _emailController.text, _passwordController.text));
    }
  }
}
