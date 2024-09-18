import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/domain/repo/move_users_to_pages_on_notification_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/model/notification_view_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/presentation/listener/notification_list_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/presentation/ui/widgets/notificaiton_list_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/moving_page_extensions.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';


class NotificationTabBody extends StatelessWidget {
  final NotificationViewMapper notificationViewMapper;
  const NotificationTabBody({required this.notificationViewMapper,super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<NotificationListBloc>(create: (_) => NotificationListBloc(AppStateNothing(),notificationViewMapper))
      ],
      builder: (context) {
        return _NotificationTabBodyWidget();
      }
    );
  }
}

class _NotificationTabBodyWidget extends StatefulWidget {
  const _NotificationTabBodyWidget({super.key});

  @override
  State<_NotificationTabBodyWidget> createState() => _NotificationTabBodyWidgetState();
}

class _NotificationTabBodyWidgetState extends State<_NotificationTabBodyWidget> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<NotificationListBloc>(context,listen: false).fetchListNotification(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationListBloc,AppState>(
      listener: (context,data){},
        builder: (context,data) {
          if(data is AppStateDone || data is AppStatePagination)
          {
            NotificationListBloc getNotificationModelListener = BlocProvider.of<NotificationListBloc>(context,listen: false);
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  // PrintLogs.print('true');
                  getNotificationModelListener.useCase.updateStep(true, context);
                  return true;
                }
                else
                {
                  getNotificationModelListener.useCase.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly(4),bottom: ScreenSize(context).heightOnly( 20)),
                  itemBuilder: (context,index)
                  {
                    return NotificationWidget(
                      index: index,
                      onTap: (){
                        MoveUserToPagesFromNotificationsRepo.instance.selectPageByNotification(context,getNotificationModelListener.useCase.getList()?[index].payload);
                      },
                    );
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly(2.5),);
                  },
                  itemCount: getNotificationModelListener.useCase.getList()?.length??0
              ),
            );
          }
          else if(data is AppStateEmpty)
          {
            return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr19)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr20)}',topMargin: 8,width: 40,);
          }
          else if(data is AppStateError)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
