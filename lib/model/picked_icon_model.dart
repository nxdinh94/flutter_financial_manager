class PickedIconModel{
  final String icon;
  final String name;
  final String id;
  PickedIconModel({required this.icon, required this.name, required this.id});

  bool isNull(){
    return icon.isEmpty && name.isEmpty && id.isEmpty;
  }

}