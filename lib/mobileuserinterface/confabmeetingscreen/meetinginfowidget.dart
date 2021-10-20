import 'package:confabmobile/softwarepackages.dart';

class SavedMeetingCard extends StatefulWidget {
  final String meetingtitle;
  final String meetingdescription;
  final String timeformeeting;

  const SavedMeetingCard({
    Key key, 
    this.meetingtitle,
    this.meetingdescription,
    this.timeformeeting,
  }) : super(key: key);

  @override
  _SavedMeetingCardState createState() => _SavedMeetingCardState();
}

class _SavedMeetingCardState extends State<SavedMeetingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color.withOpacity(0.030),
        borderRadius: const BorderRadius.all(Radius.circular(12.50)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        children: [
          Container(height: 70.0, width: 2.0, color: kPrimaryColor),
          const SizedBox(width: 15.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.meetingtitle != null ? widget.meetingtitle.toString() : "Saved meeting title",
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                widget.timeformeeting == "" ? Container() : const SizedBox(height: 5.0),
                widget.timeformeeting == "" ? Container() : Text(
                  widget.timeformeeting != null ? widget.timeformeeting.toString() : "Time for your meeting",
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color.withOpacity(0.90),
                    fontSize: 14.50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                widget.timeformeeting == "" ? const SizedBox(height: 20.0) : const SizedBox(height: 10.0),
                Text(
                  widget.meetingdescription != null ? widget.meetingdescription.toString() : "Description of your meeting",
                  maxLines: null,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).iconTheme.color.withOpacity(0.75),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
