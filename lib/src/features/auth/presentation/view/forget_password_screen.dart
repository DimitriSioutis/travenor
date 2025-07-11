import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common_widgets/travenor_back_button.dart';
import '../../../../common_widgets/general_button.dart';
import '../../../../constants/colors.dart';
import '../../domain/repositories/auth_repository.dart';
import '../bloc/forget_password/forget_password_bloc.dart';
import '../bloc/forget_password/forget_password_event.dart';
import '../bloc/forget_password/forget_password_state.dart';
import '../widgets/email_textformfield.dart';
import '../widgets/forgot_password_dialog.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocProvider(
        create: (context) => ForgetPasswordBloc(authRepository: context.read<AuthRepository>()),
        child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordSuccess) {
              _showInfoDialog(context);
            }

            if (state is ForgetPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },

          builder: (context, state) {
            if (state is ForgetPasswordLoading) {
              return const Center(child: CircularProgressIndicator(color: mainColor));
            }
            return Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20 + MediaQuery.of(context).padding.top, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TravenorBackButton(),
                      ),

                      const SizedBox(height: 40),
                      _buildHeader(context),
                      const SizedBox(height: 24),
                      _buildFormFields(context),
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Forgot Password', style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 12),
        Text(
          'Enter your email account to reset  your password',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
          child: EmailTextFormField(emailController: _emailController),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 12),
          child: GeneralButton(
            onTap: () => _resetPassword(context),

            buttonText: 'Reset Password',
          ),
        ),
      ],
    );
  }

  void _resetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ForgetPasswordBloc>().add(ForgetPasswordRequested(_emailController.text));
    }
  }

  _showInfoDialog(BuildContext context) async {
    showDialog(
      context: context,
      routeSettings: RouteSettings(name: '/login'),
      builder: (BuildContext dialogContext) {
        return ForgotPasswordDialog();
      },
    ).then((_) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
  }
}
