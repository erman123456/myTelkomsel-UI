import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:telkomsel/app/constants/assets.dart';
import 'package:telkomsel/app/constants/text_theme.dart';
import 'package:telkomsel/app/modules/home/views/indihome_view.dart';
import 'package:telkomsel/app/modules/home/views/mobile_view.dart';
import 'package:telkomsel/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabLists = controller.tabLists;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // controller.top.value = screenHeight / 2 - 100;
    // controller.top.value = screenHeight / 2 - 100;
    return Obx(() {
      return Scaffold(
        appBar: _appBar(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.wallpaper),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 20,
                color: Colors.grey.shade300,
              ).boxShadow(
                color: Colors.grey.shade100,
                spreadRadius: 200,
                blurRadius: 100,
              ),
              NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  controller.visible.value =
                      direction == ScrollDirection.reverse ||
                          direction == ScrollDirection.forward;
                  return true;
                },
                child: controller.tabIndex.value % 2 == 0
                    ? MobileView()
                    : IndihomeView(),
              ),
              ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: tabLists.length,
                itemBuilder: (BuildContext context, int index) {
                  final currItem = tabLists[index];
                  return Obx(() {
                    return tabItem(
                      name: currItem.name.toString(),
                      isActive: index == controller.tabIndex.value,
                    );
                  }).gestures(onTap: () => controller.tabChanges(index));
                },
              ).height(50),
              AnimatedPositioned(
                key: controller.keyDraggable,
                top: controller.top.value,
                left: controller.left.value,
                duration:
                    Duration(milliseconds: controller.animationSpeed.value),
                child: Draggable(
                  child: animationIcon(),
                  feedback: animationIcon(),
                  childWhenDragging: Container(),
                  onDragUpdate: (drag) {
                    controller.onDragUpdate(drag);
                  },
                  onDragEnd: (drag) {
                    controller.onDragEnd();
                  },
                ),
              ),
              bottomNav(),
            ],
          ),
        ),
      );
    });
  }

  AppBar _appBar() {
    return AppBar(
      title: [
        Text("Hi Erman",
            style: TelkomselTextStyle.normal.copyWith(color: Colors.black)),
        SvgPicture.asset(
          Assets.lIconlyArrowRight2,
          color: Colors.black,
          width: 15,
          height: 15,
        ).padding(top: 4),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 50,
      leading: Image.asset(
        Assets.assistant1,
        width: 25,
        height: 25,
      ).padding(left: 20),
      actions: [
        SvgPicture.asset(Assets.lIconlySearch,
            color: Colors.black, width: 15, height: 15),
        SvgPicture.asset(Assets.lIconlyNotification,
                color: Colors.black, width: 15, height: 15)
            .padding(horizontal: 16),
        Image.asset(Assets.veronika, width: 25, height: 25).padding(right: 16),
      ],
    );
  }

  Widget tabItem({required String name, required bool isActive}) {
    return Stack(
      children: [
        SizedBox(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(isActive ? 100 : 0),
              ),
            ),
          ),
        ).padding(right: 35),
        SizedBox(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isActive ? 100 : 0),
              ),
            ),
          ),
        ).padding(left: 35),
        AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 500),
          style: TextStyle(
              fontSize: isActive ? 20 : 18,
              color: isActive ? Colors.black : Colors.grey),
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TelkomselTextStyle.normal,
          ).center().width(160),
        ).padding(bottom: 10),
      ],
    ).width(110);
  }

  Widget animationIcon() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: !controller.visible.value ? 1 : 0,
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(6), // Border width
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4), shape: BoxShape.circle),
              child: Image.asset(
                Assets.motorcycle,
                width: 80,
                height: 80,
              ).clipOval(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4), // Border width
            decoration: BoxDecoration(
                color: Colors.blue.shade900, shape: BoxShape.circle),
            child: SvgPicture.asset(
              controller.isHide.value
                  ? controller.left.value > 0
                      ? Assets.lIconlyArrowLeft2
                      : Assets.lIconlyArrowRight2
                  : controller.left.value > 0
                      ? Assets.lIconlyArrowRight2
                      : Assets.lIconlyArrowLeft2,
              width: 20,
              height: 20,
              color: Colors.white,
            ).clipOval(),
          ).gestures(onTap: () => controller.swapHide()).positioned(
              right: controller.left.value > 0 ? 90 : 0, bottom: 30),
        ],
      ).width(125),
    );
  }

  Widget bottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          ClipRect(
            // <-- clips to the 200x200 [Container] below
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 30.0,
                  sigmaY: 30.0,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: [
                    imageIcon(Assets.home, "Beranda", isActive: true),
                    imageIcon(Assets.suitcase, "Belanja"),
                    SizedBox(
                      width: 40,
                    ),
                    imageIcon(Assets.reward, "Reward"),
                    imageIcon(Assets.rocket, "Jelajah"),
                  ]
                      .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
                      .padding(top: 10)
                      .height(80),
                )),
          ).positioned(bottom: 0, right: 0, left: 0),
          menuIcon(),
        ],
      ).height(130),
    );
  }

  Widget menuIcon() {
    return Column(
      children: [
        Stack(
          children: [
            SvgPicture.asset(
              Assets.telkomselBorder,
              height: 60,
              width: 60,
            ).center(),
          ],
        ),
        Text("Menu", style: TelkomselTextStyle.h7)
            .padding()
            .center()
            .padding(top: 5),
      ],
    ).padding(top: 10).gestures(
        onTap: () => Get.dialog(menuPopUp(), barrierDismissible: false, useSafeArea: false));
  }

  Widget svgIcon(String icon, String name, {bool isActive = false}) {
    return [
      SvgPicture.asset(
        icon,
        width: 25,
        color: isActive ? Colors.black : Colors.grey.shade600,
      ),
      Text(
        name,
        style: TelkomselTextStyle.h7.copyWith(
          color: isActive ? Colors.black : Colors.grey.shade600,
        ),
      ).flexible(),
    ].toColumn();
  }

  Widget imageIcon(String icon, String name, {bool isActive = false}) {
    return [
      Image.asset(
        icon,
        width: 20,
        color: isActive ? Colors.black : Colors.grey.shade600,
      ),
      Text(
        name,
        style: TelkomselTextStyle.h7.copyWith(
          color: isActive ? Colors.black : Colors.grey.shade600,
        ),
      ).flexible(),
    ].toColumn();
  }

  Widget menuPopUp() {
    final lists = controller.card5List;
    return ClipRect(
      // <-- clips to the 200x200 [Container] below
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          color: Colors.white.withOpacity(0.7),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(children: [
                [
                  Text(
                    "Mobile",
                    style: TelkomselTextStyle.h5,
                  ),
                  SvgPicture.asset(
                    Assets.lIconlyArrowRight2,
                    width: 15,
                    height: 15,
                  ),
                ]
                    .toRow(crossAxisAlignment: CrossAxisAlignment.center),
                GridView.count(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.8,
                    crossAxisCount: 4,
                    scrollDirection: Axis.vertical,
                    children: [
                      for (var i = 0; i < lists.length; i++) ...[
                        [
                          Image.asset(
                            lists[i].icon,
                            width: 30,
                            height: 30,
                          ).padding(bottom: 10),
                          Text(
                            lists[i].title,
                            textAlign: TextAlign.center,
                            style: TelkomselTextStyle.h6Bold,
                          ).width(80).flexible(),
                        ].toColumn(),
                      ]
                    ])
              ])
                  .padding(all: 20)
                  .backgroundColor(Colors.white)
                  .clipRRect(all: 10)
                  .padding(bottom: 20),
              SvgPicture.asset(
                Assets.btnCancel,
                height: 60,
                width: 60,
              ).ripple().gestures(onTap: () => Get.back()),
            ],
          ).center().padding(top: 150, horizontal: 5),
        ),
      ),
    ).clipRRect(all: 16);
  }
}
