import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travenor/src/features/profile/presentation/widgets/logout_dialog.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth/auth_event.dart';
import '../bloc/theme/theme_bloc.dart';
import '../bloc/theme/theme_event.dart';
import '../bloc/theme/theme_state.dart';
import '../widgets/profile_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Settings',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isDarkMode = state.themeMode == ThemeMode.dark;
                return ProfileButton(
                  title: 'Change Theme',
                  rightWidget: Switch(
                    value: isDarkMode,
                    inactiveThumbColor: Theme.of(context).colorScheme.primary,
                    inactiveTrackColor: Theme.of(context).colorScheme.onSurface,
                    activeColor: Theme.of(context).colorScheme.primary,
                    activeTrackColor: Theme.of(context).colorScheme.onPrimary,
                    onChanged: (newValue) {
                      final newThemeMode = newValue ? ThemeMode.dark : ThemeMode.light;
                      context.read<ThemeBloc>().add(ThemeChanged(themeMode: newThemeMode));
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ProfileButton(
              title: 'Log out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return LogoutDialog(
                      submit: () {
                        context.read<AuthBloc>().add(SignOutRequested());
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
