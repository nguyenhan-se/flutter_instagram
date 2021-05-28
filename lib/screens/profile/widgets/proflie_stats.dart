import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  final int posts;
  final int followers;
  final int following;

  const ProfileStats({
    Key key,
    @required this.posts,
    @required this.followers,
    @required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Stats(
            count: 13,
            label: 'Posts',
          ),
          _Stats(
            count: followers,
            label: 'Followers',
          ),
          _Stats(
            count: following,
            label: 'Following',
          ),
        ],
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  final int count;
  final String label;

  const _Stats({Key key, @required this.count, @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.black54),
        )
      ],
    );
  }
}
