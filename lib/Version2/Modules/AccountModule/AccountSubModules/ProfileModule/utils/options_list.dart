import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/basic_info_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/compensation_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/contact_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/document_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/experience_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/family_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/language_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/payment_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/pages/qualification_page.dart';

import '../../../../../../utils/tabs/domain/model/tab_bar_data.dart';


class ProfileOptionsList
{
  static List<TabOptionData> getOptionList(BuildContext context)
  {
    return [
      TabOptionData(title: 'Basic Info'),
      TabOptionData(title: 'Compensation'),
      TabOptionData(title: 'Payment'),
      TabOptionData(title: 'Contact'),
      TabOptionData(title: 'Documents'),
      TabOptionData(title: 'Qualification'),
      TabOptionData(title: 'Experience'),
      TabOptionData(title: 'Family'),
      TabOptionData(title: 'Language')];
  }

  static List<Widget> getProfileOptionPages({bool? canEdit})
  {
    return [
      ProfileBasicInfoViewPage(canEdit: canEdit,),
      ProfileCompensationViewPage(canEdit: canEdit,),
      ProfilePaymentViewPage(canEdit: canEdit,),
      ProfileContactViewPage(canEdit: canEdit,),
      ProfileDocumentViewPage(canEdit: canEdit,),
      ProfileQualificationViewPage(canEdit: canEdit,),
      ProfileExperienceViewPage(canEdit: canEdit,),
      ProfileFamilyViewPage(canEdit: canEdit,),
      ProfileLanguageViewPage(canEdit: canEdit,)
    ];
  }
}