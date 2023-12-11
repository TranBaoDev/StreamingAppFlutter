import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/services/models/livestream.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:flutter_streaming_app/widgets/loading_indicator.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewfeedScreen extends StatefulWidget {
  const NewfeedScreen({super.key});

  @override
  State<NewfeedScreen> createState() => _NewfeedScreenState();
}

class _NewfeedScreenState extends State<NewfeedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(
          top: 10,
        ),
        child: Column(
          children: [
            Text(
              'Live Users',
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: backgroundColor,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('livestream')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator();
                }

                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        LiveStream post = LiveStream.fromMap(
                            snapshot.data.docs[index].data());
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: size.height * 0.1,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(post.image),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.title,
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: outlineColor),
                                    ),
                                    Text(
                                      post.username,
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.w600,
                                          color: outlineColor),
                                    ),
                                    Text(
                                      '${post.viewers} watching',
                                      style:
                                          GoogleFonts.rubik(color: outlineColor),
                                    ),
                                    Text(
                                      'Started ${timeago.format(post.startedAt.toDate())}',
                                      style: const TextStyle(
                                        color: outlineColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(15),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Symbols.more_vert,
                                    color: outlineColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
