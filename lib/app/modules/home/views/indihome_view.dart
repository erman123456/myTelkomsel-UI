import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:telkomsel/app/constants/assets.dart';
import 'package:telkomsel/app/constants/text_theme.dart';
import 'package:telkomsel/app/modules/home/controllers/home_controller.dart';

class IndihomeView extends GetView<HomeController> {
  const IndihomeView({Key? key}) : super(key: key);

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
              Text("1112020101010", style: TelkomselTextStyle.h7),
              Text(
                "Indihome",
                style: TelkomselTextStyle.h7.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
                  .padding(vertical: 5, horizontal: 10)
                  .backgroundColor(Colors.white)
                  .clipRRect(all: 10)
                  .padding(horizontal: 5),
              SvgPicture.asset(
                Assets.lIconlyArrowDown2,
                width: 15,
                height: 15,
              ),
            ],
          ),
        ],
      ).padding(all: 16),
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
                  Text("Penggunaan Bulan ini", style: TelkomselTextStyle.h7),
                  Text("100 GB", style: TelkomselTextStyle.h5)
                      .padding(top: 5, bottom: 10),
                  Text("Lihat Detail", style: TelkomselTextStyle.h6Red),
                ],
              ),
              SizedBox(width: 2, height: 60)
                  .backgroundColor(Colors.white)
                  .padding(vertical: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Total Tagihan", style: TelkomselTextStyle.h7),
                  Text("Rp 310.000", style: TelkomselTextStyle.h5)
                      .padding(top: 5, bottom: 10),
                  Text(
                    "Sudah dibayar",
                    style: TelkomselTextStyle.h6.copyWith(
                      color: Colors.white,
                    ),
                  )
                      .padding(horizontal: 10, vertical: 5)
                      .backgroundColor(Colors.green)
                      .clipRRect(all: 20),
                ],
              ),
            ],
          ).padding(vertical: 20),
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

  Widget _card5() {
    final itemList = controller.card5List;
    return _cardBlur(
      withRadius: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Layanan Lainnya", style: TelkomselTextStyle.h6Bold),
          Image.asset(Assets.banner1,
                  width: double.infinity, height: 200, fit: BoxFit.fill)
              .clipRRect(all: 10)
              .padding(all: 16),
        ],
      ).padding(all: 16),
    );
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
