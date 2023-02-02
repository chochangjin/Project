import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/tab/tab_home.png',
      selectedImagePath: 'assets/tab/tab_home_2.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/tab/tab_map.png',
      selectedImagePath: 'assets/tab/tab_map_2.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/tab/tab_edu.png',
      selectedImagePath: 'assets/tab/tab_edu_2.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/tab/tab_point.png',
      selectedImagePath: 'assets/tab/tab_point_2.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
