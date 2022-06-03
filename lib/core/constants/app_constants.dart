class AppConstants {
  static AppConstants? _instance;

  static AppConstants get instance => _instance ??= AppConstants._init();

  AppConstants._init();

  String appTitle = 'Qr Uygulaması';
  String appIconPath = 'assets/images/ic_qr.png';
  String textSvgPath = 'assets/images/textsvg.svg';
  String orangePath = 'assets/images/orange.png';
  String qrAnimPath = 'assets/animations/qr_anim.json';
  String successAnimPath = 'assets/animations/success.json';
}
