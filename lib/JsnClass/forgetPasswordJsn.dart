import 'dart:convert';

ForgetPasswordJsn forgetPasswordJsnFromJson(String str) => ForgetPasswordJsn.fromJson(json.decode(str));

String forgetPasswordJsnToJson(ForgetPasswordJsn data) => json.encode(data.toJson());

class ForgetPasswordJsn {
    ForgetPasswordJsn({
        this.success,
        this.result,
    });

    bool success;
    bool result;

    factory ForgetPasswordJsn.fromJson(Map<String, dynamic> json) => ForgetPasswordJsn(
        success: json["success"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
    };
}
