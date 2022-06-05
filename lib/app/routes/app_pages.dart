import 'package:get/get.dart';
import 'package:poktan_app/app/modules/activity/bindings/activity_binding.dart';
import 'package:poktan_app/app/modules/activity/views/add_activity_view.dart';
import 'package:poktan_app/app/modules/activity/views/detail_activity_view.dart';
import 'package:poktan_app/app/modules/activity/views/edit_activity_view.dart';
import 'package:poktan_app/app/modules/activity/views/index_activity_view.dart';
import 'package:poktan_app/app/modules/activity_category/bindings/activity_category_binding.dart';
import 'package:poktan_app/app/modules/activity_category/views/activity_category_view.dart';
import 'package:poktan_app/app/modules/activity_category/views/add_category_activity_view.dart';
import 'package:poktan_app/app/modules/activity_category/views/edit_category_activity_view.dart';
import 'package:poktan_app/app/modules/education/bindings/education_binding.dart';
import 'package:poktan_app/app/modules/education/views/add_education_view.dart';
import 'package:poktan_app/app/modules/education/views/detail_education_view.dart';
import 'package:poktan_app/app/modules/education/views/edit_education_view.dart';
import 'package:poktan_app/app/modules/education/views/index_education_view.dart';
import 'package:poktan_app/app/modules/education_category/bindings/education_category_binding.dart';
import 'package:poktan_app/app/modules/education_category/views/add_category_education_view.dart';
import 'package:poktan_app/app/modules/education_category/views/edit_category_education_view.dart';
import 'package:poktan_app/app/modules/education_category/views/education_category_view.dart';
import 'package:poktan_app/app/modules/history_plant/views/detail_history_plant_view.dart';
import 'package:poktan_app/app/modules/history_plant/views/history_plant_view.dart';
import 'package:poktan_app/app/modules/home/views/index_home_view.dart';
import 'package:poktan_app/app/modules/login/views/check_auth_view.dart';
import 'package:poktan_app/app/modules/notifikasi/bindings/notifikasi_binding.dart';
import 'package:poktan_app/app/modules/notifikasi/views/index_notifikasi_view.dart';
import 'package:poktan_app/app/modules/panen/bindings/panen_binding.dart';
import 'package:poktan_app/app/modules/panen/views/detail_panen_view.dart';
import 'package:poktan_app/app/modules/panen/views/index_panen_view.dart';
import 'package:poktan_app/app/modules/petani/bindings/petani_binding.dart';
import 'package:poktan_app/app/modules/petani/views/add_petani_view.dart';
import 'package:poktan_app/app/modules/petani/views/detail_petani_view.dart';
import 'package:poktan_app/app/modules/petani/views/edit_petani_view.dart';
import 'package:poktan_app/app/modules/petani/views/index_petani_view.dart';
import 'package:poktan_app/app/modules/poktan/bindings/poktan_binding.dart';
import 'package:poktan_app/app/modules/poktan/views/add_poktan_view.dart';
import 'package:poktan_app/app/modules/poktan/views/detail_poktan_view.dart';
import 'package:poktan_app/app/modules/poktan/views/edit_poktan_view.dart';
import 'package:poktan_app/app/modules/poktan/views/index_poktan_view.dart';
import 'package:poktan_app/app/modules/saya/bindings/saya_binding.dart';
import 'package:poktan_app/app/modules/saya/views/edit_profile_view.dart';
import 'package:poktan_app/app/modules/saya/views/edit_password_view.dart';
import 'package:poktan_app/app/modules/saya/views/index_saya_view.dart';
import 'package:poktan_app/app/modules/tandur/bindings/tandur_binding.dart';
import 'package:poktan_app/app/modules/tandur/views/detail_tandur_view.dart';
import 'package:poktan_app/app/modules/tandur/views/index_tandur_view.dart';

import '../modules/home/bindings/home_binding.dart';

import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHECK_AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => IndexHomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_AUTH,
      page: () => CheckAuthView(),
      binding: LoginBinding(),
    ),

    // Edukasi
    GetPage(
      name: _Paths.INDEX_EDUCATION,
      page: () => IndexEducationView(),
      binding: EducationBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_EDUCATION,
      page: () => DetailEducationView(),
      binding: EducationBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDUCATION,
      page: () => AddEducationView(),
      binding: EducationBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EDUCATION,
      page: () => EditEducationView(),
      binding: EducationBinding(),
    ),
    // Edukasi Kategori
    GetPage(
      name: _Paths.INDEX_EDUCATION_CATEGORY,
      page: () => EducationCategoryView(),
      binding: EducationCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDUCATION_CATEGORY,
      page: () => AddCategoryEducationView(),
      binding: EducationCategoryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EDUCATION_CATEGORY,
      page: () => EditCategoryEducationView(),
      binding: EducationCategoryBinding(),
    ),

    // Kegiatan
    GetPage(
      name: _Paths.INDEX_ACTIVITY,
      page: () => IndexActivityView(),
      binding: ActivityBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ACTIVITY,
      page: () => DetailActivityView(),
      binding: ActivityBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ACTIVITY,
      page: () => AddActivityView(),
      binding: ActivityBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ACTIVITY,
      page: () => EditActivityView(),
      binding: ActivityBinding(),
    ),
    // Kategori Kegiatan
    GetPage(
      name: _Paths.INDEX_ACTIVITY_CATEGORY,
      page: () => ActivityCategoryView(),
      binding: ActivityCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ACTIVITY_CATEGORY,
      page: () => AddCategoryActivityView(),
      binding: ActivityCategoryBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ACTIVITY_CATEGORY,
      page: () => EditCategoryActivityView(),
      binding: ActivityCategoryBinding(),
    ),

    // Tandur
    GetPage(
      name: _Paths.INDEX_TANDUR,
      page: () => IndexTandurView(),
      binding: TandurBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TANDUR,
      page: () => DetailTandurView(),
      binding: TandurBinding(),
    ),

    // Panen
    GetPage(
      name: _Paths.INDEX_PANEN,
      page: () => IndexPanenView(),
      binding: TandurBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PANEN,
      page: () => DetailPanenView(),
      binding: TandurBinding(),
    ),
    // History PLant
    GetPage(
      name: _Paths.HISTORY_PLANT,
      page: () => HistoryPlantView(),
      binding: TandurBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY_PLANT,
      page: () => DetailHistoryPlantView(),
      binding: TandurBinding(),
    ),

    // Poktan
    GetPage(
      name: _Paths.INDEX_POKTAN,
      page: () => IndexPoktanView(),
      binding: PoktanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_POKTAN,
      page: () => DetailPoktanView(),
      binding: PoktanBinding(),
    ),
    GetPage(
      name: _Paths.ADD_POKTAN,
      page: () => AddPoktanView(),
      // binding: PRODUKBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_POKTAN,
      page: () => EditPoktanView(),
      // binding: EdukasiBinding(),
    ),

    // Petani
    GetPage(
      name: _Paths.INDEX_PETANI,
      page: () => IndexPetaniView(),
      binding: PetaniBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PETANI,
      page: () => DetailPetaniView(),
      binding: PetaniBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PETANI,
      page: () => AddPetaniView(),
      // binding: PRODUKBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PETANI,
      page: () => EditPetaniView(),
      // binding: EdukasiBinding(),
    ),
    // Saya
    GetPage(
      name: _Paths.INDEX_SAYA,
      page: () => IndexSayaView(),
      binding: SayaBinding(),
    ),

    // SAYA
    GetPage(
      name: _Paths.INDEX_SAYA,
      page: () => IndexSayaView(),
      binding: SayaBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: SayaBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PASSWORD,
      page: () => EditPasswordView(),
      binding: SayaBinding(),
    ),

    // Notifikasi
    GetPage(
      name: _Paths.INDEX_NOTIFIKASI,
      page: () => IndexNotifikasiView(),
      binding: NotifikasiBinding(),
    ),
  ];
}
