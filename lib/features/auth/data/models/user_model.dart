// {
// "code": 200,
// "status": "success",
// "msg": "Successfully verified email address",
// "data": {
// "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2YTRjZjU0NzA0NWU4YmVlM2M0Y2I1NGMiLCJmaXJzdF9uYW1lIjoic2EiLCJsYXN0X25hbWUiOiJuYWhpZCIsImVtYWlsIjoic2FAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsInBob25lIjoiMCIsInBob25lX3ZlcmlmaWVkIjpmYWxzZSwiYXZhdGFyX3VybCI6bnVsbCwiY2l0eSI6InN5bGhldCIsInJvbGUiOjAsImlhdCI6MTc4MzUxMDk1NCwiZXhwIjoxNzg0MTE1NzU0fQ.XLi3X8CiRr4sS_btvPz29CO3MS3PbcJQ8LSHWZ_0pH0",
// "user": {
// "_id": "6a4cf547045e8bee3c4cb54c",
// "first_name": "sa",
// "last_name": "nahid",
// "email": "sa@gmail.com",
// "email_verified": true,
// "phone": "0",
// "phone_verified": false,
// "avatar_url": null,
// "city": "sylhet",
// "role": 0
// }
// }
// }

class UserModel {
  String first_name;
  String last_name;
  String email;
  String phone;
  String? avatar_url;
  String city;

  UserModel({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
    this.avatar_url,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      avatar_url: json['avatar_url'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'avatar_url': avatar_url,
      'city': city,
    };
  }
}
