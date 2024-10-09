import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/app_assets.dart';
import 'package:music_app/constant/font_style.dart';
import 'package:music_app/constant/import.dart';

import '../entities/albums/mdl_local_store.dart';

class Singers {
  String name;
  String image;

  Singers({required this.name, required this.image});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }

  // Create a Singers object from a JSON map
  factory Singers.fromJson(Map<String, dynamic> json) {
    return Singers(
      name: json['name'],
      image: json['image'],
    );
  }
}

class PreferScreen extends StatefulWidget {
  const PreferScreen({super.key});

  @override
  State<PreferScreen> createState() => _PreferScreenState();
}

class _PreferScreenState extends State<PreferScreen> {
  List<Singers> singers = [
    Singers(name: "Christina Perri", image: AssetImages.christinaPerri),
    Singers(name: "Taylor Swift", image: AssetImages.taylorSwift),
    Singers(name: "Miley Cyrus", image: AssetImages.mileyCyrus),
    Singers(name: "Bruno Mars", image: AssetImages.brunoMars),
    Singers(name: "Selena Gomez", image: AssetImages.selenaGomez),
    Singers(name: "Justin Bieber", image: AssetImages.justinBieber),
    Singers(name: "Eminem", image: AssetImages.eminem),
    Singers(name: "Justin Timberlake", image: AssetImages.justinTimberlake),
    Singers(name: "Rihanna", image: AssetImages.rihanna),
  ];

  List<Singers> selectedSingers = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: baseAppBar(),
        body: Container(
          decoration: BoxDecoration(
            gradient: screenBackGroundColor(),
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.6,
            ),
            padding: const EdgeInsets.all(8.0),
            itemCount: singers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (selectedSingers.contains(singers[index])) {
                    selectedSingers.remove(singers[index]);
                  } else {
                    selectedSingers.add(singers[index]);
                  }
                  setState(() {});
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150.w,
                          width: 150.w,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            singers[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        selectedSingers.contains(singers[index])
                            ? Container(
                                height: 150.w,
                                width: 150.w,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 50.w,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    Text(
                      singers[index].name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppFontStyle.h2SemiBold.copyWith(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.w),
          decoration: BoxDecoration(
            gradient: screenBackGroundColor(),
          ),
          child: InkWell(
            onTap: () async {
              if (selectedSingers.isNotEmpty) {
                Get.offAllNamed(AppPages.dashboard);
                LoginUser.instance.preferSinger = selectedSingers;
                try {
                  await LoginUser.instance.storeUserDataToLocal(
                    MdlLocalStore(
                      favoriteSong: jsonEncode(LoginUser.instance.favoriteSong
                          .map((song) => song.toJson())
                          .toList()),
                      userId: 1,
                      preferSinger: jsonEncode(LoginUser.instance.preferSinger
                          .map((singer) => singer.toJson())
                          .toList()),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              } else {
                showToastAlert(message: "Please selected a one singer!");
              }
            },
            child: Container(
              width: double.infinity,
              height: 60.w,
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all()),
              child: Center(
                child: Text(
                  "Done",
                  style: AppFontStyle.h2SemiBold,
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
