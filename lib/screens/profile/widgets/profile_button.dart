import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;
  const ProfileButton({
    Key key,
    @required this.isCurrentUser,
    @required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? _ButtonProfile(
            label: 'Edit Profile',
            onPressed: () => Navigator.of(context).pushNamed(
                EditProfileScreen.routeName,
                arguments: EditProfileScreenArgs(context: context)),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _ButtonProfile(
                  label: isFollowing ? 'Following' : 'follow',
                  isOutlineBtn: isFollowing,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: _ButtonProfile(
                  label: 'Message',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 6.0),
              OutlinedButton(
                child: Icon(
                  MdiIcons.chevronDown,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          );
  }
}

class _ButtonProfile extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool isOutlineBtn;

  const _ButtonProfile({
    Key key,
    @required this.label,
    @required this.onPressed,
    this.isOutlineBtn = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isOutlineBtn
        ? OutlinedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
