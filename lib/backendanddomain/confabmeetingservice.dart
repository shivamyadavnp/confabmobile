import 'package:confabmobile/softwarepackages.dart';

class ConfabMeetingService {
  static startAnInstantMeeting(BuildContext context) async {
    String returnedCode = await GenerateMeetingCode().perform();

    String meetingCode = returnedCode.replaceAll(" ", "").replaceAll("-", "");
    String meetingTitle = returnedCode.replaceAll(" ", "");

    try {
      if (meetingCode != null && meetingCode != "") {
        await joinConfabMeeting(
          context,
          meetingID: meetingCode,
          meetingTitle: meetingTitle,
          audioOn: true,
          videoOn: true,
        );
      }
    } catch (error) {
      if (error.toString() != "") {
        await showDialog(context: context, builder: (context) {
          return ErrorDialogWidget(
            errorMessageTitle: "Meeting Error",
            errorMessageContent: error.toString(),
          );
        });
      }
    }
  }

  static getMeetingLinkToShare(BuildContext context) async {
    try {
      String code = await GenerateMeetingCode().perform();
      
      if (code != null && code != "") {
        String returned = await DynamicLinksService.createNewDynamicLink(context, meetingCode: code.replaceAll(" ", "").toString());

        if (returned != null && returned != "") {
          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (context) {
              return MeetingLinkCreatedWidget(
                meetingCode: code.replaceAll(" ", "").toString(),
                meetingLink: returned.toString(),
              );
            }
          );
        }
      }
      
    } catch (error) {
      if (error != null) {
        await showDialog(context: context, builder: (context) {
          return ErrorDialogWidget(
            errorMessageTitle: "Meeting Error",
            errorMessageContent: error.toString(),
          );
        });
      }
    }
  }

  static Future joinConfabMeeting(BuildContext context, {String meetingID, String meetingTitle, bool audioOn, bool videoOn}) async {
    String meetingRoomID = meetingID.replaceAll(" ", "").replaceAll("-", "").toString();
    bool keepAudio = audioOn ? false : true;
    bool keepVideo = videoOn ? false : true;

    Map<FeatureFlagEnum, bool> featureFlag = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };

    featureFlag[FeatureFlagEnum.CALENDAR_ENABLED] = false;
    featureFlag[FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE] = false;
    featureFlag[FeatureFlagEnum.RECORDING_ENABLED] = false;
    featureFlag[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;

    var options = JitsiMeetingOptions(room: meetingRoomID)
      ..serverURL = "https://meet.jit.si/confab/"
      ..subject = meetingTitle
      ..userDisplayName = userName ?? ""
      ..userAvatarURL = userProfilePhotoLink ?? ""
      ..userEmail = userEmailAddress ?? ""
      ..audioMuted = keepAudio
      ..videoMuted = keepVideo
      ..featureFlags.addAll(featureFlag)
      ..webOptions = {
        "roomName": meetingTitle,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": userName ?? ""}
      };

    JitsiMeetingListener jitsiMeetingListener = JitsiMeetingListener(
      onError: (error) async {
        if (error.toString() != "") {
          await showDialog(context: context, builder: (context) {
            return ErrorDialogWidget(
              errorMessageTitle: "Confab Meeting Error",
              errorMessageContent: error.toString(),
            );
          });
        }
      },
    );

    await JitsiMeet.joinMeeting(options, listener: jitsiMeetingListener);
  }
}
