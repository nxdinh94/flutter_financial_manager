// import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
// import 'package:flutter/material.dart';
// class CreateEvents extends StatefulWidget {
//   const CreateEvents({super.key});
//
//   @override
//   State<CreateEvents> createState() => _CreateEventsState();
// }
//
// class _CreateEventsState extends State<CreateEvents> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: CustomBackNavbar(),
//         title: Text('New Events'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
import 'package:flutter/material.dart';

class CreateEvents extends StatefulWidget {
  const CreateEvents({super.key});

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackNavbar(),
        title: const Text('New Events'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Xử lý sự kiện lưu
            },
            child: const Text(
              'Lưu',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: CircleAvatar(), // Có thể thay thế bằng hình ảnh
            title: Text('Tên'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Ngày'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Việt Nam Đồng'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Tiền mặt'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}