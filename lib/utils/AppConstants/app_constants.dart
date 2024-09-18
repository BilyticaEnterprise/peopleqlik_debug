class AppConstants
{
  static const int managerId = 0;
  static const int requestEnCashmentScreenID = 456;
  static const int requestSeparationScreenID = 473;
  static const int requestTimeRegulationScreenID = 155;
  static const int managerTimeRegulationOfficePermission = 232;
  static const int managerTimeRegulationMiscTransaction = 225;
  static const int requestOverTimeScreenID = 171;
  static const int requestShiftScreenID = 153;
  static const int requestPerformanceScreenID = 400;
  static const int requestLeaveScreenID = 164;

  static const int movementSlipTypeId = 9;

  static const int dRAFT = 7;


  static getDocumentNumber(String documentNo)
  {
    var spl = documentNo.split(',');
    String val = '';
    for(int x=0;x<spl.length;x++)
    {
      String v = 'PrimaryVal${x+1}=${spl[x]}';
      val = '$val&$v';
      if(x == (spl.length-1))
      {
        int totalLeft = 4 - spl.length;
        if(!totalLeft.isNegative)
        {
          for(int y=x+1;y<totalLeft+spl.length;y++)
          {
            String v = 'PrimaryVal${y+1}=${null}';
            val = '$val&$v';
          }
        }
      }
    }
    return val;
  }

}