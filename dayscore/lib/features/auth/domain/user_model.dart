import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final int age;
  final String gender;
  final List<String> goals;
  final int stressLevel; // baseline 1-10
  final double sleepTarget; // in hours
  final int fitnessTarget; // daily steps
  final String workStudyType; // e.g. Student, Desk Job, Active
  final DateTime createdAt;

  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
    required this.goals,
    required this.stressLevel,
    required this.sleepTarget,
    required this.fitnessTarget,
    required this.workStudyType,
    required this.createdAt,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    int? age,
    String? gender,
    List<String>? goals,
    int? stressLevel,
    double? sleepTarget,
    int? fitnessTarget,
    String? workStudyType,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      goals: goals ?? this.goals,
      stressLevel: stressLevel ?? this.stressLevel,
      sleepTarget: sleepTarget ?? this.sleepTarget,
      fitnessTarget: fitnessTarget ?? this.fitnessTarget,
      workStudyType: workStudyType ?? this.workStudyType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'age': age,
      'gender': gender,
      'goals': goals,
      'stressLevel': stressLevel,
      'sleepTarget': sleepTarget,
      'fitnessTarget': fitnessTarget,
      'workStudyType': workStudyType,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String? ?? '',
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      age: map['age'] as int? ?? 0,
      gender: map['gender'] as String? ?? '',
      goals: List<String>.from(map['goals'] ?? []),
      stressLevel: map['stressLevel'] as int? ?? 5,
      sleepTarget: (map['sleepTarget'] as num?)?.toDouble() ?? 8.0,
      fitnessTarget: map['fitnessTarget'] as int? ?? 8000,
      workStudyType: map['workStudyType'] as String? ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
