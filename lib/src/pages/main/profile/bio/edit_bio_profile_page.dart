import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:involio/src/router/router.gr.dart';
import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

class EditBioProfilePage extends StatefulWidget {
  const EditBioProfilePage({Key? key}) : super(key: key);

  @override
  _EditBioProfilePageState createState() => _EditBioProfilePageState();
}

class _EditBioProfilePageState extends State<EditBioProfilePage> {
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;

  Future<void> selectImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          context.router.push(ImageEditorRoute(image: pickedFile));
          //print(pickedFile.path);
        } else {
          //todo handle error
        }
      });
    } catch (error) {
      setState(() {
        _pickImageError = error;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                context.router.pop();
              },
              child: Text(
                "Save",
                style: AppFonts.bodySmall
                    .copyWith(color: AppColors.involioWhiteShades80),
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      const AppCurrentUserProfileImageBuilder(
                        size: AppImageSize.xlarge,
                      ),
                      Container(
                          height: 130,
                          width: 130,
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              context.involioIcons.plusCircle,
                              color: AppColors.involioBlue,
                              size: 20,
                            ),
                            onPressed: () {
                              selectImage(ImageSource.gallery);
                            },
                          ))
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () => null,
                  label: Text(
                    "Joined November 2021",
                    style: AppFonts.body.copyWith(color: AppColors.involioBlue),
                  ),
                  icon: Icon(
                    context.involioIcons.profile,
                    color: AppColors.involioBlue,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => null,
                  label: Text(
                    "Location",
                    style: AppFonts.comments1
                        .copyWith(color: AppColors.involioBlackShades10),
                  ),
                  icon: Icon(
                    context.involioIcons.mapPin,
                    color: AppColors.involioWhiteShades80,
                  ),
                ),
                Text(
                  "Click here to enter your name.",
                  style: AppFonts.comments1
                      .copyWith(color: AppColors.involioWhiteShades60),
                  maxLines: 3,
                  softWrap: true,
                ),
                Text(
                  "Click here to create your bio.",
                  style: AppFonts.comments1
                      .copyWith(color: AppColors.involioBlackShades10),
                  maxLines: 3,
                  softWrap: true,
                )
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.involioLineSeparator),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite Investment",
                  style: AppFonts.headline6
                      .copyWith(color: AppColors.involioWhiteShades100),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.involioFillFormBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(
                    "ex. ETH 2018",
                    style: AppFonts.body
                        .copyWith(color: AppColors.involioFillFormText),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.involioLineSeparator),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite Books",
                  style: AppFonts.headline6
                      .copyWith(color: AppColors.involioWhiteShades100),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.involioFillFormBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(
                    "Enter your favorite books here",
                    style: AppFonts.body
                        .copyWith(color: AppColors.involioFillFormText),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Add up to 5 books. Remove by hitting ‘x’ on tags.",
                  style: AppFonts.notForFinancialAdvice
                      .copyWith(color: AppColors.involioWhiteShades100),
                )
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.involioLineSeparator),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite Podcasts",
                  style: AppFonts.headline6
                      .copyWith(color: AppColors.involioWhiteShades100),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.involioFillFormBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(
                    "Enter your favorite podcasts here",
                    style: AppFonts.body
                        .copyWith(color: AppColors.involioFillFormText),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Add up to 5 podcasts. Remove by hitting ‘x’ on tags.",
                  style: AppFonts.notForFinancialAdvice
                      .copyWith(color: AppColors.involioWhiteShades100),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
