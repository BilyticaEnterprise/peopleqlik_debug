import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:peopleqlik_debug/Version2/Modules/MobileBlockingModule/domain/repository/mobile_page_repository.dart';
import 'package:peopleqlik_debug/Version2/Modules/MobileBlockingModule/utils/page_state.dart';

import '../../domain/models/mobile_info_model.dart';

class MobilePageRepositoryImpl extends MobilePageRepository
{
  @override
  MobileBlocPageState updatePage(MobileBlocPageState pageState) {
    currentPageState = pageState;
    return currentPageState;
  }

  @override
  MobileBlocPageState getCurrentPage() {
    return currentPageState;
  }

}