class DevEnv {
  static String environment = 'localTesting';

  changeEnv(String env) {
    switch (env) {
      case 'local':
        return environment = 'local';
      case 'production':
        return environment = 'production';
      case 'serverTest':
        return environment = 'serverTest';
      default:
    }
  }
}
