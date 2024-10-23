import 'package:ai_saas_application/constant/colors.dart';
import 'package:ai_saas_application/constant/textstyles.dart';
import 'package:ai_saas_application/widget/image_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isImagePicked = false;
  String? imagePath;
  //File? _imageFile;
  //pick image
  Future<void> imagePicker(ImageSource source) async {
    ImagePicker imgPicker = ImagePicker();
    final image = await imgPicker.pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      _isImagePicked = true;
      imagePath = image.path;
    });
  }

  void _showModelBottomSheet() {
    showModalBottomSheet(
      elevation: 1,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(
                  "From Gallery",
                  style: Typhography().body.copyWith(color: terneryColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  imagePicker(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(
                  "Take a Photo",
                  style: Typhography().body.copyWith(color: terneryColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  imagePicker(ImageSource.camera);
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Text Recognizer", style: Typhography().title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: commonPadding),
        child: Column(
          children: [
            //show image
            ImageBox(
              imagePath: imagePath,
            ),
            const SizedBox(
              height: commonPadding,
            ),
            //select image
            ElevatedButton(
              onPressed: () {
                _showModelBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/images.svg",
                    colorFilter:
                        const ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                    height: 24,
                    width: 24,
                    semanticsLabel: 'My SVG Image',
                  ),
                  _isImagePicked
                      ? Text(
                          "Process Image",
                          style: Typhography().title,
                        )
                      : Text(
                          "Select an Image",
                          style: Typhography().title,
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: horizontalPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Text",
                  style: Typhography().title.copyWith(color: terneryColor),
                ),
                SvgPicture.asset(
                  "assets/copy.svg",
                  colorFilter:
                      const ColorFilter.mode(terneryColor, BlendMode.srcIn),
                  height: 24,
                  width: 24,
                  semanticsLabel: 'My SVG Image',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
