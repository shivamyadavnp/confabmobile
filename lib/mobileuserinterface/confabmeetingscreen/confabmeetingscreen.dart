import 'package:confabmobile/softwarepackages.dart';

class ConfabMeetingScreen extends StatefulWidget {
  const ConfabMeetingScreen({Key key}) : super(key: key);

  @override
  _ConfabMeetingScreenState createState() => _ConfabMeetingScreenState();
}

class _ConfabMeetingScreenState extends State<ConfabMeetingScreen> {
  TextEditingController meetingCodeFieldController = TextEditingController();
  Future<List<SavedMeetingData>> savedMeetingsList;

  @override
  void initState() {
    getAllSavedMeetings();
    getPreviousDetails();
    handleStartupLogic();
    super.initState();
  }

  handleStartupLogic() async {
    await NotificationsService.getIntitalMessage();
    await NotificationsService.handleForgroudNotification();
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message.data["parsedValue"] == "update") {
        await launch(ConfigurationValues.appStoreLink);
      }
    });
    String result = await DynamicLinksService.getAndHandleDynamicLinks(context);

    if (result.toString().contains("meetingCode")) {
      String code = result.split("meetingCode")[1].toString();

      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigureMeetingScreen(meetingCode: code)));
    }
  }

  getPreviousDetails() {
    String returnedUsername = SharedPreferencesService.getUsername() ?? "Your Name";
    String returnedPhotoLink = SharedPreferencesService.getPhotoLink() ?? "";
    String returnedEmailAddress = SharedPreferencesService.getEmailAddress() ?? "";

    if (returnedUsername != "") {
      setState(() {
        userName = returnedUsername;
      });
    }
    setState(() {
      userProfilePhotoLink = returnedPhotoLink;
    });
    setState(() {
      userEmailAddress = returnedEmailAddress;
    });
  }

  void getAllSavedMeetings() async {
    setState(() {
      savedMeetingsList = SavedMeetingsDBHelper.instance.fetchSavedMeetingsListing();
    });
  }

  void displayNewMeetingOptions() async {
    bool isNetworkConnected = await ConnectivityService.checkConnection();

    if (isNetworkConnected) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.50),
            topRight: Radius.circular(12.50),
          ),
        ),
        builder: (context) {
          return const MeetingOptionsWidget();
        },
      );
    } else {
      Fluttertoast.showToast(msg: "Please check your internet connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 40.0,
        centerTitle: true,
        title: GestureDetector(
          onTap: () async => await launch(ConfigurationValues.developerProfileLink),
          child: Column(
            children: [
              Text(
                "Confab Meetings", style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 18.50,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "developed by Shivam Yadav", style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color.withOpacity(0.90),
                  fontSize: 14.50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ServicePreferencesScreen())),
              icon: const Icon(Feather.menu, size: 22.50),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getAllSavedMeetings(),
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.refresh, color: Colors.white, size: 25.0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            TextFormField(
              controller: meetingCodeFieldController,
              style: GoogleFonts.poppins(
                color: Theme.of(context).iconTheme.color,
                fontSize: 15.50,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                hintText: "Enter your meeting code",
                hintStyle: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color.withOpacity(0.90),
                  fontSize: 15.50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Wrap(
                  spacing: MediaQuery.of(context).size.height * 0.020,
                  runSpacing: MediaQuery.of(context).size.width * 0.020,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.50)),
                        )),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.075,
                          vertical: 14.25,
                        )),
                      ),
                      onPressed: () async {
                        if (meetingCodeFieldController.text != "") {
                          bool isNetworkConnected = await ConnectivityService.checkConnection();

                          if (isNetworkConnected) {
                            if (meetingCodeFieldController.text.contains("https://") || meetingCodeFieldController.text.contains("confab")) {
                              Fluttertoast.showToast(msg: "Please check your meeting code");
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigureMeetingScreen(meetingCode: meetingCodeFieldController.text)));
                            }
                          } else {
                            Fluttertoast.showToast(msg: "Please check your internet connection");
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Please enter your meeting id!!");
                        }
                      },
                      child: Text(
                        "Join meeting", style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(7.50)),
                          side: BorderSide(color: Theme.of(context).iconTheme.color, width: 0.30),
                        )),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.075,
                            vertical: 14.25,
                          ),
                        ),
                      ),
                      onPressed: () => displayNewMeetingOptions(),
                      child: Text(
                        "New meeting", style: GoogleFonts.poppins(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.040),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(color: Theme.of(context).iconTheme.color.withOpacity(0.50), thickness: 1.0),
                  ),
                  Text(
                    "  Saved meetings  ", style: GoogleFonts.poppins(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 14.50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(child: Divider(color: Theme.of(context).iconTheme.color.withOpacity(0.50), thickness: 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            FutureBuilder(
                future: savedMeetingsList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.050),
                        Text(
                          "Something went error, try reopening app!!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 14.50,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }

                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                        Text(
                          "No meetings were saved, please create a meeting and save it for later in order to get it displayed here. We hope you to move further!!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 14.50,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    );
                  }

                  if (snapshot.data.length == 0) {
                    return Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                        Text(
                          "No meetings were saved, please create a meeting and save it for later in order to get it displayed here. We hope you to move further!!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 14.50,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      SavedMeetingData savedMeetingData = snapshot.data[index];

                      if (savedMeetingData != null) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingDetailsScreen(savedMeetingData: savedMeetingData))).then((value) {
                              getAllSavedMeetings();
                            });
                          },
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: SavedMeetingCard(
                            meetingtitle: savedMeetingData.meetingTitle,
                            meetingdescription: savedMeetingData.meetingDescription,
                            timeformeeting: savedMeetingData.meetingDateAndTime,
                          ),
                        );
                      }

                      return Container();
                    },
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
