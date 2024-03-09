import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';

import '../../utils/enums/enum_update_add.dart';

class MoveToProfilePage
{
  static move(int index, BuildContext context)
  {
    switch(index)
    {
      case 0:
        Navigator.pushNamed(context, CurrentPage.basicProfileEditPage,arguments: UpdateAdd.addNew);
        break;
      case 1:
        Navigator.pushNamed(context, CurrentPage.compensationEditPage,arguments: UpdateAdd.addNew);
        break;
      case 2:
        Navigator.pushNamed(context, CurrentPage.paymentEditPage,arguments: UpdateAdd.addNew);
        break;
      case 3:
        Navigator.pushNamed(context, CurrentPage.contactEditPage,arguments: UpdateAdd.addNew);
        break;
      case 4:
        Navigator.pushNamed(context, CurrentPage.documentEditPage,arguments: UpdateAdd.addNew);
        break;
      case 5:
        Navigator.pushNamed(context, CurrentPage.qualificationEditPage,arguments: UpdateAdd.addNew);
        break;
      case 6:
        Navigator.pushNamed(context, CurrentPage.experienceEditPage,arguments: UpdateAdd.addNew);
        break;
      case 7:
        Navigator.pushNamed(context, CurrentPage.familyEditPage,arguments: UpdateAdd.addNew);
        break;
      case 8:
        Navigator.pushNamed(context, CurrentPage.languageEditPage,arguments: UpdateAdd.addNew);
        break;
      default:
        break;

    }
  }
}