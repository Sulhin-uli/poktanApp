import 'package:get/get.dart';
import 'package:poktan_app/app/modules/edukasi/bindings/edukasi_binding.dart';
import 'package:poktan_app/app/modules/edukasi/views/add_edukasi_view.dart';
import 'package:poktan_app/app/modules/edukasi/views/detail_edukasi_view.dart';
import 'package:poktan_app/app/modules/edukasi/views/edit_edukasi_view.dart';
import 'package:poktan_app/app/modules/edukasi/views/index_edukasi_view.dart';
import 'package:poktan_app/app/modules/kegiatan/bindings/kegiatan_binding.dart';
import 'package:poktan_app/app/modules/kegiatan/views/add_kegiatan_view.dart';
import 'package:poktan_app/app/modules/kegiatan/views/detail_kegiatan_view.dart';
import 'package:poktan_app/app/modules/kegiatan/views/edit_kegiatan_view.dart';
import 'package:poktan_app/app/modules/kegiatan/views/index_kegiatan_view.dart';
import 'package:poktan_app/app/modules/notifikasi/bindings/notifikasi_binding.dart';
import 'package:poktan_app/app/modules/notifikasi/views/index_notifikasi_view.dart';
import 'package:poktan_app/app/modules/panen/bindings/panen_binding.dart';
import 'package:poktan_app/app/modules/panen/views/detail_detail_view.dart';
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
import 'package:poktan_app/app/modules/saya/views/index_saya_view.dart';
import 'package:poktan_app/app/modules/tandur/bindings/tandur_binding.dart';
import 'package:poktan_app/app/modules/tandur/views/detail_tandur_view.dart';
import 'package:poktan_app/app/modules/tandur/views/index_tandur_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

    // Edukasi
    GetPage(
      name: _Paths.INDEX_EDUKASI,
      page: () => IndexEdukasiView(),
      binding: EdukasiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_EDUKASI,
      page: () => DetailEdukasiView(),
      binding: EdukasiBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDUKASI,
      page: () => AddEdukasiView(),
      // binding: EdukasiBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EDUKASI,
      page: () => EditEdukasiView(),
      // binding: EdukasiBinding(),
    ),

    // Kegiatan
    GetPage(
      name: _Paths.INDEX_KEGIATAN,
      page: () => IndexKegiatanView(),
      // binding: ProdukBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KEGIATAN,
      page: () => DetailKegiatanView(),
      binding: KegiatanBinding(),
    ),
    GetPage(
      name: _Paths.ADD_KEGIATAN,
      page: () => AddKegiatanView(),
      // binding: PRODUKBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_KEGIATAN,
      page: () => EditKegiatanView(),
      // binding: EdukasiBinding(),
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
      // binding: ProdukBinding(),
    ),

    // Panen
    GetPage(
      name: _Paths.INDEX_PANEN,
      page: () => IndexPanenView(),
      binding: PanenBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PANEN,
      page: () => DetailPanenView(),
      // binding: ProdukBinding(),
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

    // Notifikasi
    GetPage(
      name: _Paths.INDEX_NOTIFIKASI,
      page: () => IndexNotifikasiView(),
      binding: NotifikasiBinding(),
    ),
  ];
}
