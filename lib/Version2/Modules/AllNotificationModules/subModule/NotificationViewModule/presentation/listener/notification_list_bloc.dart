import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/data/remote/api_client_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/data/repoImpl/notification_view_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/model/notification_view_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/usecase/notification_view_usecase.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class NotificationListBloc extends ExtendedCubit<AppState>
{

  late NotificationViewUseCase useCase;
  late StreamController<AppState> controller;
  StreamSubscription? streamSubscription;

  NotificationListBloc(super.initialState,NotificationViewMapper notificationViewMapper){
    controller = StreamController();
    useCase = NotificationViewUseCase(repo: NotificationViewRepoImpl(screenId: notificationViewMapper.screenId, controller: controller, apiClientRepo: ApiClientRepoImpl()));

  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

  void fetchListNotification(BuildContext context) {
    useCase.startGettingResult(context, AppStateStart());
    streamSubscription = controller.stream.listen((event) {
      emit(event);
    });
  }

}