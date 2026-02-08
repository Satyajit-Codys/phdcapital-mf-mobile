class Nominee {
  final String name;
  final DateTime dob;
  final String relationship;
  final int share;
  final bool isMinor;
  final String? guardianName;
  final String? guardianPan;
  final String? addressLine1;
  final String? addressLine2;

  Nominee({
    required this.name,
    required this.dob,
    required this.relationship,
    required this.share,
    required this.isMinor,
    this.guardianName,
    this.guardianPan,
    this.addressLine1,
    this.addressLine2,
  });
}
