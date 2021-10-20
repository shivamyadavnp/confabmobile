import 'package:confabmobile/softwarepackages.dart';

class DynamicLinksService {
  static FirebaseDynamicLinks firebaseDynamicLinks = FirebaseDynamicLinks.instance;

  static Future<String> createNewDynamicLink(BuildContext context, {String meetingCode}) async {
    try {
      String socialMediaImageLink = "https://uc15964c1803f5270a8c3ef05c67.previews.dropboxusercontent.com/p/thumb/ABXUuhRp8afdDKBTusUbuDfs0AxJA2n2aUBLRIaznxt_TSzqV25pOoUHlUp6VDdm4l0FvFn_UVR_TMQwS1zDANWFxhMu5o8snBzHyAWChvTdvVKgvNu4eb-DnHwTQDEmcnanTa_NzAsxF-3oWRz63MxpZ2IhyGPtIPoKcuC2od5cdNn7pg-0jo3OceqcNv_mZ2wpk6UW-HB_hdbPn4SkodrNf5JzSxP5HC8yJeHBwVL1kj90DxaP73YlaWbvqh-PsSDF-f5oholWDLgzyo3CMIfcKfEu2VHRtWrGjamPjgse4lQyCiJ2azCqq_1DDW78kY4RPHubEGnrmzVSCWBzFQNFsnx4IhB5YIfteo_uEyijOS5f86ot0-dNa4A0k_d-M6wKBinZ2Q6Dw1BUVnLWKUl-/p.png";
      String packageName = "shivamyadav.confabmeetings.android";
      String webLink = "https://confabmeet.com/meeting?code=$meetingCode";
      
      DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: "https://confabmeet.com/",
        link: Uri.parse(webLink.toString()),
        androidParameters: AndroidParameters(packageName: packageName),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: "Join confab meeting",
          description: "Get into meeting room with this link or simply entering the meeting code: $meetingCode",
          imageUrl: Uri.parse(socialMediaImageLink.toString()),
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
      );

      ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
      
      String shortLink = shortDynamicLink.shortUrl.toString();

      if (shortLink != null) {
        return shortLink;
      } else {
        return "";
      }
    } catch (error) {
      if (error.toString() != "") {
        await showDialog(
          context: context,
          builder: (context) {
            return ErrorDialogWidget(
              errorMessageTitle: "Something went error",
              errorMessageContent: error.toString(),
            );
          }
        );
      }
      return "";
    }
  }

  static getAndHandleDynamicLinks(BuildContext context) async {
    try {
      PendingDynamicLinkData linkData = await firebaseDynamicLinks.getInitialLink();
      
      firebaseDynamicLinks.onLink(
        onSuccess: (dynamicLinkData) async {
          String meetingCode = dynamicLinkData.link.queryParameters["code"].toString();
          
          if (meetingCode != null && meetingCode != "") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigureMeetingScreen(meetingCode: meetingCode)));
          }
        },
        onError: (error) {
          return null;
        }
      );
      
      if (linkData != null) {
        String meetingCode = linkData.link.queryParameters["code"].toString();

        if (meetingCode != null && meetingCode != "") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigureMeetingScreen(meetingCode: meetingCode)));
        }
      }
    } catch (error) {
      if (error.toString() != "") {
        await showDialog(
          context: context,
          builder: (context) {
            return ErrorDialogWidget(
              errorMessageTitle: "Something error",
              errorMessageContent: error.toString(),
            );
          }
        );
      }
    }
  }
}
