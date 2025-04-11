// import 'package:fe_financial_manager/view/common_widget/custom_back_navbar.dart';
// import 'package:flutter/material.dart';
// class CreateCategory extends StatefulWidget {
//   const CreateCategory({super.key});
//
//   @override
//   State<CreateCategory> createState() => _CreateCategoryState();
// }
//
// class _CreateCategoryState extends State<CreateCategory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('New Category2'),
//         leading: CustomBackNavbar(),
//       ),
//       body: Container(
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CreateCategory extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController _categoryNameController = TextEditingController();
  String? _selectedParentCategory;
  bool _isIncome = true;

  bool get _isSaveButtonEnabled =>
      _categoryNameController.text.isNotEmpty && _isIncome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 4.0),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'New category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 60.0),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey[300],
                        size: 24,
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                      hintText: 'Category Name',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.arrow_drop_down),
                  onSelected: (String value) {
                    // Handle dropdown selection if needed
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(Icons.remove, color: Colors.grey[600]),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isIncome = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isIncome ? Colors.grey[300] : Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Income',
                    style: TextStyle(),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isIncome = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_isIncome ? Colors.grey[300] : Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Expense',
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Parent category',
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                // Navigate to select parent category screen
                // You would implement a screen or dialog to select a parent category
                print('Navigate to select parent category');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _selectedParentCategory ?? 'Select category',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: _selectedParentCategory == null
                              ? Colors.grey[600]
                              : Colors.black87),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        size: 16.0, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaveButtonEnabled
                    ? () {
                  // Handle save category action
                  String categoryName = _categoryNameController.text;
                  String type = _isIncome ? 'Income' : 'Expense';
                  String parent = _selectedParentCategory ?? 'None';
                  print(
                      'Category Name: $categoryName, Type: $type, Parent: $parent');
                  // You would typically save this data to your application's state or database
                }
                    : null, // Disable the button if conditions are not met
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSaveButtonEnabled
                      ? Colors.green // Màu xanh khi đủ điều kiện
                      : Colors.grey[300], // Màu xám khi không đủ điều kiện
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text('Save', style: TextStyle(fontSize: 16.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





