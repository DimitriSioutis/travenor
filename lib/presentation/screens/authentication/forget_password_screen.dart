import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travenor/presentation/screens/authentication/widgets/email_textformfield.dart';
import '../../../constants/constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../logic/blocs/forget_password/forget_password_bloc.dart';
import '../../../logic/blocs/forget_password/forget_password_event.dart';
import '../../../logic/blocs/forget_password/forget_password_state.dart';
import '../../../widgets/general_button.dart';

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
      backgroundColor: Colors.white,
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
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: grey.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  'assets/icons/back.svg',
                                  color: blackText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                      Text('Forgot Password', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),

                      const SizedBox(height: 12),
                      Text(
                        'Enter your email account to reset  your password',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: grey),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
                        child: EmailTextFormField(emailController: _emailController),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 12),
                        child: GeneralButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ForgetPasswordBloc>().add(ForgetPasswordRequested(_emailController.text));
                            }
                          },
                          buttonText: 'Reset Password',
                        ),
                      ),
                      const SizedBox(height: 24),
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
}

_showInfoDialog(BuildContext context) async {
  showDialog(
    context: context,
    routeSettings: RouteSettings(name: '/login'),
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        child: InkWell(
          onTap: () => Navigator.pop(dialogContext),
          child: Container(
            height: 196,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: secondaryColor,
                  child: SvgPicture.asset('assets/icons/email.svg'),
                ),
                Text(
                  'Check your email',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: blackText),
                ),
                Text(
                  'We have send password recovery instruction to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: grey),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((_) {
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  });
}
