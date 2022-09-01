// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/commons/navigation_drawer/bindings/navigation_drawer_binding.dart';
import '../modules/commons/navigation_drawer/views/navigation_drawer_view.dart';
import '../modules/commons/no/bindings/no_binding.dart';
import '../modules/commons/no/views/no_view.dart';
import '../modules/daftar_menu_makanan/bindings/daftar_menu_makanan_binding.dart';
import '../modules/daftar_menu_makanan/views/daftar_menu_makanan_view.dart';
import '../modules/hitung_bmi/bindings/hitung_bmi_binding.dart';
import '../modules/hitung_bmi/views/hitung_bmi_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kalori_dikonsumsi/bindings/kalori_dikonsumsi_binding.dart';
import '../modules/kalori_dikonsumsi/views/kalori_dikonsumsi_view.dart';
import '../modules/keterangan_kalori/bindings/keterangan_kalori_binding.dart';
import '../modules/keterangan_kalori/views/keterangan_kalori_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/pengaturan/views/pengaturan_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HITUNG_BMI,
      page: () => const HitungBmiView(),
      binding: HitungBmiBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_MENU_MAKANAN,
      page: () => const DaftarMenuMakananView(),
      binding: DaftarMenuMakananBinding(),
    ),
    GetPage(
      name: _Paths.KETERANGAN_KALORI,
      page: () => const KeteranganKaloriView(),
      binding: KeteranganKaloriBinding(),
    ),
    GetPage(
      name: _Paths.KALORI_DIKONSUMSI,
      page: () => const KaloriDikonsumsiView(),
      binding: KaloriDikonsumsiBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => const PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_DRAWER,
      page: () => const NavigationDrawerView(),
      binding: NavigationDrawerBinding(),
    ),
    GetPage(
      name: _Paths.NO,
      page: () => const NoView(),
      binding: NoBinding(),
    ),
  ];
}
