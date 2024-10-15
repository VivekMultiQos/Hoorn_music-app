import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/entities/albums/mdl_local_store.dart';
import 'package:music_app/ui/prefere_screen.dart';

class FavoriteArtist extends StatefulWidget {
  const FavoriteArtist({super.key});

  @override
  State<FavoriteArtist> createState() => _FavoriteArtistState();
}

class _FavoriteArtistState extends State<FavoriteArtist> {
  List<Singers> singers = [];

  List<Singers> selectedSinger = [];

  @override
  void initState() {
    singers = LoginUser.instance.preferSinger;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: baseAppBar(leading: BackButton(), title: "My favorite artist"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                  if (selectedSinger.contains(singers[index])) {
                    selectedSinger.remove(singers[index]);
                  } else {
                    if (selectedSinger.length < singers.length - 2) {
                      selectedSinger.add(singers[index]);
                    } else {
                      showToastAlert(
                          message: "Minimum tow singers are required");
                    }
                  }
                  setState(() {});
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        image(index: index),
                        selectedSinger.contains(singers[index])
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
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w)
              .copyWith(
                  bottom:
                      LoginUser.instance.currentSong.name?.isNotEmpty ?? false
                          ? 100.h
                          : 15.h),
          decoration: BoxDecoration(
            gradient: screenBackGroundColor(),
          ),
          child: InkWell(
              onTap: () async {
                if (selectedSinger.isNotEmpty) {
                  for (var singer in selectedSinger) {
                    LoginUser.instance.preferSinger.removeWhere(
                        (preferSinger) => preferSinger.name == singer.name);
                  }
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
                  showToastAlert(message: "Please select at least one singer!");
                }
                setState(() {});
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
                    "Remove",
                    style: AppFontStyle.h2SemiBold,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget image({required int index}) {
    if (singers[index].url == false) {
      return Container(
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
      );
    } else {
      return Container(
        height: 150.w,
        width: 150.w,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.network(
          singers[index].image,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
