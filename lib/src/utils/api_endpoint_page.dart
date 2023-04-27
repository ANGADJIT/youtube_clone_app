import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/logic/all_videos_cubit/all_videos_cubit.dart';
import 'package:youtube_clone_app/src/presentation/pages/home.dart';
import 'package:youtube_clone_app/src/presentation/pages/intro_page.dart';
import 'package:youtube_clone_app/src/utils/cache_manager.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class APIEndpointPage extends StatelessWidget {
  APIEndpointPage({super.key});

  final TextEditingController _host = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: VStack([
        CustomMediaQuery.makeHeight(context, .15).heightBox,

        //
        VxTextField(
          cursorColor: black,
          fillColor: white,
          hint: apiEndpointTextFieldHint,
          borderType: VxTextFieldBorderType.roundLine,
          borderRadius: CustomMediaQuery.makeRadius(context, .1),
          controller: _host,
          borderColor: blue,
        ),

        //
        CustomMediaQuery.makeHeight(context, .09).heightBox,
        OutlinedButton(
                onPressed: () {
                  CacheManager.cacheBaseHost(_host.text);
                  context.nextReplacementPage(const IntroPage());

                  final accessToken = CacheManager.token;

                  if (accessToken != null) {
                    context.nextAndRemoveUntilPage(BlocProvider(
                      create: (context) => AllVideosCubit(),
                      child: const Home(),
                    ));
                  } else {
                    context.nextAndRemoveUntilPage(const IntroPage());
                  }
                },
                child: addUrlButtonText.text.make())
            .centered(),
        OutlinedButton(
                onPressed: () => _checkAuth(context),
                child: usePreviousButtonText.text.make())
            .centered(),
      ]).px(CustomMediaQuery.makeWidth(context, .04)))),
    );
  }

  void _checkAuth(BuildContext context) {
    final accessToken = CacheManager.token;

    if (accessToken != null) {
      context.nextAndRemoveUntilPage(BlocProvider(
        create: (context) => AllVideosCubit(),
        child: const Home(),
      ));
    } else {
      context.nextAndRemoveUntilPage(const IntroPage());
    }
  }
}
