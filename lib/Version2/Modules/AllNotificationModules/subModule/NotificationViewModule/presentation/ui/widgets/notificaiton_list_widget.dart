import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/presentation/listener/notification_list_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/skeleton_list_widget.dart';
import 'package:peopleqlik_debug/utils/image_getter/cache_image.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class NotificationWidget extends StatelessWidget {
  final int index;
  final Function() onTap;
  const NotificationWidget({required this.index, required this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationListBloc data = BlocProvider.of<NotificationListBloc>(context,listen: false);
    //PrintLogs.printLogs('${RequestType.profileUrl}${data.useCase.getList()?[index].picture}');
    return data.useCase.getIsReachEnd() == true && index==data.useCase.getList()!.length-1?

    SkeletonListWidget(index,height: 16,margin: 5.6,):
    Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorBackgroundDark)
          )
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Material(
          color: const Color(MyColor.colorWhite),
          child: InkWell(
            splashColor: const Color(MyColor.colorGrey0),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.useCase.getList()?[index].title??'',
                          style: GetFont.get(
                              context,
                              fontSize:1.8,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                      ),
                      if(data.useCase.getList()?[index].isRead==false)...[
                        Container(
                          height: ScreenSize(context).heightOnly( 0.8),
                          width: ScreenSize(context).heightOnly( 0.8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(MyColor.colorRed1)
                          ),
                        )
                      ],
                    ],
                  ),
                  const DividerByHeight(0.6),
                  Text(
                    data.useCase.getList()?[index].body??'',
                    style: GetFont.get(
                        context,
                        fontSize: 1.6,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorBlack
                    ),
                  ),
                  const DividerByHeight(2.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GetNetWorkImage(
                              image: '${RequestType.profileUrl}${data.useCase.getList()?[index].picture}',
                              size: 4.4,
                              boxShape: BoxShape.circle,
                              borderColor: MyColor.colorT5,
                              borderPadding: 0.2,
                            ),
                            const DividerByWidth(2),
                            Text(
                                data.useCase.getList()?[index].employeeName??'',
                                style: GetFont.get(
                                    context,
                                    fontSize:1.4,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.colorGrey3
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        GetDateFormats().getFilterDate(data.useCase.getList()?[index].createdDate)??'',
                        style: GetFont.get(
                            context,
                            fontSize:1.4,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorGrey3
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}