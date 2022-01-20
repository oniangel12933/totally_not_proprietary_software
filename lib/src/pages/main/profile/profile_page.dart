import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:involio/src/router/router.gr.dart';
import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;

  Future<void> selectImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          context.router.push(ImageEditorRoute(image: pickedFile!));
          //print(pickedFile.path);
        } else {
          //todo handle error
          context.router.pop();
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
        title: Text(
          "@UserName",
          style: AppFonts.body.copyWith(color: AppColors.involioWhiteShades80),
        ),
        actions: [
          TextButton(
              onPressed: () => null,
              child: Text(
                "Edit",
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
                    "Joined November 2021",
                    style: AppFonts.comments1
                        .copyWith(color: AppColors.involioWhiteShades80),
                  ),
                  icon: Icon(
                    context.involioIcons.mapPin,
                    color: AppColors.involioWhiteShades80,
                  ),
                ),
                Text(
                  "Hey there! You might recognize me from a popular little YouTube channel called Making Money With Luca. I’ve been investing for 10 years and I want to help you understand investing too.",
                  style: AppFonts.comments1
                      .copyWith(color: AppColors.involioWhiteShades60),
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
                    "Duck NFT by DUCKIES",
                    style: AppFonts.comments1
                        .copyWith(color: AppColors.involioWhiteShades80),
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
                  "Bookshelf",
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
                    "This is a Book",
                    style: AppFonts.comments1
                        .copyWith(color: AppColors.involioWhiteShades80),
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
                  "Podcasts",
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
                    "This is a Podcast",
                    style: AppFonts.comments1
                        .copyWith(color: AppColors.involioWhiteShades80),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
