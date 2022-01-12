import 'dart:convert';

AddUserCityJsn addUserCityJsnFromJson(String str) => AddUserCityJsn.fromJson(json.decode(str));

String addUserCityJsnToJson(AddUserCityJsn data) => json.encode(data.toJson());

class AddUserCityJsn {
    AddUserCityJsn({
        this.success,
        this.result,
    });

    bool? success;
    String? result;

    factory AddUserCityJsn.fromJson(Map<String, dynamic> json) => AddUserCityJsn(
        success: json["success"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
    };
}