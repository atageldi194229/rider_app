//
//  Generated code. Do not modify.
//  source: tracker.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use locationRequestDescriptor instead')
const LocationRequest$json = {
  '1': 'LocationRequest',
  '2': [
    {'1': 'member_id', '3': 1, '4': 1, '5': 9, '10': 'memberId'},
    {'1': 'latitude', '3': 2, '4': 1, '5': 9, '10': 'latitude'},
    {'1': 'longitude', '3': 3, '4': 1, '5': 9, '10': 'longitude'},
    {'1': 'trip_id', '3': 4, '4': 1, '5': 9, '10': 'tripId'},
    {'1': 'warehouse_id', '3': 5, '4': 1, '5': 9, '10': 'warehouseId'},
    {'1': 'date', '3': 6, '4': 1, '5': 9, '10': 'date'},
    {'1': 'bearing', '3': 7, '4': 1, '5': 9, '10': 'bearing'},
    {'1': 'speed', '3': 8, '4': 1, '5': 9, '10': 'speed'},
  ],
};

/// Descriptor for `LocationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationRequestDescriptor = $convert.base64Decode('Cg9Mb2NhdGlvblJlcXVlc3QSGwoJbWVtYmVyX2lkGAEgASgJUghtZW1iZXJJZBIaCghsYXRpdH'
    'VkZRgCIAEoCVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAMgASgJUglsb25naXR1ZGUSFwoHdHJp'
    'cF9pZBgEIAEoCVIGdHJpcElkEiEKDHdhcmVob3VzZV9pZBgFIAEoCVILd2FyZWhvdXNlSWQSEg'
    'oEZGF0ZRgGIAEoCVIEZGF0ZRIYCgdiZWFyaW5nGAcgASgJUgdiZWFyaW5nEhQKBXNwZWVkGAgg'
    'ASgJUgVzcGVlZA==');

@$core.Deprecated('Use responseDescriptor instead')
const Response$json = {
  '1': 'Response',
  '2': [
    {'1': 'result', '3': 1, '4': 1, '5': 9, '10': 'result'},
  ],
};

/// Descriptor for `Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDescriptor = $convert.base64Decode('CghSZXNwb25zZRIWCgZyZXN1bHQYASABKAlSBnJlc3VsdA==');
