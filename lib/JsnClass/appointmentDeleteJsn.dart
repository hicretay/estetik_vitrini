import 'dart:convert';

AppointmentDeleteJsn appointmentDeleteJsnFromJson(String str) => AppointmentDeleteJsn.fromJson(json.decode(str));

String appointmentDeleteJsnToJson(AppointmentDeleteJsn data) => json.encode(data.toJson());

class AppointmentDeleteJsn {
    AppointmentDeleteJsn({
        this.success,
    });

    bool? success;

    factory AppointmentDeleteJsn.fromJson(Map<String, dynamic> json) => AppointmentDeleteJsn(
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
    };
}