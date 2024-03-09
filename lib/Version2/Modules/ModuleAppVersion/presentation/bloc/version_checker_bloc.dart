
import 'package:flutter/cupertino.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import '../../domain/usecases/version_check_usecase.dart';

class VersionCheckerNotifier extends GetChangeNotifier
{

  late VersionCheckUseCase useCase;
  VersionCheckerNotifier(){
    useCase = VersionCheckUseCase();
  }

  void getVersionData(BuildContext context) async
  {
    useCase.getVersionData(context);
  }

}