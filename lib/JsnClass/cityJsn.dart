import 'dart:convert';

CityJsn cityJsnFromJson(String str) => CityJsn.fromJson(json.decode(str));

String cityJsnToJson(CityJsn data) => json.encode(data.toJson());

class CityJsn {
    CityJsn({
        this.success,
        this.result,
    });

    bool success;
    List<Result> result;

    factory CityJsn.fromJson(Map<String, dynamic> json) => CityJsn(
        success: json["success"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.city,
    });

    int id;
    String city;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
    };
}
