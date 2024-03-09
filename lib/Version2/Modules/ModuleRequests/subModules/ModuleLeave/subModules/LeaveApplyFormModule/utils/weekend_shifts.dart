import '../domain/models/time_off_get_form_mapper.dart';

class GetShifts
{
  static List<ShiftInfo> getAll()
  {
    return [
      ShiftInfo(
          weekDayID: 2,
          offDay: false
      ),
      ShiftInfo(
          weekDayID: 3,
          offDay: false
      ),
      ShiftInfo(
          weekDayID: 4,
          offDay: false
      ),
      ShiftInfo(
          weekDayID: 5,
          offDay: false
      ),
      ShiftInfo(
          weekDayID: 6,
          offDay: false
      ),
      ShiftInfo(
          weekDayID: 7,
          offDay: false
      ),
      ShiftInfo(
          weekDayID: 1,
          offDay: false
      ),
    ];
  }
}