class RegisterModel {
  String? fullname;
  String? email;
  String? password;
  String? contactNumber;
  String? accessToken;
  String? refreshToken;
  String? role;

  RegisterModel({
    this.fullname,
    this.email,
    this.password,
    this.contactNumber,
    this.accessToken,
    this.refreshToken,
    this.role = 'admin',
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    contactNumber = json['contactno'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['email'] = email;
    data['password'] = password;
    data['contactno'] = contactNumber;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['role'] = role;

    return data;
  }
}
