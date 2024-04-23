import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkomsel/app/constants/assets.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final up = false.obs;
  final down = false.obs;
  final visible = false.obs;

  final GlobalKey keyDraggable = GlobalKey();
  final top = 322.0.obs;
  final left = 280.0.obs;
  final animationSpeed = 0.obs;
  final isHide = false.obs;
  final initialPage = 0.obs;
  final pageController = PageController(initialPage: 0, keepPage: true);
  final card4Index = 0.obs;
  final initialTab = 0.obs;

  final size = 50.0.obs;
  final tabIndex = 0.obs;
   List<TabItem> tabLists = [
     TabItem(0, "Mobile"),
     TabItem(1, "Indihome"),
     TabItem(2, "One"),
     TabItem(3, "Video"),
   ];

  List<IconCard> card5List = [
    IconCard(Assets.vespa, "Jelajah Nusantara", "Yuk Jelajahi Nusantara dan dapatin hadiah"),
    IconCard(Assets.game, "GameHub", "Jelajahi berbagai game seru di GameHub dan klaim rewardnya!"),
    IconCard(Assets.hero, "Jumping Hero", "Lewati rintangan dan terbangkan heromu!"),
    IconCard(Assets.singer, "Melody Rush", "Main sambil diiringi lagu favoritmu"),
    IconCard(Assets.trumpet, "Terompet Keriaan", "Kumpulkan terompetnya!"),
    IconCard(Assets.game, "Mini Game Last Defender", "Ajak teman tanding di versus model"),
    IconCard(Assets.girl, "Tenya Veronika", "Kamu bisa nanya apapun tentang telkomsel disini loh!"),
    IconCard(Assets.video, "Jelajah Video", "Tonton berbagai film dan serial pilihan"),
    IconCard(Assets.music, "Jelajah Musik", "Dengan musik hits favoritmu tanpa kouta"),
  ];



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onDragUpdate(drag) {
    top.value = top.value + drag.delta.dy;
    left.value = left.value + drag.delta.dx;
  }

  void onDragEnd() {
    animationSpeed.value = 500;
    if (!isHide.value) {
      left.value = left.value > 178 ? 280 : -15;
    } else {
      left.value = left.value > 178 ? 340 : -60;
    }
  }

  void swapHide() {
    if (isHide.value) {
      left.value = left.value < 0 ? -15 : 280;
    } else {
      left.value = left.value > 0 ? 340 : -60;
    }
    isHide.value = !isHide.value;
  }

  void onChange(i) {
    initialPage.value = i;
  }
  void onChangeTab(i) {
    initialTab.value = i;
  }

    void increment() => count.value++;
  void tabChanges(index) {
    tabIndex.value = index;
  }

  void onTabChanged(int index) {
    card4Index.value = index;
  }
}

// for clas TabItem
class TabItem {
  const TabItem(this.index, this.name);
  final int index;
  final String name;
}

// for clas AssetIcon
class AssetIcon {
  const AssetIcon(this.icon, this.name);
  final String icon;
  final String name;
}

// for Card5
class IconCard {
  const IconCard(this.icon, this.title, this.desc);
  final String icon;
  final String title;
  final String desc;
}


