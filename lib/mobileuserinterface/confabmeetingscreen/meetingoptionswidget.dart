import 'package:confabmobile/softwarepackages.dart';

class MeetingOptionsWidget extends StatefulWidget {
  const MeetingOptionsWidget({Key key}) : super(key: key);

  @override
  _MeetingOptionsWidgetState createState() => _MeetingOptionsWidgetState();
}

class _MeetingOptionsWidgetState extends State<MeetingOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.030),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              onTap: () async {
                bool isNetworkConnected = await ConnectivityService.checkConnection();

                if (isNetworkConnected) {
                  await ConfabMeetingService.getMeetingLinkToShare(context);
                } else {
                  Fluttertoast.showToast(msg: "Please check your internet connection");
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.50),
              leading: Icon(Feather.link_2, color: Theme.of(context).iconTheme.color, size: 20.0),
              horizontalTitleGap: 10.0,
              title: Text("Get a meeting link", style: GoogleFonts.poppins(
                color: Theme.of(context).iconTheme.color,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              )),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                await ConfabMeetingService.startAnInstantMeeting(context);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.50),
              leading: Icon(Feather.video, color: Theme.of(context).iconTheme.color, size: 20.0),
              horizontalTitleGap: 10.0,
              title: Text("Start an instant meeting", style: GoogleFonts.poppins(
                color: Theme.of(context).iconTheme.color,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              )),
            ),
            ListTile(
              onTap: () async {
                bool isNetworkConnected = await ConnectivityService.checkConnection();

                if (isNetworkConnected) {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SaveNewMeetingScreen()));

                } else {
                  Fluttertoast.showToast(msg: "Please check your internet connection");
                }
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.50),
              leading: Icon(Feather.save, color: Theme.of(context).iconTheme.color, size: 20.0),
              horizontalTitleGap: 10.0,
              title: Text("Save new meeting", style: GoogleFonts.poppins(
                color: Theme.of(context).iconTheme.color,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              )),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.50),
              leading: Icon(Feather.x, color: Theme.of(context).iconTheme.color, size: 20.0),
              horizontalTitleGap: 10.0,
              title: Text("Close", style: GoogleFonts.poppins(
                color: Theme.of(context).iconTheme.color,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
