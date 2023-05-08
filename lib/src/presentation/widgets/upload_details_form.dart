import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class UploadDetailsForm extends StatelessWidget {
  const UploadDetailsForm(
      {super.key,
      required this.formKey,
      required this.title,
      required this.description});

  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController description;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: VStack([
          //
          VxTextField(
            controller: title,
            borderColor: Colors.transparent,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Title required';
              }

              return null;
            },
            hintStyle: TextStyle(
                color: gray,
                fontWeight: FontWeight.w600,
                fontSize: CustomMediaQuery.makeTextSize(context, .4)),
            style: TextStyle(
              color: white,
            ),
            cursorColor: white,
            hint: 'Title',
          ).box.width(CustomMediaQuery.makeWidth(context, .58)).make(),

          //
          VxTextField(
            controller: description,
            height: CustomMediaQuery.makeHeight(context, .1),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Description required';
              }

              return null;
            },
            cursorColor: white,
            hint: 'Description',
            style: TextStyle(
              color: white,
            ),
            maxLine: 2,
            hintStyle: TextStyle(
                color: gray,
                fontWeight: FontWeight.w600,
                fontSize: CustomMediaQuery.makeTextSize(context, .5)),
            borderColor: Colors.transparent,
          ).box.width(CustomMediaQuery.makeWidth(context, .58)).make(),
        ])).px(CustomMediaQuery.makeWidth(context, .02));
  }
}
