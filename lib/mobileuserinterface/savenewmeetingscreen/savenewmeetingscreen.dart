import 'package:confabmobile/softwarepackages.dart';
import 'package:intl/intl.dart';

class SaveNewMeetingScreen extends StatefulWidget {
  final String meetingCode;

  const SaveNewMeetingScreen({Key key, this.meetingCode}) : super(key: key);

  @override
  _SaveNewMeetingScreenState createState() => _SaveNewMeetingScreenState();
}

class _SaveNewMeetingScreenState extends State<SaveNewMeetingScreen> {
  TextEditingController meetingTitleController = TextEditingController();
  TextEditingController aboutMeetingFieldController = TextEditingController();
  TextEditingController startTimeFieldController = TextEditingController();
  bool isMeetingTimed = false;
  String currentlyEditingMeetingCode = "";
  String currentMeetingLink = "";

  @override
  void initState() {
    super.initState();
    fillCurrentDateTime();
    haveSomeMeetingCode();
  }

  fillCurrentDateTime() {
    DateTime dateTime = DateTime.now();
    final DateFormat dateFormat = DateFormat('EEEE MMM d, yyyy hh:mm aaa');

    setState(() {
      startTimeFieldController.text = dateFormat.format(dateTime);
    });
  }

  haveSomeMeetingCode() async {
    try {
      String generatedcode = widget.meetingCode ?? await GenerateMeetingCode().perform();

      setState(() {
        currentlyEditingMeetingCode = generatedcode;
      });
    } catch (e) {
      return null;
    }
  }

  makeMeetingLink() async {
    try {
      String createdLink = await DynamicLinksService.createNewDynamicLink(
        context,
        meetingCode: currentlyEditingMeetingCode.toString(),
      );

      if (createdLink != null) {
        if (createdLink != "") {
          setState(() {
            currentMeetingLink = createdLink.toString();
          });
        } else {
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
      }
    } catch (error) {
      return null;
    }
  }

  saveMeetingToDatabase(SavedMeetingData savedMeetingData) async {
    await SavedMeetingsDBHelper.instance.insertSavedMeeting(savedMeetingData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 15.0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        titleSpacing: NavigationToolbar.kMiddleSpacing * 0.10,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          padding: const EdgeInsets.all(2.0),
          icon: Icon(Feather.x, color: Theme.of(context).iconTheme.color, size: 20.0),
        ),
        title: Text(
          "Create a new meeting", style: GoogleFonts.poppins(
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
                controller: meetingTitleController,
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
                controller: aboutMeetingFieldController,
                onTap: () async {
                  String returnedtext = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutMeetingEditScreen(previousDescriptionText: aboutMeetingFieldController.text),
                    ),
                  );

                  setState(() {
                    aboutMeetingFieldController.text = returnedtext.toString();
                  });
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
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.50),
              title: Text(
                "Save with time", style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                "Would you like to save meeting with time?", style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color.withOpacity(0.85),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: isMeetingTimed,
              activeColor: kPrimaryColor,
              tileColor: Theme.of(context).iconTheme.color.withOpacity(0.075),
              onChanged: (value) {
                setState(() {
                  isMeetingTimed = value;
                });
              },
            ),
            isMeetingTimed
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.020)
                : Container(),
            isMeetingTimed
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: startTimeFieldController,
                      onTap: () async {
                        DateTime dateTime = DateTime.now();
                        final DateFormat dateFormat = DateFormat('EEEE MMM d, yyyy hh:mm aa');
                        final selectedDate = await selectDate(context);

                        final selectedTime = await selectTime(context);

                        setState(() {
                          dateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                        });

                        setState(() {
                          startTimeFieldController.text = dateFormat.format(dateTime);
                        });
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
                  )
                : Container(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.040),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () async {
                  bool isNetworkConnected = await ConnectivityService.checkConnection();

                  await makeMeetingLink();

                  try {
                    String meetingtitletext = meetingTitleController.text == ""
                        ? "Meeting title"
                        : meetingTitleController.text.toString();
                    String aboutmeetingtext =
                        aboutMeetingFieldController.text == ""
                            ? "Meeting content"
                            : aboutMeetingFieldController.text.toString();

                    SavedMeetingData savedMeetingData = SavedMeetingData(
                      meetingTitle: meetingtitletext,
                      meetingDescription: aboutmeetingtext,
                      meetingDateAndTime: isMeetingTimed == false
                          ? ""
                          : startTimeFieldController.text.toString(),
                      meetingCode: currentlyEditingMeetingCode.toString(),
                      meetingLink: currentMeetingLink,
                    );

                    if (isNetworkConnected) {
                      saveMeetingToDatabase(savedMeetingData);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please check your internet connetion",
                      );
                    }
                  } catch (error) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorDialogWidget(
                          errorMessageTitle: "Something error",
                          errorMessageContent: error.toString(),
                        );
                      },
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  )),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17.50)),
                ),
                child: Text(
                  "Save meeting", style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
          ],
        ),
      ),
    );
  }

  Future<TimeOfDay> selectTime(BuildContext context) {
    DateTime now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }

  Future<DateTime> selectDate(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(const Duration(seconds: 1)),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );
}
