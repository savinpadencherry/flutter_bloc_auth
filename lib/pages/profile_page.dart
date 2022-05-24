import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/cubits/profile/profile_cubit.dart';
import 'package:flutter_bloc_auth/utils/errorDialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  void _getProfile() async {
    final String uid = context.read<AuthBloc>().state.user!.uid;
    print('uid: $uid');
    context.read<ProfileCubit>().getProfile(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Profile'),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.error) {
            errorDialog(context, state.customError);
          }
        },
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.intial) {
            return Container();
          } else if (state.profileStatus == ProfileStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.profileStatus == ProfileStatus.error) {
            return const Center(
              child: Text('Some gawdDamn Error my boi'),
            );
          }
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.person,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('_id: ${state.user.id}'),
                      Text('name: ${state.user.name}'),
                      Text('email: ${state.user.email}'),
                      Text('point: ${state.user.point}'),
                      Text('rank: ${state.user.rank}'),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
