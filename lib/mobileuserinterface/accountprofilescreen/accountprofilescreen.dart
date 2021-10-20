import 'package:confabmobile/softwarepackages.dart';

class AccountProfileScreen extends StatefulWidget {
  const AccountProfileScreen({Key key}) : super(key: key);

  @override
  _AccountProfileScreenState createState() => _AccountProfileScreenState();
}

class _AccountProfileScreenState extends State<AccountProfileScreen> {
  TextEditingController userNameFieldController = TextEditingController();
  TextEditingController profilePhotoLinkController = TextEditingController();
  TextEditingController emailAddressFieldController = TextEditingController();

  saveProfileDetails() async {
    try {
      await SharedPreferencesService.setUsername(userNameFieldController.text.toString() ?? "");
      await SharedPreferencesService.setPhotoLink(profilePhotoLinkController.text.toString() ?? "");
      await SharedPreferencesService.setEmailAddress(emailAddressFieldController.text.toString() ?? "");

      if (userNameFieldController.text != "") {
        setState(() {
          userName = userNameFieldController.text;
        });
      }
      setState(() {
        userProfilePhotoLink = profilePhotoLinkController.text ?? "";
      });
      setState(() {
        userEmailAddress = emailAddressFieldController.text ?? "";
      });
      Fluttertoast.showToast(
        msg: "Profile changes saved",
      );
    } catch (error) {
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

  getPreviousDetails() {
    String returnedPhotoLink = SharedPreferencesService.getPhotoLink() ?? "";
    String returnedEmailAddress = SharedPreferencesService.getEmailAddress() ?? "";

    if (userName != "") {
      setState(() {
        userNameFieldController.text = userName;
      });
    }
    setState(() {
      profilePhotoLinkController.text = returnedPhotoLink;
    });
    setState(() {
      emailAddressFieldController.text = returnedEmailAddress;
    });
  }

  @override
  void initState() {
    getPreviousDetails();
    super.initState();
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
          "Account and profile", style: GoogleFonts.poppins(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: 17.50,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Center(
                child: profilePhotoLinkController.text.contains("https://") ? CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                  backgroundImage: NetworkImage(profilePhotoLinkController.text),
                ) : CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                  child: Text(userNameFieldController.text[0].toString(), style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.050),
              TextFormField(
                controller: userNameFieldController,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  hintText: "Your name or nickname",
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: Icon(Feather.edit, color: Theme.of(context).iconTheme.color, size: 18.0),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.030),
              TextFormField(
                controller: profilePhotoLinkController,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  hintText: "Profile photo link",
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: Icon(Feather.edit, color: Theme.of(context).iconTheme.color, size: 18.0),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.030),
              TextFormField(
                controller: emailAddressFieldController,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).iconTheme.color.withOpacity(0.10),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  hintText: "Email address",
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: Icon(Feather.edit, color: Theme.of(context).iconTheme.color, size: 18.0),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.050),
              Center(
                child: TextButton(
                  onPressed: () => saveProfileDetails(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.50)),
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.50)),
                      side: BorderSide.none,
                    )),
                  ),
                  child: Text("Save changes", style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.50,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.050),
              Text(
                "None of information above are stored in our database. These data are used inside meeting only!!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).iconTheme.color.withOpacity(0.85),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.050),
            ],
          ),
        ),
      ),
    );
  }
}
