import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/screens/profile/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_instagram/blocs/auth/auth_bloc.dart';
import 'package:flutter_instagram/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter_instagram/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) => {
        if (state.status == ProfileStatus.error)
          {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                content: state.failure.message,
              ),
            )
          }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            title: GestureDetector(
              onTap: () => print('Tap username = ${state.user.username}'),
              child: Row(
                children: [
                  const Icon(MdiIcons.lockOutline),
                  const SizedBox(width: 4.0),
                  Text(
                    state.user.username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(MdiIcons.chevronDown),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  MdiIcons.plusBoxOutline,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  MdiIcons.accountPlusOutline,
                ),
                onPressed: () {},
              ),
              if (state.isCurrentUser)
                IconButton(
                  icon: Icon(
                    MdiIcons.logout,
                  ),
                  onPressed: () =>
                      context.read<AuthBloc>().add(AuthLogoutRequested()),
                ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          UserProfileImage(
                            radius: 40.0,
                            profileImageUrl: state.user.profileImageUrl,
                            isAddIcon: true,
                          ),
                          ProfileStats(
                            posts: 13,
                            followers: state.user.followers,
                            following: state.user.following,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14.0),
                      ProfileInfo(
                          username: state.user.name, bio: state.user.bio),
                      ProfileButton(
                        isCurrentUser: state.isCurrentUser,
                        isFollowing: state.isFollowing,
                      ),
                    ],
                  ),
                ),
              )),
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 0.0,
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: Icon(
                        MdiIcons.grid,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        MdiIcons.formatListBulleted,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => ListTile(
                    title: Text('List tile #$i'),
                  ),
                  childCount: 1000,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
