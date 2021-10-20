import 'package:confabmobile/softwarepackages.dart';

class MeetingDetailsScreen extends StatefulWidget {
  final SavedMeetingData savedMeetingData;

  const MeetingDetailsScreen({Key key, this.savedMeetingData}) : super(key: key);

  @override
  _MeetingDetailsScreenState createState() => _MeetingDetailsScreenState();
}

class _MeetingDetailsScreenState extends State<MeetingDetailsScreen> {
  confirmMeetingDeletion() async => await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        insetPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.50)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text("Are you sure to delete this meeting?", style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.50,
                    fontWeight: FontWeight.w500,
                  )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Theme.of(context).iconTheme.color.withOpacity(0.025)),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.50),
                            ),
                          ),
                          child: Text("No", style: GoogleFonts.poppins(
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
                            SavedMeetingsDBHelper.instance.deletesavedmeeting(widget.savedMeetingData.meetingCode);

                            Navigator.pop(context);
                            Navigator.pop(context);
                            
                            Fluttertoast.showToast(msg: "Meeting deleted");
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.50),
                            ),
                          ),
                          child: Text("Yes", style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14.50,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 10.0,
        titleSpacing: NavigationToolbar.kMiddleSpacing * 0.10,
        title: Text(widget.savedMeetingData.meetingTitle, style: GoogleFonts.poppins(
            color: Theme.of(context).iconTheme.color,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.030),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Something about meeting", style: GoogleFonts.poppins(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    widget.savedMeetingData.meetingDescription, style: GoogleFonts.poppins(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Meeting date and time", style: GoogleFonts.poppins(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    widget.savedMeetingData.meetingDateAndTime, style: GoogleFonts.poppins(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Meeting code", style: GoogleFonts.poppins(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.savedMeetingData.meetingCode, style: GoogleFonts.poppins(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  IconButton(
                    padding: const EdgeInsets.all(2.0),
                    icon: Icon(Feather.copy, color: Theme.of(context).iconTheme.color, size: 20.0),
                    onPressed: () async => await FlutterClipboard.copy(widget.savedMeetingData.meetingCode.toString()).whenComplete(() {
                      Fluttertoast.showToast(msg: "Code copied to clipboard");
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meeting Link", style: GoogleFonts.poppins(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.savedMeetingData.meetingLink.split("https://")[1].toString(),
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigureMeetingScreen(
                        meetingCode: widget.savedMeetingData.meetingCode,
                        ),
                       ),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 20, 40)),
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                      ),
                    ),
                    child: Text(
                      "Join now", style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.50),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.090),
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Share.share(
                            'Hey, Join the cofab meeting with the meeting code: ${widget.savedMeetingData.meetingCode.toString()} or join with a link ${widget.savedMeetingData.meetingLink.toString()}',
                            subject: "Join confab meeting",
                          ),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Theme.of(context).iconTheme.color.withOpacity(0.15),
                            child: Icon(Feather.share, color: Theme.of(context).iconTheme.color, size: 20.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditMeetingDetailsScreen(savedMeetingData: widget.savedMeetingData)));
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                            child: Icon(Feather.edit, color: Theme.of(context).iconTheme.color, size: 20.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => confirmMeetingDeletion(),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.grey.withOpacity(0.20),
                            child: Icon(Icons.delete, color: Theme.of(context).iconTheme.color, size: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          ],
        ),
      ),
    );
  }
}
