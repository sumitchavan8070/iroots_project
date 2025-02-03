import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iroots/src/ui/dashboard/student/components/AdminCard.dart';
import 'package:iroots/src/utility/constant/asset_path.dart';

class AdminCardListWidget extends StatefulWidget {
  const AdminCardListWidget({super.key});

  @override
  State<AdminCardListWidget> createState() => _AdminCardListWidgetState();
}

class _AdminCardListWidgetState extends State<AdminCardListWidget> {
  final ScrollController _scrollController = ScrollController();
  final RxInt _currentIndex = 0.obs;
  final List<Widget> textItems = [
    const AdminCard(
      heading: "Total Students ",
      headingCount: "1500",
      title: "New Admissions",
      titleCount: "1480",
      subTitle: "Absent",
      subTitleCount: "20",
      bgImage: AssetPath.adminBgOne,
      cardImage: AssetPath.onePNG,
    ),
     const AdminCard(
      heading: "Total Staff",
      headingCount: "80",
      title: "New Join",
      titleCount: "40",
      subTitle: "Absent",
      subTitleCount: "05",
      bgImage: AssetPath.adminBgTwo,
      cardImage: AssetPath.twoPNG,
    ),
    const AdminCard(
      heading: "Free Collection",
      headingCount: "\$ 500",
      title: "New Total",
      titleCount: "\$ 1200",
      subTitle: "",
      subTitleCount: "",
      bgImage: AssetPath.adminBgThree,
      cardImage: AssetPath.threePNG,
    ),
    const AdminCard(
      heading: "Applied TC",
      headingCount: "05",
      title: "",
      titleCount: "",
      subTitle: "",
      subTitleCount: "",
      bgImage: AssetPath.adminBgFour,
      cardImage: AssetPath.fourPNG,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final screenWidth = MediaQuery.of(context).size.width;
      final itemWidth = screenWidth * 0.85 + 24;
      final value = (_scrollController.offset / itemWidth).round();
      final index = value.clamp(0, textItems.length - 1);

      if (_currentIndex.value != index) {
        _currentIndex.value = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 160, // Set the height for the ListView
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            itemCount: textItems.length,
            itemBuilder: (context, index) {
              final child = textItems[index];
              return Padding(
                padding: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: child,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            textItems.length, // Directly use textItems.length
            (index) => Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentIndex.value == index ? 22 : 8,
                  height: 6,
                  // Keep height constant for indicators
                  decoration: BoxDecoration(
                    color: _currentIndex.value == index
                        ? Colors.blueGrey
                        : Colors.grey.withOpacity(0.3),
                    boxShadow: [], // No shadow since showShadow was false
                    borderRadius: BorderRadius.circular(12)
                  ),

                  // AppBoxDecoration.getBoxDecoration(
                  //   color: _currentIndex.value == index
                  //       ? Colors.blueGrey
                  //       : Colors.grey.withOpacity(0.3),
                  //   showShadow: false,
                  // ),
                )),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
