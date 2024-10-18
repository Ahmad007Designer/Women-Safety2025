class Fruit {
  final String name;

  Fruit(this.name);

  // Sweet method with optional named parameters, marked as nullable
  bool sweet(String name, {int? index, double? rating}) {
    return true; // You need to return a boolean value since the method expects a return type of 'bool'
  }

  // Dynamic method for origin with no return type specified, assuming it's void
  void origin() {
  }

  // Overriding the equality operator to compare fruits based on their name
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is Fruit && o.name == name;
  }

  // Always override hashCode when overriding equality operator
  @override
  int get hashCode => name.hashCode;

  // Override toString method to print out the fruit's name
  @override
  String toString() {
    return 'Fruit {name: $name}';
  }
}
