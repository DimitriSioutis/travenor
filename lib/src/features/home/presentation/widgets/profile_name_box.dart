import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../extensions/color_scheme_extension.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth/auth_event.dart';
import '../../../auth/presentation/bloc/auth/auth_state.dart';

class ProfileNameBox extends StatelessWidget {
  const ProfileNameBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        }
      },
      builder: (context, authState) {
        if (authState is Authenticated) {
          return InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceBlock,
                borderRadius: BorderRadius.circular(22),
              ),
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
                    radius: 18.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      authState.user.username,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Text('Home');
      },
    );
  }
}
