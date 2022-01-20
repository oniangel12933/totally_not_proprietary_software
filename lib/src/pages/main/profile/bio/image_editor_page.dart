import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:extended_image/extended_image.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

class ImageEditorPage extends StatefulWidget {
  final XFile image;

  const ImageEditorPage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  _ImageEditorPageState createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: AppFonts.bodySmall
                .copyWith(color: AppColors.involioWhiteShades80),
          ),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Apply",
              style: AppFonts.bodySmall
                  .copyWith(color: AppColors.involioWhiteShades80),
            ),
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20)),
          )
        ],
      ),
      body: Center(
        child: Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Image.file(File(widget.image.path)),
        ),
      ),
    );
  }
}
