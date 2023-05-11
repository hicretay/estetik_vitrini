import 'dart:convert';

CompanyProfileJsn companyProfileJsnFromJson(String str) => CompanyProfileJsn.fromJson(json.decode(str));

String companyProfileJsnToJson(CompanyProfileJsn data) => json.encode(data.toJson());

class CompanyProfileJsn {
    CompanyProfileJsn({
        this.success,
        this.result,
    });

    bool? success;
    Result? result;

    factory CompanyProfileJsn.fromJson(Map<String, dynamic> json) => CompanyProfileJsn(
        success: json["success"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result!.toJson(),
    };
}

class Result {
    Result({
        this.id,
        this.companyName,
        this.companyLogo,
        this.companyPhone,
        this.companyPhone2,
        this.googleAdressLink,
        this.likeCount,
        this.campaignCount,
        this.favCount,
        this.eMail,
        this.web,
        this.campaignList,
    });

    int? id;
    String? companyName;
    String? companyLogo;
    String? companyPhone;
    String? companyPhone2;
    String? googleAdressLink;
    int? likeCount;
    int? campaignCount;
    int? favCount;
    String? eMail;
    String? web;
    List<CampaignList>? campaignList;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
        companyPhone: json["companyPhone"],
        companyPhone2: json["companyPhone2"],
        googleAdressLink: json["googleAdressLink"],
        likeCount: json["likeCount"],
        campaignCount: json["campaignCount"],
        favCount: json["favCount"],
        eMail: json["eMail"],
        web: json["web"],
        campaignList: List<CampaignList>.from(json["campaignList"].map((x) => CampaignList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "companyLogo": companyLogo,
        "companyPhone": companyPhone,
        "companyPhone2": companyPhone2,
        "googleAdressLink": googleAdressLink,
        "likeCount": likeCount,
        "campaignCount": campaignCount,
        "favCount": favCount,
        "eMail": eMail,
        "web": web,
        "campaignList": List<dynamic>.from(campaignList!.map((x) => x.toJson())),
    };
}

class CampaignList {
    CampaignList({
        this.campaingId,
        this.campaingName,
        this.campaingLogo,
    });

    int? campaingId;
    String? campaingName;
    String? campaingLogo;

    factory CampaignList.fromJson(Map<String, dynamic> json) => CampaignList(
        campaingId: json["campaingId"],
        campaingName: json["campaingName"],
        campaingLogo: json["campaingLogo"],
    );

    Map<String, dynamic> toJson() => {
        "campaingId": campaingId,
        "campaingName": campaingName,
        "campaingLogo": campaingLogo,
    };
}
