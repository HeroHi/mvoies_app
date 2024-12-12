import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/login_screen.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';
import 'package:movies_app/features/profile/ui/screens/reset_password/reset_password.dart';
import 'package:movies_app/features/profile/ui/screens/update_profile/cubit/update_profile_cubit.dart';
import 'package:random_avatar/random_avatar.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "updateProfile";

  UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selectedAvatar = "john_doe";
  final UpdateProfileCubit _updateProfileCubit = getIt();
  final GlobalKey<FormState> _userNameKey = GlobalKey();
  final GlobalKey<FormState> _phoneKey = GlobalKey();
   TextEditingController _userNameController = TextEditingController();
   TextEditingController _phoneController = TextEditingController();

  late ThemeData theme;
  bool isSelected = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      var userData = await _updateProfileCubit.currentUserData;
       _phoneController = TextEditingController(text: userData.phone);
       _userNameController = TextEditingController(text: userData.name);
       selectedAvatar = userData.avatarCode;
       setState(() {

       });
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             SizedBox(
              height: 40.h,
            ),
            SizedBox(
              width: 150.w,
              height: 150.h,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: AppColors.backgroundDark,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return showBottomSheet(context);
                        });
                  },
                  child: RandomAvatar(selectedAvatar)),
            ),
             SizedBox(
              height: 30.h,
            ),
            MyTextField(
                preIcon: Icons.person,
                validator: (string) {
                  return null;
                },
                hintText: "",
                isPassword: false,
                fieldKey: _userNameKey,
                controller: _userNameController),
            MyTextField(
                preIcon: Icons.phone,
                validator: (string) {
                  return null;
                },
                hintText: "",
                isPassword: false,
                fieldKey: _phoneKey,
                controller: _phoneController),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, ResetPassword.routeName);
              },
              child: Text(tr('updateProfile.resetPassword'),style: theme.textTheme.displayMedium,),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .24,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.redButton)),
                onPressed: () {
                  _updateProfileCubit.deleteAcc();
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                child: Text(
                  tr('updateProfile.deleteAccount'),
                  style: theme.textTheme.displayMedium!
                      .copyWith(color: AppColors.iconWhite),
                )),
            Padding(
              padding:  EdgeInsets.only(top: 18.h, bottom: 18.h),
              child: ElevatedButton(
                onPressed: () {
                  _updateProfileCubit.updateAcc(
                      name: _userNameController.text,
                      phoneNumber: _phoneController.text,
                      avatarCode: selectedAvatar);
                },
                child: Text(
                  tr('updateProfile.updateData'),
                  style: theme.textTheme.displayMedium!
                      .copyWith(color: AppColors.iconWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title:  Text(
        tr('updateProfile.pickAvatar'),
      ),
    );
  }

  Widget showBottomSheet(BuildContext context) {
    return Container(
      margin:  EdgeInsets.all(16.r),
      decoration: BoxDecoration(
          color: AppColors.bottomNav, borderRadius: BorderRadius.circular(24.r)),
      height: 400.h,
      child: Padding(
        padding: EdgeInsets.all(18.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Expanded(child: _buildAvatarsGrid())],
        ),
      ),
    );
  }

  Widget _buildAvatarsGrid() {
    final avatarNames = [
      "saytoonz",
      "john_doe",
      "user-123",
      "flutter_dev",
      "tech_guy",
      "superstar123",
      "user42",
      "cool_user",
      "happy_person"
    ];
    return Padding(
      padding:  EdgeInsets.only(left: 10.w, right: 10.w),
      child: GridView.builder(
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .8,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w),
        itemCount: avatarNames.length,
        itemBuilder: (context, index) {
          final String avatarName = avatarNames[index];
          return InkWell(
            onTap: () {
              setState(() {
                selectedAvatar = avatarName;
              });
              Navigator.pop(context);
            },
            child: _buildAvatarContainer(
              RandomAvatar(avatarName),
              isSelected: avatarName == selectedAvatar,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatarContainer(Widget avatar, {required bool isSelected}) {
    return Container(
      padding:  EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.avatarBg : AppColors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.textYellow,
          width: isSelected ? 3 : 1,
        ),
      ),
      child: avatar,
    );
  }
}
