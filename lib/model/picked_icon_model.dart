class PickedIconModel{
  final String iconPath;
  final String name;
  final String id;
  PickedIconModel({required this.iconPath, required this.name, required this.id});

  bool isNull(){
    return iconPath.isEmpty && name.isEmpty && id.isEmpty;
  }

}