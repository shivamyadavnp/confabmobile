import 'package:confabmobile/softwarepackages.dart';

class MeetingLinkCreatedWidget extends StatefulWidget {
  final String meetingCode;
  final String meetingLink;

  const MeetingLinkCreatedWidget({Key key, this.meetingCode, this.meetingLink}) : super(key: key);

  @override
  _MeetingLinkCreatedWidgetState createState() => _MeetingLinkCreatedWidgetState();
}

class _MeetingLinkCreatedWidgetState extends State<MeetingLinkCreatedWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
      insetPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.50))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Link to your meeting", style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                )),
                trailing: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Feather.x, color: Theme.of(context).iconTheme.color, size: 20.0),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.010),
              Text("Copy this link and send it to people you want to meet with. Be sure to save it so you can use it later, too.", style: GoogleFonts.poppins(
                color: Theme.of(context).iconTheme.color.withOpacity(0.85),
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.040),
              TextFormField(
                onTap: () async => await FlutterClipboard.copy(widget.meetingLink.toString()).whenComplete(() {
                  Fluttertoast.showToast(msg: "Link copied to clipboard");
                }),
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  hintText: widget.meetingLink.split("https://")[1].toString(),
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: Icon(Feather.copy, color: Theme.of(context).iconTheme.color, size: 18.0),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.035),
              Center(
                child: TextButton(
                  onPressed: () async {
                    await Share.share(
                      "Hey, Join the cofab meeting with the meeting code: ${widget.meetingCode.toString()} or join with a link ${widget.meetingLink.toString()}",
                      subject: "Join confab meeting",
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.50)),
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.50)),
                      side: BorderSide.none,
                    )),
                  ),
                  child: Text("Share invite", style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.50,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
