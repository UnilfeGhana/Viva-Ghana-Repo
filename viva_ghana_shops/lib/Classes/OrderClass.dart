class OrderClass {
  String recipientName;
  String recipientPhone;
  Map<String, dynamic> orders;
  String total;
  String order_db_location;
  String memberPhone;

  OrderClass(
    this.recipientName,
    this.recipientPhone,
    this.orders,
    this.total,
    this.order_db_location,
    this.memberPhone,
  );
}
