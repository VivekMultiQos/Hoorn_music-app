import 'package:music_app/entities/mdl_meta.dart';

import '../retrofit/apis.dart';

class BaseResponse<T> {
  T? data;
  MDLMeta? meta;

  BaseResponse({this.data, this.meta});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    data = json[Apis.data] as T;
    meta = json[Apis.meta] != null ? MDLMeta.fromJson(json['meta']) : null;
  }
}
