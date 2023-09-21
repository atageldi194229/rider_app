//
//  Generated code. Do not modify.
//  source: tracker.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'tracker.pb.dart' as $0;

export 'tracker.pb.dart';

@$pb.GrpcServiceName('protobuf.Tracker')
class TrackerClient extends $grpc.Client {
  static final _$updateLocation = $grpc.ClientMethod<$0.LocationRequest, $0.Response>('/protobuf.Tracker/updateLocation', ($0.LocationRequest value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.Response.fromBuffer(value));

  TrackerClient($grpc.ClientChannel channel, {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors}) : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Response> updateLocation($async.Stream<$0.LocationRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$updateLocation, request, options: options);
  }
}

@$pb.GrpcServiceName('protobuf.Tracker')
abstract class TrackerServiceBase extends $grpc.Service {
  $core.String get $name => 'protobuf.Tracker';

  TrackerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.LocationRequest, $0.Response>('updateLocation', updateLocation, true, true, ($core.List<$core.int> value) => $0.LocationRequest.fromBuffer(value), ($0.Response value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Response> updateLocation($grpc.ServiceCall call, $async.Stream<$0.LocationRequest> request);
}
