import 'dart:convert';

CompanyOperationJsn companyOperationJsnFromJson(String str) => CompanyOperationJsn.fromJson(json.decode(str));

String companyOperationJsnToJson(CompanyOperationJsn data) => json.encode(data.toJson());

class CompanyOperationJsn {
    CompanyOperationJsn({
        this.success,
        this.result,
    });

    bool success;
    List<Result> result;

    factory CompanyOperationJsn.fromJson(Map<String, dynamic> json) => CompanyOperationJsn(
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
        this.operationName,
    });

    int id;
    String operationName;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        operationName: json["operationName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "operationName": operationName,
    };
}
