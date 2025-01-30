import 'package:flutter/material.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';


class AcademicsCard extends StatefulWidget {
  final void Function(int) onPressed; // Function that takes an int parameter


  const AcademicsCard({super.key, required this.onPressed});

  @override
  State<AcademicsCard> createState() => _AcademicsCardState();
}

class _AcademicsCardState extends State<AcademicsCard> {
  final List<Map<String, dynamic>> items = [
    {"text": "Payment", "icon": AssetPath.payment},
    {"text": "Attendance", "icon": AssetPath.attendance},
    {"text": "Result", "icon": AssetPath.result},
    {"text": "Homework", "icon": AssetPath.homework},
    {"text": "Library", "icon": AssetPath.library},
    {"text": "Time Table", "icon": AssetPath.timetable},
  ];

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
                style:
                    Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                "View All",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF1575FF).withOpacity(0.4),
                    color: const Color(0xFF1575FF)),
              )
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
                 widget.onPressed(index);
                 debugPrint("here is the taped index ");
               },
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 32,
                        padding: const EdgeInsets.all(6),
                        color: const Color(0xFF1575FF),
                        child: Image.asset(item["icon"]),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item["text"],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                      )
                    ],
                  ),
                ),
              );

              return Container(
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
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]["icon"],
                      color: const Color(0xFF1575FF),
                      size: 30,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      items[index]["text"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
