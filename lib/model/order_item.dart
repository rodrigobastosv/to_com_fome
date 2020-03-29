class OrderItem {
  OrderItem(
      {this.id,
      this.name,
      this.type,
      this.categoryId,
      this.obs,
      this.restauranteId,
      this.qtd,
      this.value});

  final int id;
  final String name;
  final String obs;
  final String restauranteId;
  final String categoryId;
  final String type;
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
