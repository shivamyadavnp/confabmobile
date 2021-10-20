import 'package:confabmobile/softwarepackages.dart';

class ShareTheApp {
  static String messageTitle = "Connect me on Confab!!";
  static String messageContent = "Let's meet on Confab!! It's free, open-source and top rated app we can use to video call or conduct meeting with 300 people without any limits. Download Confab with the link: https://confabmeet.com/getapp/";

  static perforrmFunction(BuildContext context) async {
    await Share.share(messageContent, subject: messageTitle).onError((error, stackTrace) async {
      await showDialog(context: context, builder: (context) {
        return ErrorDialogWidget(
          errorMessageTitle: "Something error!!",
          errorMessageContent: error.toString(),
        );
      });
    });
  }
}
