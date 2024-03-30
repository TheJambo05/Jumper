// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jumper/presentation/widgets/admin/user_list_view.dart';
// import '../../../../logic/cubits/admin_cubits/user_cubit/user_list_cubit.dart';
// import '../../../../logic/cubits/admin_cubits/user_cubit/user_list_state.dart';

// class Users extends StatefulWidget {
//   const Users({super.key});

//   static const routeName = "users";

//   @override
//   State<Users> createState() => _UsersState();
// }

// class _UsersState extends State<Users> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           BlocBuilder<UserListCubit, UserListState>(
//             builder: (context, state) {
//               if (state is UserListLoadingState && state.users.isEmpty) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }

//               if (state is UserListErrorState && state.users.isEmpty) {
//                 return Center(
//                   child: Text(state.message),
//                 );
//               }

//               return UserListView(users: state.users);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
