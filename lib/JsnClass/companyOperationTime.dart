import 'dart:convert';

CompanyOperationTimeJsn companyOperationTimeJsnFromJson(String str) => CompanyOperationTimeJsn.fromJson(json.decode(str));

String companyOperationTimeJsnToJson(CompanyOperationTimeJsn data) => json.encode(data.toJson());

class CompanyOperationTimeJsn {
    CompanyOperationTimeJsn({
        this.success,
        this.result,
    });

    bool? success;
    List<Result>? result;

    factory CompanyOperationTimeJsn.fromJson(Map<String, dynamic> json) => CompanyOperationTimeJsn(
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
        this.operationStartTime,
        this.operationEndTime,
    });

    int? id;
    String? operationStartTime;
    String? operationEndTime;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        operationStartTime: json["operationStartTime"],
        operationEndTime: json["operationEndTime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "operationStartTime": operationStartTime,
        "operationEndTime": operationEndTime,
    };
}