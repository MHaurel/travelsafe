import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';
import 'package:flutter_frontend/widgets/dialogs/connexion_dialog.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const NavBar({super.key, required this.appBar});

  void _goToHome(BuildContext context) {
    Navigator.of(context).pushNamed("/");
  }

  void _goToLastInfo(BuildContext context) {
    Navigator.of(context).pushNamed("/news");
  }

  void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 64.0),
        child: InkWell(
          onTap: () => Navigator.of(context).pushReplacementNamed("/"),
          child: Image.asset("assets/images/navbar_logo_2x.png"),
        ),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Accueil",
                textColor: const Color(0xFF07020D),
                onPressed: () => _goToHome(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Dernières Informations",
                textColor: const Color(0xFF07020D),
                onPressed: () => _goToLastInfo(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Contact",
                textColor: const Color(0xFF07020D),
                onPressed: _onPressed),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(
                text: "Aide",
                textColor: const Color(0xFF07020D),
                onPressed: _onPressed),
          ),
        ],
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 64.0),
            child: InkWell(
                onTap: () => {
                      Provider.of<UserProvider>(context, listen: false)
                              .isSignedIn()
                          ? Navigator.of(context).pushNamed("/profile")
                          : showDialog(
                              context: context,
                              builder: (context) => const ConnexionDialog())
                    },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(3.5),
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFF326B69),
                              foregroundColor: const Color(0xFFFFFFFF),
                              child: context.watch<UserProvider>().isSignedIn()
                                  ? Image.asset("assets/images/avatar.png")
                                  : const Icon(
                                      Icons.person_rounded,
                                      color: Color(0xFFFFFFFF),
                                    ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(context.watch<UserProvider>().isSignedIn()
                        ? context.read<UserProvider>().user.fullName
                        : "Se connecter")
                  ],
                )))
      ],
      backgroundColor: const Color(0xFFA8D6AC),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
