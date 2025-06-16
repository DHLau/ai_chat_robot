import 'dart:convert';

import 'package:ai_chat_robot/data/chat/models/chat_pair_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

abstract class ChatOpenRouterService {
  Future<Either> sendMessage(String message);
  Future<Either> saveCurrentPairsEntities(ChatPairsModel pairsEntities);
}

class ChatOpenRouterServiceImpl implements ChatOpenRouterService {
  final String apiKey;
  final String apiUrl;

  ChatOpenRouterServiceImpl({
    required this.apiKey,
    this.apiUrl = 'https://openrouter.ai/api/v1/chat/completions',
  });

  @override
  Future<Either> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'HTTP-Referer': 'myflutterapp://mychatbot', // ← 避免403
      },
      body: jsonEncode({
        'model': 'deepseek/deepseek-r1-0528-qwen3-8b:free',
        'messages': [
          {"role": "user", "content": message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decoded);
      final content = data['choices'][0]['message']['content'];
      return Right(content);
    } else {
      return Left('Error: ${response.statusCode}, ${response.body}');
    }
  }

  @override
  Future<Either> saveCurrentPairsEntities(ChatPairsModel pairsEntities) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .collection('Messages')
          .add(pairsEntities.toMap());
      return Right("Add to cart successfully");
    } catch (e) {
      return Left("Please try again later");
    }
  }
}
