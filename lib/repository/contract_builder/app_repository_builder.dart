import 'package:music_app/repository/contract_builder/app_repository_contract.dart';
import 'package:music_app/repository/provider/lrf/user_repository.dart';

import '../../constant/import.dart';

class AppRepositoryBuilder {
  static AppRepositoryContract repository(
      {RepositoryProviderType of = RepositoryProviderType.user}) {
    switch (of) {
      case RepositoryProviderType.user:
        return UserRepository();
      default:
        return UserRepository();
    }
  }
}
