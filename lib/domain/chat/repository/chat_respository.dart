import 'package:dartz/dartz.dart';

abstract class ChatRespository {
  Future<Either> sendMessage(String message);
}
