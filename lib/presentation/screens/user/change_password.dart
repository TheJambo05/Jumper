import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/presentation/screens/user/change_password.dart';
import 'package:jumper/presentation/widgets/user/link_button.dart';
import '../../../core/design.dart';
import '../../../data/models/user/user_model.dart';
import '../../../logic/cubits/user_cubit/user_cubit.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../../widgets/user/gap_widget.dart';
import '../../widgets/user/primary_button.dart';
import '../../widgets/user/primary_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const routeName = "change_password";

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: SafeArea(
          child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is UserLoggedInState) {
          return editProfile(state.userModel);
        }

        return const Center(
          child: Text("An error occured!"),
        );
      })),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text("Personal Details",
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const GapWidget(
          size: -10,
        ),
        const PrimaryTextField(
          labelText: "New Password",
        ),
        const GapWidget(),
        const PrimaryTextField(
          labelText: "Confirm Password",
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.fullName,
          onChanged: (value) {
            userModel.fullName = value;
          },
          labelText: "Full Name",
        ),
        const GapWidget(),
        const GapWidget(),
        PrimaryButton(
            onPressed: () async {
              bool success = await BlocProvider.of<UserCubit>(context)
                  .updateUser(userModel);
              if (success) {
                Navigator.pop(context);
              }
            },
            text: "Save"),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:jumper/presentation/widgets/user/gap_widget.dart';
// import 'package:jumper/presentation/widgets/user/primary_textfield.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   static const routeName = "change_password";

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Change Password"),
//       ),
//       body: const Column(
//         children: [
//           PrimaryTextField(
//             labelText: "New Password",
//           ),
//           GapWidget(),
//           PrimaryTextField(
//             labelText: "Confirm Password",
//           ),

//         ],
//       ),
//     );
//   }
// }
