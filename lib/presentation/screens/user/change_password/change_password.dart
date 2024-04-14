import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/core/design.dart';
import 'package:jumper/data/models/user/user_model.dart';
import 'package:jumper/logic/cubits/user_cubit/user_cubit.dart';
import 'package:jumper/logic/cubits/user_cubit/user_state.dart';
import 'package:jumper/presentation/screens/user/change_password/password_provider.dart';
import 'package:jumper/presentation/widgets/user/gap_widget.dart';
import 'package:jumper/presentation/widgets/user/primary_button.dart';
import 'package:jumper/presentation/widgets/user/primary_textfield.dart';
import 'package:provider/provider.dart';

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
        title: const Text("Edit Profile"),
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
          return changePassword(state.userModel);
        }

        return const Center(
          child: Text("An error occured!"),
        );
      })),
    );
  }

  Widget changePassword(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text("Personal Details",
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          initialValue: userModel.fullName,
          onChanged: (value) {
            userModel.fullName = value;
          },
          labelText: "Full Name",
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.phoneNumber,
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
          labelText: "Phone Number",
        ),
        const GapWidget(size: 20),
        Text("Address",
            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          initialValue: userModel.address,
          onChanged: (value) {
            userModel.address = value;
          },
          labelText: "Address",
        ),
        const GapWidget(),
        PrimaryTextField(
          initialValue: userModel.city,
          onChanged: (value) {
            userModel.city = value;
          },
          labelText: "City",
        ),
        // LinkButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, ChangePasswordScreen.routeName);
        //     },
        //     text: "Change Password"),
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
// import 'package:jumper/presentation/screens/user/change_password/password_provider.dart';
// import 'package:jumper/presentation/widgets/user/gap_widget.dart';
// import 'package:jumper/presentation/widgets/user/primary_button.dart';
// import 'package:jumper/presentation/widgets/user/primary_textfield.dart';
// import 'package:provider/provider.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   static const routeName = "change_password";

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<PasswordProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Change Password"),
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               PrimaryTextField(
//                 controller: provider.newPasswordController,
//                 labelText: "New Password",
//                 obscureText: true,
//               ),
//               const GapWidget(),
//               PrimaryTextField(
//                 controller: provider.newPasswordController,
//                 labelText: "Confirm Password",
//                 obscureText: true,
//               ),
//               const GapWidget(),
//               PrimaryTextField(
//                 controller: provider.oldPasswordController,
//                 labelText: "Old Password",
//                 obscureText: true,
//               ),
//               const GapWidget(),
//               PrimaryButton(
//                 text: "Save",
//                 onPressed: () {},
//               )
//             ],
//           )),
//     );
//   }
// }
