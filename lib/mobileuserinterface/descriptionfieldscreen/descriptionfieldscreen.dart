import 'package:confabmobile/softwarepackages.dart';

class AboutMeetingEditScreen extends StatefulWidget {
  final String previousDescriptionText;

  const AboutMeetingEditScreen({Key key, this.previousDescriptionText}) : super(key: key);

  @override
  _AboutMeetingEditScreenState createState() => _AboutMeetingEditScreenState();
}

class _AboutMeetingEditScreenState extends State<AboutMeetingEditScreen> {
  TextEditingController aboutMeetingFieldController = TextEditingController();

  fillPreviousDetails() {
    aboutMeetingFieldController.text = widget.previousDescriptionText ?? "";
  }

  @override
  void initState() {
    fillPreviousDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 15.0,
        titleSpacing: NavigationToolbar.kMiddleSpacing * 0.10,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          padding: const EdgeInsets.all(2.0),
          icon: Icon(Feather.x, color: Theme.of(context).iconTheme.color, size: 20.0),
        ),
        title: Text(
          "Edit meeting description", style: GoogleFonts.poppins(
            color: Theme.of(context).iconTheme.color,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            icon: const Icon(Icons.check, color: kPrimaryColor, size: 20.0),
            onPressed: () {
              Navigator.pop(context, aboutMeetingFieldController.text == null ? "" : aboutMeetingFieldController.text.toString());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.50,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: null,
                controller: aboutMeetingFieldController,
                keyboardType: TextInputType.multiline,
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
                    color: Theme.of(context).iconTheme.color.withOpacity(0.85),
                    fontSize: 15.50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
