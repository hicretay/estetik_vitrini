// To parse this JSON data, do
//
//     final companyAppointmentListJsn = companyAppointmentListJsnFromJson(jsonString);

import 'dart:convert';

CompanyAppointmentListJsn companyAppointmentListJsnFromJson(String str) => CompanyAppointmentListJsn.fromJson(json.decode(str));

String companyAppointmentListJsnToJson(CompanyAppointmentListJsn data) => json.encode(data.toJson());

class CompanyAppointmentListJsn {
    CompanyAppointmentListJsn({
        this.success,
        this.result,
    });

    bool? success;
    List<Result>? result;

    factory CompanyAppointmentListJsn.fromJson(Map<String, dynamic> json) => CompanyAppointmentListJsn(
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
        this.id,
        this.companyName,
        this.operationName,
        this.appointmentTime,
        this.appointmentDate,
        this.phone,
        this.customerName,
        this.confirmed,
    });

    int? id;
    String? companyName;
    String? operationName;
    String? appointmentTime;
    String? appointmentDate;
    String? phone;
    String? customerName;
    bool? confirmed;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        companyName: json["companyName"],
        operationName: json["operationName"],
        appointmentTime: json["appointmentTime"],
        appointmentDate: json["appointmentDate"],
        phone: json["phone"],
        customerName: json["customerName"],
        confirmed: json["confirmed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "operationName": operationName,
        "appointmentTime": appointmentTime,
        "appointmentDate": appointmentDate,
        "phone": phone,
        "customerName": customerName,
        "confirmed": confirmed,
    };
}
