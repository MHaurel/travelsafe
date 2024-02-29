import 'package:flutter/material.dart';
import 'package:flutter_frontend/widgets/base/custom_text_button.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  
  const NavBar({super.key, required this.appBar});

  void _goToProfile(){
    // TODO:
  }

  void _goToHome(BuildContext context){
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
        child: Image.asset("assets/images/navbar_logo_2x.png"),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(text: "Accueil", textColor: Color(0xFF07020D), onPressed: () => _goToHome(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(text: "Dernières Informations", textColor: Color(0xFF07020D), onPressed: () => _goToLastInfo(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(text: "Contact", textColor: Color(0xFF07020D), onPressed: _onPressed),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: (16.0)),
            child: CustomTextButton(text: "Aide", textColor: Color(0xFF07020D), onPressed: _onPressed),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 64.0),
          child: InkWell(onTap: _goToProfile, child: ClipRRect(borderRadius: BorderRadius.circular(90), child: Container(color: Colors.white, child: Padding(padding: const EdgeInsets.all(3.5), child: CircleAvatar(child: Icon(Icons.person_rounded, color: Color(0xFFFFFFFF),), backgroundColor: Color(0xFF326B69), foregroundColor: Color(0xFFFFFFFF),),)),))
        )
      ],
      backgroundColor: Color(0xFFA8D6AC),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}