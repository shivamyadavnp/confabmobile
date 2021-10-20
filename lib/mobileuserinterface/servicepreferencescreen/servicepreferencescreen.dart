import 'package:confabmobile/softwarepackages.dart';

class ServicePreferencesScreen extends StatefulWidget {
  const ServicePreferencesScreen({Key key}) : super(key: key);

  @override
  _ServicePreferencesScreenState createState() => _ServicePreferencesScreenState();
}

class _ServicePreferencesScreenState extends State<ServicePreferencesScreen> {
  String currentUsername = "";

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  getProfileDetails() {
    setState(() {
      currentUsername = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 15.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, size: 25.0),
        ),
        titleSpacing: NavigationToolbar.kMiddleSpacing * 0.10,
        title: Text(
          "Settings and preferences", style: GoogleFonts.poppins(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: 17.50,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Confab Meetings", style: GoogleFonts.poppins(
                    fontSize: 20.50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "developed by Shivam Yadav", style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color.withOpacity(0.85),
                    fontSize: 16.50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.075),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountProfileScreen())).whenComplete(() {
                  getProfileDetails();
                });
              },
              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.50)),
              ),
              tileColor: kPrimaryColor.withOpacity(0.25),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountProfileScreen())).whenComplete(() {
                      getProfileDetails();
                    });
                  },
                  icon: Icon(Feather.user, color: Theme.of(context).iconTheme.color, size: 21.50),
                ),
              ),
              title: Text(
                currentUsername.toString() ?? "Username", style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            ListTile(
              onTap: () async => await launch(ConfigurationValues.appStoreLink),
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () async => await launch(ConfigurationValues.appStoreLink),
                  icon: const Icon(Feather.star, color: Colors.orangeAccent, size: 20.0),
                ),
              ),
              title: Text(
                "Rate app on Google Play", style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutAndPoliciesScreen())),
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutAndPoliciesScreen())),
                  icon: Icon(Feather.info, color: Theme.of(context).iconTheme.color, size: 20.0),
                ),
              ),
              title: Text(
                "About and policies", style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () async => await launch(ConfigurationValues.sendFeedbackLink),
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () async => await launch(ConfigurationValues.sendFeedbackLink),
                  icon: Icon(Feather.send, color: Theme.of(context).iconTheme.color, size: 20.0),
                ),
              ),
              title: Text(
                "Send feedback", style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              onTap: () async => await ShareTheApp.perforrmFunction(context),
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: IconButton(
                  onPressed: () async => await ShareTheApp.perforrmFunction(context),
                  icon: Icon(Feather.share, color: Theme.of(context).iconTheme.color, size: 20.0),
                ),
              ),
              title: Text(
                "Share Confab with others", style: GoogleFonts.poppins(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.050),
          ],
        ),
      ),
    );
  }
}
