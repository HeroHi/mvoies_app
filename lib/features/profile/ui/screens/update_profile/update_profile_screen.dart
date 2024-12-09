import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';
import 'package:random_avatar/random_avatar.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "updateProfile";
  final GlobalKey<FormState> _userNameKey = GlobalKey();
  final TextEditingController _userNameController = TextEditingController();
  final GlobalKey<FormState> _phoneKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  String selectedAvatar = "john_doe";
  UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late ThemeData theme;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    widget._userNameController.text = "charName";
    widget._phoneController.text = "01063777113";
    theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              height: 150,
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
                  child: RandomAvatar(widget.selectedAvatar)),
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextField(
                preIcon: Icons.person,
                validator: (string) {
                  return null;
                },
                hintText: "",
                isPassword: false,
                fieldKey: widget._userNameKey,
                controller: widget._userNameController),
            MyTextField(
                preIcon: Icons.phone,
                validator: (string) {
                  return null;
                },
                hintText: "",
                isPassword: false,
                fieldKey: widget._phoneKey,
                controller: widget._phoneController),
            SizedBox(
              height: MediaQuery.of(context).size.height * .24,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.redButton)),
                onPressed: () {},
                child: Text(
                  "Delete Account",
                  style: theme.textTheme.displayMedium!
                      .copyWith(color: AppColors.iconWhite),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Update data",
                    style: theme.textTheme.displayMedium!
                        .copyWith(color: AppColors.iconWhite),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Pick Avatar",
      ),
    );
  }

  Widget showBottomSheet(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.bottomNav, borderRadius: BorderRadius.circular(24)),
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
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
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: avatarNames.length,
        itemBuilder: (context, index) {
          final String avatarName = avatarNames[index];
          return InkWell(
            onTap: () {
              setState(() {
                widget.selectedAvatar = avatarName;
              });
              Navigator.pop(context);
            },
            child: _buildAvatarContainer(
              RandomAvatar(avatarName),
              isSelected: avatarName == widget.selectedAvatar,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatarContainer(Widget avatar, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.avatarBg : AppColors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textYellow,
          width: isSelected ? 3 : 1,
        ),
      ),
      child: avatar,
    );
  }
}
