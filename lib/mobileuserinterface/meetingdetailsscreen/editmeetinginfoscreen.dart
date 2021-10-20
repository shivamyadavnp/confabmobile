import 'package:confabmobile/softwarepackages.dart';
import 'package:intl/intl.dart';

class EditMeetingDetailsScreen extends StatefulWidget {
  final SavedMeetingData savedMeetingData;

  const EditMeetingDetailsScreen({Key key, this.savedMeetingData}) : super(key: key);
  
  @override
  _EditMeetingDetailsScreenState createState() => _EditMeetingDetailsScreenState();
}

class _EditMeetingDetailsScreenState extends State<EditMeetingDetailsScreen> {
  TextEditingController editedTitleTextController = TextEditingController();
  TextEditingController editedDescriptionTextController = TextEditingController();
  TextEditingController meetingStartDateAndTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPreviousDetails();
  }

  fetchPreviousDetails() {
    if (widget.savedMeetingData != null) {
      setState(() {
        editedTitleTextController.text = widget.savedMeetingData.meetingTitle;
        editedDescriptionTextController.text = widget.savedMeetingData.meetingDescription;
        meetingStartDateAndTimeController.text = widget.savedMeetingData.meetingDateAndTime;
      });
    }
  }

  updateeditedmeeting(SavedMeetingData savedMeetingData) async {
    await SavedMeetingsDBHelper.instance.updatesavedmeeting(savedMeetingData);

    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Changes saved");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 10.0,
        titleSpacing: NavigationToolbar.kMiddleSpacing * 0.10,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          padding: const EdgeInsets.all(2.0),
          icon: Icon(Feather.x, color: Theme.of(context).iconTheme.color, size: 20.0),
        ),
        title: Text(
          "Edit a saved meeting", style: GoogleFonts.poppins(
            color: Theme.of(context).iconTheme.color,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: editedTitleTextController,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.50,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.50)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).iconTheme.color.withOpacity(0.075),
                  hintText: "Title of the meeting",
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.030),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: editedDescriptionTextController,
                onTap: () async {
                  String returnedText = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutMeetingEditScreen(previousDescriptionText: widget.savedMeetingData.meetingDescription.toString())),
                  );
                  if (returnedText != null) {
                    setState(() {
                      editedDescriptionTextController.text = returnedText.toString();
                    });
                  }
                },
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.50,
                  fontWeight: FontWeight.w500,
                ),
                readOnly: true,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).iconTheme.color.withOpacity(0.075),
                  hintText: "Something more about meeting",
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.030),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: meetingStartDateAndTimeController,
                onTap: () async {
                  DateTime dateTime = DateTime.now();
                  final DateFormat dateFormat = DateFormat('EEEE MMM d, yyyy hh:mm aa');
                  final selectedDate = await selectdate(context);

                  final selectedTime = await selecttime(context);

                  setState(() {
                    dateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                  });
                  setState(
                    () {
                      meetingStartDateAndTimeController.text = dateFormat.format(dateTime);
                    },
                  );
                },
                readOnly: true,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.50,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).iconTheme.color.withOpacity(0.075),
                  hintText: "Meeting start date and time",
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.040),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () async {
                  SavedMeetingData savedMeetingData = SavedMeetingData(
                    meetingTitle: editedTitleTextController.text.toString(),
                    meetingDescription: editedDescriptionTextController.text.toString(),
                    meetingDateAndTime: meetingStartDateAndTimeController.text.toString(),
                    meetingCode: widget.savedMeetingData.meetingCode.toString(),
                    meetingLink: widget.savedMeetingData.meetingLink.toString(),
                  );

                  await updateeditedmeeting(savedMeetingData);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13.50)),
                  )),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17.50)),
                ),
                child: Text(
                  "Save changes",style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.060),
          ],
        ),
      ),
    );
  }

  Future<TimeOfDay> selecttime(BuildContext context) {
    DateTime now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> selectdate(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(const Duration(seconds: 1)),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );
}
