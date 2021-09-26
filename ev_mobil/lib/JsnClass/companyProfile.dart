import 'dart:convert';

List<CompanyProfileJsn> companyProfileJsnFromJson(String str) => List<CompanyProfileJsn>.from(json.decode(str).map((x) => CompanyProfileJsn.fromJson(x)));

String companyProfileJsnToJson(List<CompanyProfileJsn> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyProfileJsn {
    CompanyProfileJsn({
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

    int id;
    String companyName;
    String companyLogo;
    String companyPhone;
    String companyPhone2;
    String googleAdressLink;
    int likeCount;
    int campaignCount;
    int favCount;
    String eMail;
    String web;
    List<CampaignList> campaignList;

    factory CompanyProfileJsn.fromJson(Map<String, dynamic> json) => CompanyProfileJsn(
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
        "campaignList": List<dynamic>.from(campaignList.map((x) => x.toJson())),
    };
}

class CampaignList {
    CampaignList({
        this.campaingId,
        this.companyName,
        this.companyLogo,
    });

    int campaingId;
    String companyName;
    String companyLogo;

    factory CampaignList.fromJson(Map<String, dynamic> json) => CampaignList(
        campaingId: json["campaingId"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
    );

    Map<String, dynamic> toJson() => {
        "campaingId": campaingId,
        "companyName": companyName,
        "companyLogo": companyLogo,
    };
}
