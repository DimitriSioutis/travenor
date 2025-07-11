import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/colors.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth/auth_event.dart';
import '../../../auth/presentation/bloc/auth/auth_state.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites/favorites_event.dart';

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
          context.read<FavoritesBloc>().add(LoadFavorites(authState.user.uid));
          return InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
            child: Container(
              decoration: BoxDecoration(color: lightGrey, borderRadius: BorderRadius.circular(22)),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: grey,
                    radius: 18.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      authState.user.username,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: blackText),
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
