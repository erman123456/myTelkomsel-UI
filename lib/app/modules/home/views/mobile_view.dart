import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:telkomsel/app/constants/assets.dart';
import 'package:telkomsel/app/constants/text_theme.dart';
import 'package:telkomsel/app/modules/home/controllers/home_controller.dart';

class MobileView extends GetView<HomeController> {
  const MobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          _card1().padding(horizontal: 16, bottom: 10),
          _card2().padding(horizontal: 16, bottom: 10),
          _card3().padding(horizontal: 16, bottom: 10),
          _card4().padding(horizontal: 16, bottom: 10),
          _card5(),
        ],
      ),
    ).padding(top: 16);
  }

  Widget _card1() {
    return _cardBlur(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("0812 6813 7084", style: TelkomselTextStyle.h7),
                      Text(
                        "PraBayar",
                        style: TelkomselTextStyle.h7.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ).padding(all: 5).clipRRect(all: 5).decorated(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                    ],
                  ),
                  Text("Aktif sampai 30 Desember 2024",
                      style: TelkomselTextStyle.h7),
                ],
              ),
              SvgPicture.asset(
                Assets.lIconlyArrowDown2,
                width: 15,
                height: 15,
              ).padding(all: 5),
            ],
          ),
          Row(
            children: [
              Text("100 Poin GOLD",
                      textAlign: TextAlign.center, style: TelkomselTextStyle.h7)
                  .width(50),
              Image.asset(Assets.trophy, width: 40, height: 40),
            ],
          )
        ],
      ).padding(all: 20),
    );
  }

  Widget _card2() {
    return _cardBlur(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Pulsa", style: TelkomselTextStyle.h7),
                  Text("Rp100.000", style: TelkomselTextStyle.h5)
                      .padding(top: 5, bottom: 10),
                  Text("Isi Pulsa", style: TelkomselTextStyle.h6Red),
                ],
              ),
              SizedBox(width: 2, height: 60)
                  .backgroundColor(Colors.white)
                  .padding(vertical: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("MyVocher", style: TelkomselTextStyle.h7),
                  Text("Rp50.000", style: TelkomselTextStyle.h5)
                      .padding(top: 5, bottom: 10),
                  Text("Lihat Detail", style: TelkomselTextStyle.h6Red),
                ],
              ),
            ],
          ).padding(vertical: 20),
          Divider(thickness: 2, color: Colors.white38),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              quotaCircle("Internet", "10 GB"),
              quotaCircle("Aplikasi", "20 GB"),
              quotaCircle("Telepon", "10 GB"),
              quotaCircle("Sms", "10 GB"),
            ],
          ).padding(vertical: 10),
          Divider(thickness: 2, color: Colors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Riwayat Transaksi", style: TelkomselTextStyle.h6Red),
              SizedBox(width: 2, height: 20)
                  .backgroundColor(Colors.white)
                  .padding(vertical: 5, right: 20),
              Text("Detail Kuota", style: TelkomselTextStyle.h6Red),
            ],
          ).padding(bottom: 10)
        ],
      ),
    );
  }

  Widget _card3() {
    final List<String> imgList = ["1", "2"];
    return _cardBlur(
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 120,
                aspectRatio: 1,
                viewportFraction: 1,
                initialPage: controller.initialPage.value,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) => controller.onChange(index)),
            items: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  imageIcon(Assets.globe, "Beli Paket"),
                  imageIcon(Assets.telegram, "Kirim Hadiah"),
                  imageIcon(Assets.stamp, "Stamp Berhadiah"),
                  imageIcon(Assets.vespa, "Jelajahi Nusantara"),
                ],
              ).padding(vertical: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  imageIcon(Assets.voucher, "Pulsa"),
                  imageIcon(Assets.stamp, "IBL Corner"),
                  imageIcon(Assets.voucher, "Promo"),
                  imageIcon(Assets.globe, "Daftar Halo"),
                ],
              ).padding(vertical: 20),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => controller.onChange(entry),
                child: Container(
                  width: 10,
                  height: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.initialPage == entry.key
                          ? Colors.black
                          : Colors.grey),
                ),
              );
            }).toList(),
          ).padding(top: 90)
        ],
      ),
    );
  }

  Widget _card4() {
    final List<String> tabLists = [
      "Semua",
      "Pembelian Terakhir",
      "Promo Hanya Untukmu ",
      "Kamu Banget Nih!",
      "Super Seru",
      "Combo SAKTI",
      "Paket Bundling Kesehatan"
    ];
    return _cardBlur(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Rekomendasi Untukmu", style: TelkomselTextStyle.normal),
              Spacer(),
              Text(
                "Lihat Semua",
                style: TelkomselTextStyle.h7Red,
              ),
              SvgPicture.asset(
                Assets.lIconlyArrowRight2,
                color: Colors.red,
                width: 15,
                height: 15,
              ).padding(top: 2),
            ],
          ).padding(horizontal: 16, top: 16),
          ListView.builder(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: tabLists.length,
            itemBuilder: (BuildContext context, int index) {
              final currItem = tabLists[index];
              return Obx(() {
              final initialTab = controller.initialTab.value;
                return Text(currItem,
                        style: TelkomselTextStyle.normal.copyWith(
                            color: index == initialTab
                                ? Colors.white
                                : Colors.grey))
                    .padding(all: 10)
                    .backgroundColor(
                        index == initialTab ? Colors.black : Colors.white)
                    .clipRRect(all: 20)
                    .gestures(onTap: () => controller.onChangeTab(index))
                    .padding(right: 5);
              });
            },
          ).height(35).padding(vertical: 10, left: 16),
          _card4Item(
              name: "PROMO! PAKET Internet + 200MB",
              value: "1.2 GB | 1 Hari",
              price: "Rp6.000"),
          _card4Item(
                  name: "Paket Harian",
                  value: "1 GB | 1 Hari",
                  price: "Rp6.500")
              .padding(vertical: 10),
          _card4Item(
                  name: "OMG Special",
                  value: "4.5 GB | 7 Hari",
                  price: "Rp15.500",
                  isBuyAgain: false)
              .padding(bottom: 20),
        ],
      ),
    );
  }

  Widget _card4Item(
      {required String name,
      required String value,
      required String price,
      isBuyAgain = true}) {
    return Stack(children: [
      Visibility(
        visible: isBuyAgain,
        child: Text(
          "Beli Lagi",
          style: TelkomselTextStyle.normal.copyWith(color: Colors.white),
        )
            .padding(all: 5)
            .backgroundColor(Colors.red.shade600)
            .clipRRect(bottomRight: 5, bottomLeft: 5)
            .padding(left: 16),
      ),
      [
        Text(name, style: TelkomselTextStyle.normal)
            .padding(top: isBuyAgain ? 30 : 0, bottom: 5),
        [
          Text(value, style: TelkomselTextStyle.h6Bold),
          Text(price, style: TelkomselTextStyle.h6Bold),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).padding(all: 16),
    ]).backgroundColor(Colors.white).clipRRect(all: 10).padding(horizontal: 16);
  }

  Widget _card5() {
    final itemList = controller.card5List;
    return _cardBlur(
      withRadius: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pojok Seru", style: TelkomselTextStyle.h6Bold).padding(all: 16),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: itemList.length,
            itemBuilder: (BuildContext context, int index) {
              final currItem = itemList[index];
              return _card5Item(
                icon: currItem.icon,
                title: currItem.title,
                desc: currItem.desc,
              ).padding(bottom: 10);
            },
          ).height(110.0 * itemList.length),
        ],
      ),
    );
  }

  Widget _card5Item(
      {required String icon,
      required String title,
      required String desc,
      isBuyAgain = true}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Image.asset(icon, width: 40, height: 40).padding(bottom: 10).center(),
      [
        Text(title, style: TelkomselTextStyle.normal).padding(bottom: 10),
        Text(desc, style: TelkomselTextStyle.h7.copyWith(color: Colors.grey))
            .width(200),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      SvgPicture.asset(
        Assets.lIconlyArrowRight2,
        color: Colors.black,
        width: 15,
        height: 15,
      ),
    ])
        .padding(vertical: 20, horizontal: 16)
        .backgroundColor(Colors.white)
        .clipRRect(all: 10)
        .padding(horizontal: 16);
  }

  Widget imageIcon(String icon, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(icon, width: 30, height: 30).padding(bottom: 10),
        Text(name, style: TelkomselTextStyle.h7),
      ],
    );
  }

  Widget quotaCircle(String name, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: TelkomselTextStyle.h7,
          textAlign: TextAlign.center,
        ).padding(bottom: 10),
        Text(
          value,
          style: TelkomselTextStyle.h7Bold,
          textAlign: TextAlign.center,
        )
            .center()
            .width(25)
            .padding(all: 15)
            .backgroundColor(Colors.white)
            .clipOval()
      ],
    );
  }

  Widget _cardBlur({required Widget child, withRadius = true}) {
    return ClipRect(
      // <-- clips to the 200x200 [Container] below
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30,
          sigmaY: 30,
        ),
        child: Container(
          color: Colors.white.withOpacity(0.7),
          child: child,
        ),
      ),
    ).clipRRect(all: withRadius ? 16 : 0);
  }
}
