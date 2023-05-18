import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:flutter_mvvm_architecture/data/remote/http/http_request.dart'
    as http;
import 'package:flutter_mvvm_architecture/data/remote/dio/dio_request.dart'
    as dio;
import 'package:flutter_mvvm_architecture/data/remote/resposne_error.dart';
import 'package:flutter_mvvm_architecture/src/user/model/user.dart';

abstract class UserRepo {
  Future<Either<ResponseError, UserModel?>> getDetailedResponse();
}

class UserRepoImplements extends UserRepo {
  @override
  Future<Either<ResponseError, UserModel?>> getDetailedResponse() {
    Random random = Random();
    int randomNumber = random.nextInt(100);

    //TODO
    /*Networks calls can be done with both http and dio.
    (1) Import a package under a namespace to avoid conflicts, For Eg : import 'package:flutter_mvvm_architecture/data/remote/dio/dio_request.dart'
    as dio;
    (2) call function with package, For Eg : dio.safe();*/

    return dio
        .safe(dio.getRequest(endPoint: "todos/$randomNumber"))
        .thenRight(dio.checkHttpStatus)
        .thenRight(dio.parseJson)
        .mapRight((right) {
      return UserModel.fromJson(right);
    });
    return http
        .safe(http.getRequest(endPoint: "todos/$randomNumber"))
        .thenRight(http.checkHttpStatus)
        .thenRight(http.parseJson)
        .mapRight((right) {
      return UserModel.fromJson(right);
    });
  }
}
