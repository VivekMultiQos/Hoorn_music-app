import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/app_assets.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/prefetch/prefetch_cubit.dart';
import 'package:music_app/cubit/prefetch/prefetch_state.dart';

class PrefetchPage extends StatefulWidget {
  final PrefetchCubit prefetchCubit;

  const PrefetchPage({
    required this.prefetchCubit,
    super.key,
  });

  @override
  State<PrefetchPage> createState() => _PrefetchPageState();
}

class _PrefetchPageState extends State<PrefetchPage> {
  @override
  void initState() {
    super.initState();

    widget.prefetchCubit.getDropDownList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.prefetchCubit,
      listener: (context, state) {
        if (state is PrefetchLoadingState) {
        } else if (state is PrefetchDropDownErrorState) {
        } else if (state is PrefetchDropDownSuccessState) {
          if (LoginUser.instance.preferSinger.isNotEmpty) {
            Get.toNamed(AppPages.dashboard);
          } else {
            Get.toNamed(AppPages.preferScreen);
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: screenBackGroundColor(),
        ),
        child: Center(
          child: SizedBox(
            height: 150.w,
            width: 150.w,
            child: Image.asset(
              AssetImages.imgSplash,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
