import 'dart:convert';

UserFavoriAreaJsn userFavoriAreaJsnFromJson(String str) => UserFavoriAreaJsn.fromJson(json.decode(str));

String userFavoriAreaJsnToJson(UserFavoriAreaJsn data) => json.encode(data.toJson());

class UserFavoriAreaJsn {
    UserFavoriAreaJsn({
        this.success,
        this.result,
    });

    bool? success;
    List<Result>? result;

    factory UserFavoriAreaJsn.fromJson(Map<String, dynamic> json) => UserFavoriAreaJsn(
        success: json["success"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.cityId,
        this.countyId,
    });

    int? cityId;
    int? countyId;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        cityId: json["cityId"],
        countyId: json["countyId"],
    );

    Map<String, dynamic> toJson() => {
        "cityId": cityId,
        "countyId": countyId,
    };
}
