import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String userId;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final String address;
  final List<Map<String, dynamic>> items;

  OrderModel({
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.address,
    required this.items,
  });

  // Converts Dart object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'address': address,
      'items': items,
    };
  }
}