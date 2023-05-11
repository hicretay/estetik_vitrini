import 'dart:convert';

DeleteAppointmentCompanyJsn deleteAppointmentCompanyJsnFromJson(String str) => DeleteAppointmentCompanyJsn.fromJson(json.decode(str));

String deleteAppointmentCompanyJsnToJson(DeleteAppointmentCompanyJsn data) => json.encode(data.toJson());

class DeleteAppointmentCompanyJsn {
    DeleteAppointmentCompanyJsn({
        this.success,
        this.result,
    });

    bool? success;
    String? result;

    factory DeleteAppointmentCompanyJsn.fromJson(Map<String, dynamic> json) => DeleteAppointmentCompanyJsn(
        success: json["success"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
    };
}
