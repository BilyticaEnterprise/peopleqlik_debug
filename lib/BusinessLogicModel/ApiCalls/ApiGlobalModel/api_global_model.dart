
import '../../Enums/apistatus_enum.dart';

class ApiResponse<T> {
  int? code;
  String? message;
  ApiStatus? apiStatus;
  T? data;

  ApiResponse(this.message, this.code,this.apiStatus, this.data);
}