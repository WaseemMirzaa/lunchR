class AddChildren {
  final String parentId;
  final String childName;
  final String childSchoolID;
  final String schoolName;
  final String childImageUrl; // Add image URL

  AddChildren({
    required this.childName,
    required this.parentId,
    required this.childSchoolID,
    required this.schoolName,
    required this.childImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'childName': childName,
      'childSchoolID': childSchoolID,
      'schoolName': schoolName,
      'childImageUrl': childImageUrl,
    };
  }

  factory AddChildren.fromJson(Map<String, dynamic> json) {
    return AddChildren(
      parentId: json['parentId'],
      childName: json['childName'],
      childSchoolID: json['childSchoolID'],
      schoolName: json['schoolName'],
      childImageUrl: json['childImageUrl'] ?? '',
    );
  }
}
