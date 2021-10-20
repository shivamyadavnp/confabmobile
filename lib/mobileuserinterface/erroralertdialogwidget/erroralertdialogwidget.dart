import 'package:confabmobile/softwarepackages.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String errorMessageTitle;
  final String errorMessageContent;

  const ErrorDialogWidget({Key key, this.errorMessageTitle, this.errorMessageContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.50))),
      elevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12.50)),
          border: Border.all(color: Theme.of(context).iconTheme.color.withOpacity(0.50), width: 0.60)
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.045),
              Center(
                child: Text(
                  errorMessageTitle.toString(), style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Center(
                child: Text(
                  errorMessageContent.toString(), style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color.withOpacity(0.75),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.035),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  elevation: MaterialStateProperty.all(0.0),
                  overlayColor: MaterialStateProperty.all(kPrimaryColor.withOpacity(0.10)),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15.0)),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(color: kPrimaryColor, width: 0.50),
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "OK", style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.045),
            ],
          ),
        ),
      ),
    );
  }
}
