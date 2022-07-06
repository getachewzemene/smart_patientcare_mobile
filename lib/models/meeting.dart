class Meeting {
  String id;
  String hostId;
  String hostName;
  Meeting({required this.id, required this.hostId, required this.hostName});
  factory Meeting.fromJson(dynamic json) => Meeting(
      id: json["id"] ?? "",
      hostId: json["hostId"] ?? '',
      hostName: json["hostName"] ?? '');
}
