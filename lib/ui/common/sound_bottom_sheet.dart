import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/ui/common/equalizer/custom_eq.dart';

class SoundBottomSheet extends StatefulWidget {
  final ChangeThemeState themeState;

  const SoundBottomSheet({
    super.key,
    required this.themeState,
  });

  @override
  State<SoundBottomSheet> createState() => _SoundBottomSheetState();
}

class _SoundBottomSheetState extends State<SoundBottomSheet> {
  bool enableCustomEQ = false;

  @override
  void initState() {
    // TODO: implement initState
    EqualizerFlutter.init(0);
    super.initState();
  }

  // @override
  // void dispose() {
  //   EqualizerFlutter.release();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      blur: 5,
      color: const Color(0xFFFFFFFF).withOpacity(0.2),
      padding: const EdgeInsets.all(0),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 60.w,
                padding: EdgeInsets.all(2.5.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            StreamBuilder<double>(
              stream: LoginUser.instance.player.speedStream,
              builder: (context, snapshot) => SizedBox(
                child: Row(
                  children: [
                    const Icon(
                      Icons.speed,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Slider(
                        min: 0.5,
                        max: 2.0,
                        value: snapshot.data ?? LoginUser.instance.player.speed,
                        onChanged: LoginUser.instance.player.setSpeed,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Text(
                      "${(snapshot.data ?? LoginUser.instance.player.speed).toStringAsFixed(2)}x",
                      style: AppFontStyle.h3Regular.copyWith(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder<double>(
              stream: LoginUser.instance.player.volumeStream,
              builder: (context, snapshot) => SizedBox(
                child: Row(
                  children: [
                    const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Slider(
                        min: 0.0,
                        max: 100.0,
                        value:
                            snapshot.data ?? LoginUser.instance.player.volume,
                        onChanged: LoginUser.instance.player.setVolume,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Text(
                      (snapshot.data ?? LoginUser.instance.player.volume)
                          .toStringAsFixed(0),
                      style: AppFontStyle.h3Regular.copyWith(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: equalizer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget equalizer() {
    return ListView(
      children: [
        const SizedBox(height: 10.0),
        Container(
          color: Colors.grey.withOpacity(0.5),
          child: SwitchListTile(
            title: Text(
              'Custom Equalizer',
              style: AppFontStyle.h3Regular.copyWith(color: Colors.white),
            ),
            value: enableCustomEQ,
            activeColor: Colors.black,
            inactiveTrackColor: Colors.grey,
            onChanged: (value) {
              EqualizerFlutter.setEnabled(value);
              setState(() {
                enableCustomEQ = value;
              });
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        enableCustomEQ
            ? FutureBuilder<List<int>>(
                future: EqualizerFlutter.getBandLevelRange(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.done
                      ? CustomEQ(enableCustomEQ, snapshot.data!)
                      : const SizedBox.shrink();
                },
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
