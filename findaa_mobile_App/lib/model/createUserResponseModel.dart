import 'dart:convert';

CreateUserResponseMode createUserResponseModeFromJson(String str) =>
    CreateUserResponseMode.fromJson(json.decode(str));

String createUserResponseModeToJson(CreateUserResponseMode data) =>
    json.encode(data.toJson());

class CreateUserResponseMode {
  CreateUserResponseMode({
    this.data,
  });

  Data data;

  factory CreateUserResponseMode.fromJson(Map<String, dynamic> json) =>
      CreateUserResponseMode(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.createUser,
  });

  CreateUser createUser;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createUser: CreateUser.fromJson(json["createUser"]),
      );

  Map<String, dynamic> toJson() => {
        "createUser": createUser.toJson(),
      };
}

class CreateUser {
  CreateUser({
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.password,
    this.city,
    this.locality,
  });

  String firstName;
  String lastName;
  String mobileNo;
  String password;
  String city;
  String locality;

  factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNo: json["mobileNo"],
        password: json["password"],
        city: json["city"],
        locality: json["locality"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "mobileNo": mobileNo,
        "password": password,
        "city": city,
        "locality": locality,
      };
}
