import 'dart:convert';

CountyJsn countyJsnFromJson(String str) => CountyJsn.fromJson(json.decode(str));

String countyJsnToJson(CountyJsn data) => json.encode(data.toJson());

class CountyJsn {
    CountyJsn({
        this.success,
        this.result,
    });

    bool? success;
    List<Result>? result;

    factory CountyJsn.fromJson(Map<String, dynamic> json) => CountyJsn(
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
        this.id,
        this.county,
    });

    int? id;
    String? county;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        county: json["county"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "county": county,
    };
}
