import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/models/models.dart';

import 'package:flutter_instagram/repositories/repositories.dart';
import 'package:flutter_instagram/screens/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:flutter_instagram/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter_instagram/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import './widgets/widgets.dart';

class EditProfileScreenArgs {
  final BuildContext context;

  EditProfileScreenArgs({@required this.context});
}

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/editProfile';
  final User user;

  static Route route({@required EditProfileScreenArgs arg}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (_) => EditProfileCubit(
          storageRepository: context.read<StorageRepository>(),
          userRepository: context.read<UserRepository>(),
          profileBloc: arg.context.read<ProfileBloc>(),
        ),
        child: EditProfileScreen(
          user: arg.context.read<ProfileBloc>().state.user,
        ),
      ),
    );
  }

  EditProfileScreen({Key key, @required this.user}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => _submitForm(
                context,
                context.read<EditProfileCubit>().state.status ==
                    EditProfileStatus.submitting,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            )
          ],
          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state.status == EditProfileStatus.success) {
              Navigator.of(context).pop();
            } else if (state.status == EditProfileStatus.error) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorDialog(content: state.failure.message));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (state.status == EditProfileStatus.submitting)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 12.0,
                    ),
                    UserProfileImage(
                      radius: 60.0,
                      profileImageUrl: user.profileImageUrl,
                      profileImage: state.profileImage,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    GestureDetector(
                      child: Text(
                        'Change Profile Photo',
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => _selectProfileImage(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          EditProfileTextFormField(
                            label: 'name',
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .nameChanged(value),
                            validator: (value) => value.trim().isEmpty
                                ? 'Name can\'t be empty'
                                : null,
                            initialValue: state.name,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          EditProfileTextFormField(
                            label: 'Username',
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .usernameChanged(value),
                            validator: (value) => value.trim().isEmpty
                                ? 'Username can\'t be empty'
                                : null,
                            initialValue: state.username,
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          EditProfileTextFormField(
                            label: 'Bio',
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .bioChanged(value),
                            initialValue: state.bio,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _selectProfileImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      context
          .read<EditProfileCubit>()
          .profileImageChanged(File(pickedImage.path));
    }
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<EditProfileCubit>().submit();
    }
  }
}
