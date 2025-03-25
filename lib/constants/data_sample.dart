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
        "cash_flow_category_id": "food"
      },
      {
        "occur_date": "2025-03-22",
        "amount_of_money": {r"$numberDecimal": "30000"},
        "cash_flow_category_id": "food"
      },
      {
        "occur_date": "2025-03-23",
        "amount_of_money": {r"$numberDecimal": "70000"},
        "cash_flow_category_id": "beverages"
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
        "cash_flow_category_id": "transport"
      },
      {
        "occur_date": "2025-03-17",
        "amount_of_money": {r"$numberDecimal": "180000"},
        "cash_flow_category_id": "fuel"
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
        "cash_flow_category_id": "movies"
      },
      {
        "occur_date": "2025-03-12",
        "amount_of_money": {r"$numberDecimal": "150000"},
        "cash_flow_category_id": "games"
      }
    ]
  }
];
