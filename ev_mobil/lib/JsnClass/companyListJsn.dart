import 'dart:convert';

CompanyListJsn companyListJsnFromJson(String str) => CompanyListJsn.fromJson(json.decode(str));

String companyListJsnToJson(CompanyListJsn data) => json.encode(data.toJson());

class CompanyListJsn {
    CompanyListJsn({
        this.success,
        this.result,
    });

    bool success;
    List<Result> result;

    factory CompanyListJsn.fromJson(Map<String, dynamic> json) => CompanyListJsn(
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
        this.companyName,
        this.companyLogo,
    });

    int id;
    String companyName;
    String companyLogo;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "companyLogo": companyLogo,
    };
}