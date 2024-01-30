import '../../../../../src/colors.dart';

int? getColorOfLeaveStatusType(int? timeOffType)
{
  switch(timeOffType)
  {
    case 1:
      return MyColor.colorT1;
    case 3:
      return MyColor.colorT5;
    case 2:
      return MyColor.colorT3;
    default:
      return MyColor.colorRed1;
  }
}
int? getColorOfLeaveStatusText(int? timeOffType)
{
  switch(timeOffType)
  {
    case 1:
      return MyColor.colorT2;
    case 3:
      return MyColor.colorT6;
    case 2:
      return MyColor.colorT4;
    default:
      return MyColor.colorWhite;
  }
}