import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_streaming_app/screens/pages/broadcast_screen.dart';
import 'package:flutter_streaming_app/services/resources/firestore_methods.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:flutter_streaming_app/utils/utils.dart';
import 'package:flutter_streaming_app/widgets/custom_button.dart';
import 'package:flutter_streaming_app/widgets/custom_textfield.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final TextEditingController _titleController = TextEditingController();
  Uint8List? image;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  goLiveStream() async {
    String channelId = await FirestoreMethods()
        .startLiveStream(context, _titleController.text, image);

    if (channelId.isNotEmpty) {
      showSnackBar(context, 'Livestream has started successfully!');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BroadCastScreen(
            channelId: channelId,
            isBroadCaster: true,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundIndex,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uint8List? pickedImage = await pickImage();
                        if (pickedImage != null) {
                          setState(() {
                            image = pickedImage;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 20.0,
                        ),
                        child: image != null
                            ? SizedBox(
                                height: 300,
                                child: Image.memory(image!),
                              )
                            : DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: borderColor,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: backgroundContain.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        color: outlineColor,
                                        size: 37,
                                      ),
                                      const Gap(10),
                                      Text(
                                        'Select your thumbnail',
                                        style: GoogleFonts.sora(
                                          fontSize: 15,
                                          color: outlineColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.bold,
                            color: outlineColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CustomTextField(
                            controller: _titleController,
                            hintText: '',
                            obscureText: false,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: CustomButton(
                    onTap: goLiveStream,
                    text: 'Go Live!',
                    textColor: buttonColor,
                    backgroundColor: filledColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
