import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.title, required this.leadingIcon, required this.isSubTitle, this.subTitle, required this.callback});
  final String title;
  final IconData leadingIcon;
  final bool isSubTitle;
  final String ? subTitle ;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium,),
      subtitle: isSubTitle ? Text(subTitle ?? "", style: Theme.of(context).textTheme.labelSmall,) : null,
      leading: Icon(Icons.person, color: IconTheme.of(context).color,),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: IconTheme.of(context).color,
        size: 15,
      ),
      onTap: callback,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      dense: true,
    );
  }
}
