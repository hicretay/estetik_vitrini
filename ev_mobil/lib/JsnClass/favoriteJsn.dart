import 'dart:convert';

FavoriteJsn favoriteJsnFromJson(String str) => FavoriteJsn.fromJson(json.decode(str));

String favoriteJsnToJson(FavoriteJsn data) => json.encode(data.toJson());

class FavoriteJsn {
    FavoriteJsn({
        this.success,
        this.result,
    });

    bool success;
    String result;

    factory FavoriteJsn.fromJson(Map<String, dynamic> json) => FavoriteJsn(
        success: json["success"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
    };
}