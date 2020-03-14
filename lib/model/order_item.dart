class OrderItem {
  OrderItem({this.name, this.obs, this.qtd, this.value});

  final String name;
  final String obs;
  final int qtd;
  final double value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
