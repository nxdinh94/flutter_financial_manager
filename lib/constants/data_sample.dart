List<Map<String, dynamic>> budgetList = [
  {
    "_id": "2222222",
    "name": "Ăn uống",
    "start_time": "2025-03-20",
    "end_time": "2025-04-20",
    "amount_of_money": {r"$numberDecimal": "200000"},
    "total_spending": {r"$numberDecimal": "22222222"},
    "actual_spending": {r"$numberDecimal": "150000"},
    "should_spending": {r"$numberDecimal": "100000"},
    "expected_spending": {r"$numberDecimal": "190000"},
    "expense_records": [
      {
        "occur_date": "2025-03-21",
        "amount_of_money": {r"$numberDecimal": "50000"},
        "id": "b924107b-8488-4d81-b8f0-73f98f530a44",
        "transaction_type_id": "a4c18d24-e41f-4a69-8547-1548ce81db43",
        "icon": "assets/icon_category/spending_money_icon/nhaCua/renovation.png",
        "name": "Sửa & trang trí nhà",
        "parent_id": "01905523-aaac-42a6-893e-1096199941a9",
        "children": []
      },
      {
        "occur_date": "2025-03-22",
        "amount_of_money": {r"$numberDecimal": "30000"},
        "id": "ddfd479b-bf0f-4e2f-ba75-3ef7362c8845",
        "transaction_type_id": "a4c18d24-e41f-4a69-8547-1548ce81db43",
        "icon": "assets/icon_category/spending_money_icon/nhaCua/house-parent.png",
        "name": "Dịch vụ gia đình",
        "parent_id": "01905523-aaac-42a6-893e-1096199941a9",
      }
    ]
  },
  {
    "_id": "3333333",
    "name": "Di chuyển",
    "start_time": "2025-03-15",
    "end_time": "2025-04-15",
    "amount_of_money": {r"$numberDecimal": "500000"},
    "total_spending": {r"$numberDecimal": "1500000"},
    "actual_spending": {r"$numberDecimal": "300000"},
    "should_spending": {r"$numberDecimal": "200000"},
    "expected_spending": {r"$numberDecimal": "450000"},
    "expense_records": [
      {
        "occur_date": "2025-03-16",
        "amount_of_money": {r"$numberDecimal": "120000"},
        "id": "b924107b-8488-4d81-b8f0-73f98f530a44",
        "transaction_type_id": "a4c18d24-e41f-4a69-8547-1548ce81db43",
        "icon": "assets/icon_category/spending_money_icon/nhaCua/renovation.png",
        "name": "Sửa & trang trí nhà",
        "parent_id": "01905523-aaac-42a6-893e-1096199941a9",
        "children": []
      },
      {
        "occur_date": "2025-03-17",
        "amount_of_money": {r"$numberDecimal": "180000"},
        "id": "80df3f9b-01aa-4368-941a-2612c136fa70",
        "transaction_type_id": "a4c18d24-e41f-4a69-8547-1548ce81db43",
        "icon": "assets/icon_category/spending_money_icon/conCai/children_parent.png",
        "name": "Vật nuôi",
        "parent_id": "01905523-aaac-42a6-893e-1096199941a9",
        "children": []
      }
    ]
  },
  {
    "_id": "4444444",
    "name": "Giải trí",
    "start_time": "2025-03-10",
    "end_time": "2025-04-10",
    "amount_of_money": {r"$numberDecimal": "300000"},
    "total_spending": {r"$numberDecimal": "900000"},
    "actual_spending": {r"$numberDecimal": "250000"},
    "should_spending": {r"$numberDecimal": "150000"},
    "expected_spending": {r"$numberDecimal": "280000"},
    "expense_records": [
      {
        "occur_date": "2025-03-11",
        "amount_of_money": {r"$numberDecimal": "100000"},
        "id": "d8707d10-35f7-4c1b-bf46-4a5aad204eda",
        "transaction_type_id": "a4c18d24-e41f-4a69-8547-1548ce81db43",
        "icon": "assets/icon_category/spending_money_icon/dichVuSinhHoat/internet.png",
        "name": "Dịch vụ trưc tuyến",
        "parent_id": "e8d28d7c-1958-46dc-b796-881cedd98135",
        "children": []
      },
      {
        "occur_date": "2025-03-12",
        "amount_of_money": {r"$numberDecimal": "150000"},
        "id": "06a3231b-d6c1-4f58-b166-fc5a3204db2d",
        "transaction_type_id": "a4c18d24-e41f-4a69-8547-1548ce81db43",
        "icon": "assets/icon_category/spending_money_icon/conCai/toys.png",
        "name": "Vui-chơi",
        "parent_id": "e8d28d7c-1958-46dc-b796-881cedd98135",
        "children": []
      }
    ]
  }
];
Map<String, dynamic> dataForTransactionHistory = {
  'response_revenue_money': {r'$numberDecimal': '1500000'},
  'response_spending_money': {r'$numberDecimal': '1200000'},
  'response_expense_record': [
    {
      'date': '2025-03-25',
      'records': [
        {
          'name': 'Ăn sáng',
          'icon': 'assets/icon_category/spending_money_icon/anUong/breakfast.png',
          'cash_flow_type': 0, // Chi tiêu
          'amount_of_money': {r'$numberDecimal': '50000'},
        },
        {
          'name': 'Lương tháng 3',
          'icon': 'assets/icon_category/revenue_money_icon/salary.png',
          'cash_flow_type': 1, // Thu nhập
          'amount_of_money': {r'$numberDecimal': '1000000'},
        },
      ],
    },
    {
      'date': '2025-03-24',
      'records': [
        {
          'name': 'Mua sắm',
          'icon': 'assets/icon_category/spending_money_icon/dichVuSinhHoat/clothes-rack-parent.png',
          'cash_flow_type': 0,
          'amount_of_money': {r'$numberDecimal': '700000'},
        },
        {
          'name': 'Thưởng KPI',
          'icon': 'assets/icon_category/revenue_money_icon/award.png',
          'cash_flow_type': 1,
          'amount_of_money': {r'$numberDecimal': '500000'},
        },
      ],
    },
  ],
};
