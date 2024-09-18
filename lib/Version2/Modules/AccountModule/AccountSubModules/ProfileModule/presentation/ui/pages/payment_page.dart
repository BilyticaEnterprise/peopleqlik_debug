import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';

import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../utils/screen_sizes.dart';
import '../../../utils/profile_header_value_text.dart';

class ProfilePaymentViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfilePaymentViewPage({super.key, this.canEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5),vertical: ScreenSize(context).heightOnly(3)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color(MyColor.colorWhite),
            border: Border.all(width: 1,color: Color(MyColor.colorBackgroundDark))
        ),
        child: Padding(
          padding: EdgeInsets.all(ScreenSize(context).heightOnly(2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.PaymentMethodIs)??'', value: 'Cash',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.AccountType)??'', value: 'Online',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.BeneficiaryBank)??'', value: 'Alflah',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.BeneficiaryBranch)??'', value: 'Al fateh',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.IBANCode)??'', value: 'PK19ICOS',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.EmployeeAccount)??'', value: 'Muneeb',),
            ],
          ),
        ),
      ),
    );
  }
}
