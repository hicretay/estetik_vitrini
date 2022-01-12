import 'dart:convert';

FavoriCompanyJsn favoriCompanyJsnFromJson(String str) => FavoriCompanyJsn.fromJson(json.decode(str));

String favoriCompanyJsnToJson(FavoriCompanyJsn data) => json.encode(data.toJson());

class FavoriCompanyJsn {
    FavoriCompanyJsn({
        this.success,
        this.result,
    });

    bool? success;
    List<Result>? result;

    factory FavoriCompanyJsn.fromJson(Map<String, dynamic> json) => FavoriCompanyJsn(
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
        this.companyId,
        this.campaingId,
        this.companyName,
        this.companyLogo,
        this.companyPhone,
        this.googleAdressLink,
        this.contentPicture,
        this.contentTitle,
        this.liked,
        this.likeCount,
    });

    int? companyId;
    int? campaingId;
    String? companyName;
    String? companyLogo;
    String? companyPhone;
    String? googleAdressLink;
    String? contentPicture;
    String? contentTitle;
    bool? liked;
    int? likeCount;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        companyId: json["companyId"],
        campaingId: json["campaingId"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
        companyPhone: json["companyPhone"],
        googleAdressLink: json["googleAdressLink"],
        contentPicture: json["contentPicture"],
        contentTitle: json["contentTitle"],
        liked: json["liked"],
        likeCount: json["likeCount"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "campaingId": campaingId,
        "companyName": companyName,
        "companyLogo": companyLogo,
        "companyPhone": companyPhone,
        "googleAdressLink": googleAdressLink,
        "contentPicture": contentPicture,
        "contentTitle": contentTitle,
        "liked": liked,
        "likeCount": likeCount,
    };
}
