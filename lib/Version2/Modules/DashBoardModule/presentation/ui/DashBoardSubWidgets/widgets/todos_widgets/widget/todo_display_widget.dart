import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/commonUis/common_container.dart';
import 'package:peopleqlik_debug/utils/icon_view/next_icon.dart';

import '../../../../../../../../../utils/lines_widget/horizontal_vertical_line.dart';
import '../../../../../../../../../utils/image_getter/cache_image.dart';
import '../../../../../../../../../utils/icon_view/done_icon.dart';
import '../../../../../../../../../utils/screen_sizes.dart';

class TodoDisplayWidget extends StatelessWidget {
  final bool? red; /// only for testing purpose
  const TodoDisplayWidget({this.red,super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      onTap: (){},
      horizontalMargin: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HorizontalLine(width: ScreenSize(context).widthOnly(1.4),lineHeight: 7,marginVertical: 0,color: MyColor.colorA5,),
          const DividerByWidth(3),
          Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PayPeople test task',
                    style: GetFont.get(
                        context,
                        fontWeight: FontWeight.w600,
                        fontSize: 1.8,
                        color: MyColor.colorBlack
                    ),
                  ),
                  const DividerByHeight(0.5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GetNetWorkImage(
                        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRn6xZcezB_9xpaz4eyMrYhaZo3SSEhivYPmTHvc-RX0F0LcqcWDdeNBL8bY2iP_nJIG3A&usqp=CAU',
                        size: 3.4,
                        boxShape: BoxShape.circle,
                        borderColor: MyColor.colorT5,
                        borderPadding: 0.2,
                        withBorder: true,
                      ),
                      DividerByWidth(2),
                      Text(
                        'Assigned by: Amir',
                        style: GetFont.get(
                            context,
                            fontWeight: FontWeight.w400,
                            fontSize: 1.4,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ],
                  ),
                  DividerByHeight(0.6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: 'Deadline: ',
                              style: GetFont.get(
                                  context,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 1.6,
                                  color: MyColor.colorGrey3
                              ),
                              children: [
                                TextSpan(
                                  text: red == true?'Today':'Monday, 2024 27 Feb',
                                  style: GetFont.get(
                                      context,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 1.6,
                                      color: red == true?MyColor.colorRed:MyColor.colorGrey3
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                      DoneIcon()
                    ],
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
