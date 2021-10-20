class SavedMeetingData {
  String meetingTitle;
  String meetingDescription;
  String meetingDateAndTime;
  String meetingCode;
  String meetingLink;

  SavedMeetingData({
    this.meetingTitle,
    this.meetingDescription,
    this.meetingDateAndTime,
    this.meetingCode,
    this.meetingLink,
  });

  Map toMap() {
    var map = <String, dynamic>{};
    map["meetingTitle"] = meetingTitle;
    map["meetingDescription"] = meetingDescription;
    map["meetingDateAndTime"] = meetingDateAndTime;
    map["meetingCode"] = meetingCode;
    map["meetingLink"] = meetingLink;
    return map;
  }

  SavedMeetingData fromMap(Map<String, dynamic> map) {
    SavedMeetingData savedMeetingData = SavedMeetingData();
    savedMeetingData.meetingTitle = map["meetingTitle"];
    savedMeetingData.meetingDescription = map["meetingDescription"];
    savedMeetingData.meetingDateAndTime = map["meetingDateAndTime"];
    savedMeetingData.meetingCode = map["meetingCode"];
    savedMeetingData.meetingLink = map["meetingLink"];
    return savedMeetingData;
  }
}
