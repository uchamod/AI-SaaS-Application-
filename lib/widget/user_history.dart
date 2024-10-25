import 'package:ai_saas_application/constant/colors.dart';
import 'package:ai_saas_application/constant/textstyles.dart';
import 'package:ai_saas_application/model/data_moedel.dart';
import 'package:ai_saas_application/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class UserHistory extends StatefulWidget {
  const UserHistory({super.key});

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DataMoedel>>(
      stream: FirestoreServices().getConvasationData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              "No Data Found",
              style: Typhography().body,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "${snapshot.error}",
              style: Typhography().body,
            ),
          );
        }
        final historyData = snapshot.data;
        return ListView.builder(
          itemCount: historyData!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = historyData[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.25),
                    offset: const Offset(2, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ],
                color: secondaryColor,
              ),
              child: Column(
                children: [
                  //image url
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 300,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                  ),

                  //copy text
                  Padding(
                    padding: const EdgeInsets.all(commonPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recognized Text",
                          style: Typhography().body.copyWith(color: greyColor),
                        ),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/copy.svg",
                            colorFilter:
                                ColorFilter.mode(greyColor, BlendMode.srcIn),
                            height: 24,
                            width: 24,
                            semanticsLabel: 'My SVG Image',
                          ),
                        ),
                      ],
                    ),
                  ),

                  //recognaized text
                  Padding(
                    padding: const EdgeInsets.all(commonPadding),
                    child: Column(
                      children: [
                        Text(
                          item.convasationData,
                          style: Typhography().body.copyWith(color: greyColor),
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: commonPadding,
                        ),
                        Text(
                          DateFormat.yMMMd().format(item.convasationDate),
                          style: Typhography()
                              .body
                              .copyWith(color: greyColor.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}