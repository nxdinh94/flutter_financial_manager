class IconModel {
  final String id;
  final String name;
  final String icon;
  IconModel({required this.id, required  this.name, required  this.icon});

  factory IconModel.fromJson(Map<String, dynamic> json){
    return IconModel(
        id : json['id'] ?? '',
        name : json['name'] ?? '',
        icon : json['money_account_type']['icon']  ?? '',
    );
  }
  Map<String, dynamic> toJson() =>{
    'id' : id,
    'name' : name,
    'icon' : icon
  };

}