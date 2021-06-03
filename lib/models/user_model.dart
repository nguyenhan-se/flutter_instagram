import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String profileImageUrl;
  final int following;
  final int followers;
  final String bio;
  final String name;

  const User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.profileImageUrl,
    @required this.following,
    @required this.followers,
    @required this.bio,
    @required this.name,
  });

  static const empty = User(
    id: '',
    username: '',
    email: '',
    profileImageUrl: '',
    followers: 0,
    following: 0,
    bio: '',
    name: '',
  );

  @override
  List<Object> get props =>
      [id, username, email, profileImageUrl, followers, following, bio, name];

  User copyWith({
    String id,
    String username,
    String email,
    String profileImageUrl,
    int following,
    int followers,
    String bio,
    String name,
  }) {
    return User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        following: following ?? this.following,
        followers: followers ?? this.followers,
        bio: bio ?? this.bio,
        name: name ?? this.name);
  }

  Map<String, dynamic> toDocument() {
    return {
      'username': username,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'following': following,
      'followers': followers,
      'bio': bio,
      'name': name
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    if (doc == null) return null;
    final data = doc.data() as Map;

    return User(
      id: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      following: (data['following'] ?? 0).toInt(),
      followers: (data['followers'] ?? 0).toInt(),
      bio: data['bio'] ?? '',
      name: data['name'] ?? '',
    );
  }
}
