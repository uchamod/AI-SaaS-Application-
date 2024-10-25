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
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final historyData = snapshot.data;

        if (historyData == null || historyData.isEmpty) {
          return const Center(
            child: Text('No Data found.'),
          );
        }

        return SingleChildScrollView(
          child: ListView.builder(
            itemCount: historyData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = historyData[index];
              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: commonPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(0.25),
                      offset: const Offset(2, 4),
                      blurRadius: 3,
                      spreadRadius: 0,
                    )
                  ],
                  color: secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      commonPadding, 0, commonPadding, commonPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //image url
                      Image.network(
                        item.imageUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 180,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recognized Text",
                            style: Typhography().body.copyWith(
                                color: terneryColor,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/copy.svg",
                              colorFilter: const ColorFilter.mode(
                                  terneryColor, BlendMode.srcIn),
                              height: 24,
                              width: 24,
                              semanticsLabel: 'My SVG Image',
                            ),
                          ),
                        ],
                      ),

                      //recognaized text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.convasationData.length > 200
                                  ? "${item.convasationData.substring(0, 200)}..."
                                  : item.convasationData,
                              style: Typhography()
                                  .body
                                  .copyWith(color: terneryColor),
                            ),
                          ),
                        ],
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
                      const SizedBox(
                        height: commonPadding,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
