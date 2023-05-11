import 'dart:convert';

CompanyInfUpdateJsn companyInfUpdateJsnFromJson(String str) => CompanyInfUpdateJsn.fromJson(json.decode(str));

String companyInfUpdateJsnToJson(CompanyInfUpdateJsn data) => json.encode(data.toJson());

class CompanyInfUpdateJsn {
    CompanyInfUpdateJsn({
        this.success,
        this.result,
    });

    bool? success;
    String? result;

    factory CompanyInfUpdateJsn.fromJson(Map<String, dynamic> json) => CompanyInfUpdateJsn(
        success: json["success"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
    };
}