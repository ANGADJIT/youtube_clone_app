import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/logic/all_videos_cubit/all_videos_cubit.dart';
import 'package:youtube_clone_app/src/logic/auth_cubit/auth_cubit.dart';
import 'package:youtube_clone_app/src/logic/page_cubit/page_cubit.dart';
import 'package:youtube_clone_app/src/presentation/pages/auth_page.dart';
import 'package:youtube_clone_app/src/presentation/pages/home.dart';
import 'package:youtube_clone_app/src/utils/cache_manager.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/common_widgets.dart';
import 'package:youtube_clone_app/src/utils/custom_loading.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class AuthButton extends StatelessWidget {
  AuthButton(
      {super.key,
      this.isSignIn = false,
      required this.email,
      required this.password,
      this.channelName,
      this.channelPhotoPath,
      required this.formKey});

  final bool isSignIn;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController? channelName;
  final String? channelPhotoPath;
  final GlobalKey<FormState> formKey;

  // auth cubit
  final AuthCubit _authCubit = AuthCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () => isSignIn ? _login(context) : _register(context),
        child: VxBox(
                child: (isSignIn ? signInTitle : signUpTitle)
                    .text
                    .light
                    .headline6(context)
                    .color(black)
                    .makeCentered())
            .size(CustomMediaQuery.makeWidth(context, .4),
                CustomMediaQuery.makeHeight(context, .05))
            .roundedLg
            .shadow
            .color(white)
            .border(color: gray)
            .makeCentered());
  }

  Future<void> _login(BuildContext context) async {
    final bool isValid = formKey.currentState!.validate();

    final String username = email.text;
    final String pwd = password.text;

    if (isValid) {
      CustomLoading.showLoading(context);

      _authCubit.login(email: username, password: pwd).then((_) {
        if (_authCubit.state is LoggedIn) {
          // cache access_token

          final String accessToken =
              (_authCubit.state as LoggedIn).authLoginSession.accessToken;

          CacheManager.cacheToken(accessToken);

          context.nextAndRemoveUntilPage(MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => AllVideosCubit()),
              BlocProvider(create: (context) => PageCubit()),
            ],
            child: const Home(),
          ));
        } else if (_authCubit.state is AuthError) {
          final errorString =
              (_authCubit.state as AuthError).serverException.toString();
          CommonWidgets.showSnackbar(context, message: errorString);
        }

        CustomLoading.dismiss();
      });
    }
  }

  Future<void> _register(BuildContext context) async {
    final bool check = formKey.currentState!.validate();

    if (channelPhotoPath == null) {
      CommonWidgets.showSnackbar(context,
          message: 'Choose a channel profile photo');
      return;
    }

    if (check) {
      CustomLoading.showLoading(context);

      _authCubit
          .register(
              email: email.text,
              password: password.text,
              channelName: channelName!.text,
              channelPhotoPath: channelPhotoPath!)
          .then((value) async {
        if (_authCubit.state is AuthRegistered) {
          final String userId =
              (_authCubit.state as AuthRegistered).authCreateSession.userId;

          // cache user id
          CacheManager.cacheUserId(userId);

          // navigate to login
          context.nextAndRemoveUntilPage(const AuthPage(
            isSignIn: true,
          ));
        } else if (_authCubit.state is AuthError) {
          final errorString =
              (_authCubit.state as AuthError).serverException.toString();
          CommonWidgets.showSnackbar(context, message: errorString);
        }

        CustomLoading.dismiss();
      });
    }
  }
}
