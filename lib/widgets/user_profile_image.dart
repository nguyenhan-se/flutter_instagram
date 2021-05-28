import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserProfileImage extends StatelessWidget {
  final double radius;
  final String profileImageUrl;
  final File profileImage;
  final isAddIcon;
  final Function onPressed;

  const UserProfileImage(
      {Key key,
      @required this.radius,
      @required this.profileImageUrl,
      this.isAddIcon = false,
      this.profileImage,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey[200],
          backgroundImage: profileImage != null
              ? FileImage(profileImage)
              : profileImageUrl.isNotEmpty
                  ? CachedNetworkImageProvider(profileImageUrl)
                  : null,
          child: _NoProfileImage(
            profileImage: profileImage,
            profileImageUrl: profileImageUrl,
            size: radius,
          ),
        ),
        if (isAddIcon)
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              height: radius / 1.5,
              width: radius / 1.5,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(width: 3.0, color: Colors.white),
              ),
              child: Icon(MdiIcons.plus, color: Colors.white, size: radius / 2),
            ),
          )
      ],
    );
  }
}

class _NoProfileImage extends StatelessWidget {
  const _NoProfileImage({
    Key key,
    @required this.profileImage,
    @required this.profileImageUrl,
    @required this.size,
  }) : super(key: key);

  final File profileImage;
  final String profileImageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (profileImage == null && profileImageUrl.isEmpty) {
      return Icon(
        Icons.account_circle,
        color: Colors.grey[400],
        size: size,
      );
    }
    return SizedBox.shrink();
  }
}
