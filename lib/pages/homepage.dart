import 'package:ai_saas_application/constant/colors.dart';
import 'package:ai_saas_application/constant/textstyles.dart';
import 'package:ai_saas_application/widget/image_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isImagePicked = false;
  String? imagePath;
  bool isProgressing = false;
  late TextRecognizer textRecognizer;
  String recognizeText = "";
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

  //Prosses and text regognition
  void _textProsser() async {
    if (!_isImagePicked) {
      return null;
    }
    setState(() {
      isProgressing = true;
      recognizeText = "";
    });
    try {
      InputImage inputImage = InputImage.fromFilePath(imagePath!);
      RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      //extract text from image
      for (TextBlock textBlock in recognizedText.blocks) {
        for (TextLine textLine in textBlock.lines) {
          recognizeText += "${textLine.text}\n";
        }
      }
      print(recognizeText);
    } catch (err) {
      print(err.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            "Unclear or No Text Image",
            style: Typhography().body,
          ),
        ),
      );
      if (!mounted) {
        return;
      }
    } finally {
      setState(() {
        isProgressing = false;
        _isImagePicked = false;
      });
    }
  }

  //copy recogniezd text to clipboard
  void _copyToClipboard() async {
    if (recognizeText.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: recognizeText));
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: secondaryColor,
          content: Text(
            "Text copy to clipboard!",
            style: Typhography().body.copyWith(color: terneryColor),
          ),
        ),
      );
    }
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
  void initState() {
    textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    super.initState();
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
            //select image and procsss button
            ElevatedButton(
              onPressed: () {
                if (_isImagePicked) {
                  _textProsser();
                } else {
                  _showModelBottomSheet();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isProgressing
                      ? const CircularProgressIndicator(
                          color: secondaryColor,
                        )
                      : SvgPicture.asset(
                          "assets/images.svg",
                          colorFilter: const ColorFilter.mode(
                              secondaryColor, BlendMode.srcIn),
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
            //copy section
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
                InkWell(
                  onTap: _copyToClipboard,
                  child: SvgPicture.asset(
                    "assets/copy.svg",
                    colorFilter:
                        const ColorFilter.mode(terneryColor, BlendMode.srcIn),
                    height: 24,
                    width: 24,
                    semanticsLabel: 'My SVG Image',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: verticalPadding,
            ),
            //show recognized text
            if (!isProgressing) ...[
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        Flexible(
                          child: SelectableText(recognizeText.isEmpty
                              ? "No Recognized Text"
                              : recognizeText),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
