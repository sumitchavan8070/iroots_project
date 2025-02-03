import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';

class AdminCard extends StatelessWidget {
  final String? headingCount;
  final String? titleCount;
  final String? subTitleCount;
  final String? bgImage;
  final String? cardImage;
  final String? heading;
  final String? title;
  final String? subTitle;

  const AdminCard({
    super.key,
    required this.headingCount,
    required this.titleCount,
    required this.subTitleCount,
    this.bgImage,
    this.cardImage,
    this.title,
    this.heading,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      clipBehavior: Clip.hardEdge,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.20,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              bgImage ?? AssetPath.adminBgOne,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Shadow color
                                spreadRadius: 12, // Spread of the shadow
                                blurRadius: 12, // Blur effect
                                offset: const Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4), // Optional: for rounded corners
                          ),
                          child: Image.asset(
                            cardImage ?? "assets/icons/admin_card_bg.png",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              heading ?? "Total Students",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              headingCount.toString(),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(title ?? "New Admission", titleCount.toString()),
                    _buildInfoRow(subTitle ?? "Absent", subTitleCount.toString()),
                  ],
                ),
                Image.asset(
                  'assets/academic/admin_card_bg.png',
                  height: 114,
                  width: 132,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              fontSize: isBold ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
