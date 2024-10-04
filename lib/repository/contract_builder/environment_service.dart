enum AppEnvironment {
  staging,
  local,
  production,
}

const appEnvironment = AppEnvironment.staging;

class EnvironmentService {
  static String get baseUrl {
    var baseUrl = '';

    switch (appEnvironment) {
      case AppEnvironment.local:
        baseUrl = 'http://192.168.1.11:3000/api/';
        break;

      case AppEnvironment.staging:
        baseUrl = 'http://192.168.1.11:3000/api/';
        break;

      case AppEnvironment.production:
        baseUrl = '';
        break;
    }

    return baseUrl;
  }
}
