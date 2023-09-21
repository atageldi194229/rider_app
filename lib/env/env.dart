import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SERVER_URL')
  static const String serverUrl = _Env.serverUrl;

  @EnviedField(varName: 'MAP_URL')
  static const String mapUrl = _Env.mapUrl;

  @EnviedField(varName: 'GRPC_URL')
  static const String grpcUrl = _Env.grpcUrl;

  @EnviedField(varName: 'GRPC_PORT')
  static const int grpcPort = _Env.grpcPort;
}
