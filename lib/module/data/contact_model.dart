class ContactModel {
  final String avatar;
  final String name;
  final String mobileNumber;

  ContactModel({
    required this.avatar,
    required this.name,
    required this.mobileNumber,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      avatar: json['avatar'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'name': name,
      'mobileNumber': mobileNumber,
    };
  }
}
