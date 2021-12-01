import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'get_s_3_file_request.freezed.dart';
part 'get_s_3_file_request.g.dart';

GetS3FileRequest getS3FileRequestFromJson(String str) => GetS3FileRequest.fromJson(json.decode(str));

String getS3FileRequestToJson(GetS3FileRequest data) => json.encode(data.toJson());

@freezed
class GetS3FileRequest with _$GetS3FileRequest {
  const factory GetS3FileRequest({
    required String fileId,
    required String fileType,
  }) = _GetS3FileRequest;

  factory GetS3FileRequest.fromJson(Map<String, dynamic> json) => _$GetS3FileRequestFromJson(json);
}
