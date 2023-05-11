import 'dart:convert';

AddUserJsn addUserJsnFromJson(String str) => AddUserJsn.fromJson(json.decode(str));

String addUserJsnToJson(AddUserJsn data) => json.encode(data.toJson());

class AddUserJsn {
    AddUserJsn({
        this.success,
        this.result,
    });

    bool? success;
    String? result;

    factory AddUserJsn.fromJson(Map<String, dynamic> json) => AddUserJsn(
        success: json["success"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
    };
}