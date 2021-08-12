import 'dart:convert';

LoginJsn loginJsnFromJson(String str) => LoginJsn.fromJson(json.decode(str));

String loginJsnToJson(LoginJsn data) => json.encode(data.toJson());

class LoginJsn {
    LoginJsn({
        this.success,
        this.result,
    });

    bool success;
    Result result;

    factory LoginJsn.fromJson(Map<String, dynamic> json) => LoginJsn(
        success: json["success"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.id,
        this.nameSurname,
        this.country,
        this.city,
        this.county,
    });

    int id;
    String nameSurname;
    int country;
    int city;
    int county;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        nameSurname: json["nameSurname"],
        country: json["country"],
        city: json["city"],
        county: json["county"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nameSurname": nameSurname,
        "country": country,
        "city": city,
        "county": county,
    };
}

