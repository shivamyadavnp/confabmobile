import 'package:confabmobile/softwarepackages.dart';

class GenerateMeetingCode {
  Future<String> perform() async {
    String firstletter = userName[0].toString();
    String meetingcodefirst = DateTime.now().month.toString() + DateTime.now().day.toString() ?? "undetermined";
    String meetingcodesecond = DateTime.now().hour.toString() + DateTime.now().minute.toString() ?? "undetermined";
    String meetingcodethird = DateTime.now().second.toString() + DateTime.now().millisecond.toString() ?? "undetermined";

    String generated = "$firstletter$meetingcodefirst-$meetingcodesecond-$meetingcodethird";
    return generated;
  }
}
