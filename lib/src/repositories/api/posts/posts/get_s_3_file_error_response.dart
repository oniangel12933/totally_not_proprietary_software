import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'get_s_3_file_error_response.freezed.dart';
part 'get_s_3_file_error_response.g.dart';

GetS3FileErrorResponse getS3FileErrorResponseFromJson(String str) => GetS3FileErrorResponse.fromJson(json.decode(str));

String getS3FileErrorResponseToJson(GetS3FileErrorResponse data) => json.encode(data.toJson());

@freezed
class GetS3FileErrorResponse with _$GetS3FileErrorResponse {
  const factory GetS3FileErrorResponse({
    List<Detail>? detail,
  }) = _GetS3FileErrorResponse;

  factory GetS3FileErrorResponse.fromJson(Map<String, dynamic> json) => _$GetS3FileErrorResponseFromJson(json);
}

@freezed
class Detail with _$Detail {
  const factory Detail({
    List<String>? loc,
    String? msg,
    String? type,
  }) = _Detail;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}
