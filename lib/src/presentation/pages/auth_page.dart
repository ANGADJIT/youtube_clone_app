import 'dart:io';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/presentation/widgets/auth_button.dart';
import 'package:youtube_clone_app/src/presentation/widgets/auth_form.dart';
import 'package:youtube_clone_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:youtube_clone_app/src/presentation/widgets/intro_image_widget.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_loading.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/media_manager.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, this.isSignIn = false});
  final bool isSignIn;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? _imagePath;

  // media manager
  final MediaManager _mediaManager = MediaManager();

  // text controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: CustomAppBar()
          .call(context, title: widget.isSignIn ? signInTitle : signUpTitle),
      body: SafeArea(
          child: SingleChildScrollView(
        child: VStack([
          //
          widget.isSignIn
              ? VStack([
                  CustomMediaQuery.makeHeight(context, .02).heightBox,
                  const IntroImageWidget(),
                  CustomMediaQuery.makeHeight(context, .07).heightBox
                ])
              : CustomMediaQuery.makeHeight(context, .06).heightBox,
          widget.isSignIn
              ? Container()
              : CircleAvatar(
                  backgroundColor: white,
                  radius: CustomMediaQuery.makeRadius(context, 2),
                  child: CircleAvatar(
                    backgroundColor: gray,
                    radius: CustomMediaQuery.makeRadius(context, 1.94),
                    backgroundImage: _imagePath != null
                        ? FileImage(File(_imagePath!))
                        : null,
                    child: _imagePath == null
                        ? Icon(Icons.add_a_photo,
                            color: black,
                            size: CustomMediaQuery.makeSize(context, .7))
                        : null,
                  ),
                ).centered().onTap(_loadImage),

          //
          CustomMediaQuery.makeHeight(context, .04).heightBox,
          AuthForm(
            email: _email,
            password: _password,
          ),

          //
          CustomMediaQuery.makeHeight(context, .08).heightBox,
          AuthButton(
              isSignIn: widget.isSignIn, email: _email, password: _password)
        ]),
      )).px(CustomMediaQuery.makeWidth(context, .06)),
    );
  }

  //function to load image
  Future<void> _loadImage() async {
    CustomLoading.showLoading(context);

    _imagePath = await _mediaManager.getImage();

    CustomLoading.dismiss();

    if (_imagePath != null) {
      setState(() {});
    }
  }
}
