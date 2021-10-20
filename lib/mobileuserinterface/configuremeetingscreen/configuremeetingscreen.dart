import 'package:confabmobile/softwarepackages.dart';

class ConfigureMeetingScreen extends StatefulWidget {
  final String meetingCode;

  const ConfigureMeetingScreen({Key key, this.meetingCode}) : super(key: key);

  @override
  _ConfigureMeetingScreenState createState() => _ConfigureMeetingScreenState();
}

class _ConfigureMeetingScreenState extends State<ConfigureMeetingScreen> {
  String dynamicLink = "";
  bool isMicOn = true;
  bool isCameraOn = true;

  @override
  void initState() {
    getDynamicLink();
    super.initState();
  }

  getDynamicLink() async {
    String link = await DynamicLinksService.createNewDynamicLink(context, meetingCode: widget.meetingCode ?? "");

    setState(() {
      dynamicLink = link;
    });
  }

  joinMeetingFunction() async {
    bool isNetworkConnected = await ConnectivityService.checkConnection();

    if (isNetworkConnected) {
      if (widget.meetingCode != "") {
        await ConfabMeetingService.joinConfabMeeting(
          context,
          meetingID: widget.meetingCode,
          meetingTitle: widget.meetingCode,
          audioOn: isMicOn,
          videoOn: isCameraOn,
        );
      } else {
        await Fluttertoast.showToast(msg: "Something went error");
      }
    } else {
      Fluttertoast.showToast(msg: "Please check your network connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              Center(
                child: Text(widget.meetingCode.toString(), textAlign: TextAlign.center, style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.010),
              Center(
                child: Text(dynamicLink, textAlign: TextAlign.center, style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color.withOpacity(0.040),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMicOn = isMicOn ? false : true;
                            });
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Theme.of(context).iconTheme.color.withOpacity(0.075),
                            child: Icon(isMicOn ? MaterialIcons.mic : MaterialIcons.mic_off, color: Theme.of(context).iconTheme.color, size: 20.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCameraOn = isCameraOn ? false : true;
                            });
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Theme.of(context).iconTheme.color.withOpacity(0.075),
                            child: Icon(isCameraOn ? Feather.camera : Feather.camera_off, color: Theme.of(context).iconTheme.color, size: 20.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                    TextButton(
                      onPressed: () async {
                        await joinMeetingFunction();
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 20, 40)),
                        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0)),
                      ),
                      child: Text(
                        "Join now", style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.075),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextButton(
                        onPressed: () {
                          Share.share(
                            'Hey, Join the cofab meeting with the meeting code: ${widget.meetingCode.toString()} or join with a link ${dynamicLink.toString()}',
                            subject: "Join confab meeting",
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).iconTheme.color.withOpacity(0.10)),
                          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          )),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.50)),),
                          child: Text("Share", style: GoogleFonts.poppins(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 14.50,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                     ),
                   ),

                   Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SaveNewMeetingScreen(meetingCode: widget.meetingCode ?? "")));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          )),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.50)),),
                          child: Text("Save", style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14.50,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                     ),
                   ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            ],
          ),
        ),
      ),
    );
  }
}
