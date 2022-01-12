import 'dart:convert';

LikeJsn likeJsnFromJson(String str) => LikeJsn.fromJson(json.decode(str));

String likeJsnToJson(LikeJsn data) => json.encode(data.toJson());

class LikeJsn {
    LikeJsn({
        this.success,
        this.result,
    });

    bool? success;
    String? result;

    factory LikeJsn.fromJson(Map<String, dynamic> json) => LikeJsn(
        success: json["success"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
    };
}