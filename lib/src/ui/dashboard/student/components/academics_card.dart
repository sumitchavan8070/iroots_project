import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';

class AcademicsCard extends StatefulWidget {
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final String? image6;

  final String? icon1;
  final String? icon2;
  final String? icon3;
  final String? icon4;
  final String? icon5;
  final String? icon6;
  final void Function(int) onPressed; // Function that takes an int parameter

  const AcademicsCard({
    super.key,
    required this.onPressed,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6, this.icon1, this.icon2, this.icon3, this.icon4, this.icon5, this.icon6,
  });

  @override
  State<AcademicsCard> createState() => _AcademicsCardState();
}

class _AcademicsCardState extends State<AcademicsCard> {
  late List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      {"text": widget.icon1 ?? "Payment", "icon": widget.image1 ?? AssetPath.payment},
      {"text":widget.icon2 ??  "Attendance", "icon": widget.image2 ?? AssetPath.attendance},
      {"text":widget.icon3 ?? "Result", "icon": widget.image3 ?? AssetPath.result},
      {"text": widget.icon4 ?? "Homework", "icon": widget.image4 ?? AssetPath.homework},
      {"text":widget.icon5 ??  "Library", "icon": widget.image5 ?? AssetPath.library},
      {"text":widget.icon6 ??  "Time Table", "icon": widget.image6 ?? AssetPath.timetable},
    ];
  }

  Widget _getImage(String path) {
    if (path.contains(".png")) {
      return Image.asset(path);
    }
    if (path.contains(".svg")) {
      return SvgPicture.asset(
        path,
        height: 24,
        width: 24,
      );
    }
    return Image.asset(path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Academics",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                "View All",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF1575FF).withOpacity(0.4),
                  color: const Color(0xFF1575FF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 20,
              childAspectRatio: 2.8,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  widget.onPressed(index); // Pass the index to the callback
                  debugPrint("Tapped index: $index");
                },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 32,
                        padding: const EdgeInsets.all(6),
                        color: const Color(0xFF1575FF),
                        child: _getImage(item["icon"]),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          item["text"],
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}