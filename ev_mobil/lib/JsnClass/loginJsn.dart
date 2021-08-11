import 'dart:convert';

LoginJsn loginJsnFromJson(String str) => LoginJsn.fromJson(json.decode(str));

String loginJsnToJson(LoginJsn data) => json.encode(data.toJson());

class LoginJsn {
    LoginJsn({
        this.userName,
        this.password,
        this.social,
    });

    String userName;
    String password;
    bool social;

    factory LoginJsn.fromJson(Map<String, dynamic> json) => LoginJsn(
        userName: json["userName"],
        password: json["password"],
        social: json["social"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
        "social": social,
    };
}
