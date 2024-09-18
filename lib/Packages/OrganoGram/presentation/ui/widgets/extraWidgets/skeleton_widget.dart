import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../configs/colors.dart';
import '../../../../../../configs/fonts.dart';
import '../../../../../../utils/image_getter/cache_image.dart';
import '../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../utils/screen_sizes.dart';

class OrganizationChartSkeleton extends StatelessWidget {
  const OrganizationChartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: true,
        child: Material(
          color: const Color(MyColor.colorWhite),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DividerByHeight(0.6),
                Expanded(
                    flex: 3,
                    child: GetNetWorkImage(
                      image: 'https://as2.ftcdn.net/v2/jpg/04/31/53/49/1000_F_431534927_fd6pw6iz6OHtnzgxOo6pcBuVebJiV5o0.jpg',
                      edgeInsets: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                      boxShape: BoxShape.circle,
                      borderPadding: 0.2,
                      withBorder: true,
                      borderColor: MyColor.colorPrimary,
                      borderWidth: 2,
                      boxFit: BoxFit.cover,

                    )
                ),
                Text(
                  'Kamlesh',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),
                ),
                Text(
                  'Admin',
                  style: GetFont.get(
                      context,
                      fontSize: 1.4,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorBlack
                  ),
                ),
                const DividerByHeight(0.6),
                // const ChartBottomIcon1(),
              ],
            ),

        ),
    );
  }
}
