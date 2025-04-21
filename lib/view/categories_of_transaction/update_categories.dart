
import 'package:flutter/material.dart';

class UpdateCategoryScreen extends StatefulWidget {
  @override
  _UpdateCategoryScreenState createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  bool _isExpense = true;
  String? _selectedParentCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Edit category'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: (  ) {
              // Xử lý sự kiện xóa danh mục
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Icon(Icons.attach_money),
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Bills & Utilities',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Switch(
                    value: true,
                    onChanged: (value) {
                      // Xử lý sự kiện bật/tắt switch
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                _buildTransactionTypeButton('Expense', true),
                SizedBox(width: 8.0),
                _buildTransactionTypeButton('Income', false),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Parent category',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                _showParentCategoryBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.folder_open_outlined, color: Colors.grey[600]),
                    SizedBox(width: 12.0),
                    Text(
                      _selectedParentCategory ?? 'Select category',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey[600]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện Merge Category
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('MERGE CATEGORY'),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'These categories are active in following wallets',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.0),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(Icons.wallet, color: Colors.white),
              ),
              title: Text('Tiền mặt'),
              trailing: TextButton(
                onPressed: () {
                  // Xử lý sự kiện Edit ví
                },
                child: Text('Edit', style: TextStyle(color: Colors.green)),
              ),
            ),
            // Thêm các ListTile khác cho các ví khác nếu cần
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Xử lý sự kiện Save
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text('Save', style: TextStyle(fontSize: 18.0)),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeButton(String label, bool isExpense) {
    bool isSelected = (isExpense && _isExpense) || (!isExpense && !_isExpense);
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            _isExpense = isExpense;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green.withOpacity(0.1) : null,
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.grey[400]!,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isExpense ? Icons.trending_down : Icons.trending_up,
              color: isSelected ? Colors.green : Colors.grey[600],
            ),
            SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showParentCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Danh mục cha 1'),
                onTap: () {
                  setState(() {
                    _selectedParentCategory = 'Danh mục cha 1';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Danh mục cha 2'),
                onTap: () {
                  setState(() {
                    _selectedParentCategory = 'Danh mục cha 2';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Không có danh mục cha'),
                onTap: () {
                  setState(() {
                    _selectedParentCategory = null;
                  });
                  Navigator.pop(context);
                },
              ),
              // Thêm các danh mục cha khác vào đây (có thể lấy từ API hoặc state)
            ],
          ),
        );
      },
    );
  }
}