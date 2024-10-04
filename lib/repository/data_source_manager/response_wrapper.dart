import 'package:music_app/repository/data_source_manager/server_error.dart';

class ResponseWrapper<T, M> {
  ServerError? _error;
  T? _data;
  M? _meta;

  // ignore: type_annotate_public_apis, always_declare_return_types
  setException(ServerError error) {
    _error = error;
  }

  // ignore: use_setters_to_change_properties
  void setData(T data, M meta) {
    _data = data;
    _meta = meta;
  }

  T? get getData => _data;

  M? get getMeta => _meta;

  ServerError? get getException => _error;

  bool get hasException => _error != null;

  bool get hasData => _data != null;

  bool get hasMeta => _meta != null;
}
