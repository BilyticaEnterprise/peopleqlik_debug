import 'package:peopleqlik_debug/utils/Enums/request_enums.dart';


class RequestDataTaker
{
  int? id;
  dynamic extraData;
  String? title;
  dynamic documentNumber;
  RequestsEnum? requestsEnum;

  RequestDataTaker(this.title,{this.id,this.requestsEnum,this.extraData,this.documentNumber});
}
