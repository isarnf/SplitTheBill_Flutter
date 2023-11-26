class Guest {
  int id;
  String name;
  String amountSpent;
  String items;
  DateTime modifiedTime;

  Guest({
    required this.id,
    required this.name,
    required this.amountSpent,
    required this.items,
    required this.modifiedTime,
  });


}


List<Guest> sampleGuests = [
  Guest(
    id: 0,
    name: 'Isabela',
    amountSpent: '100.00',
    items:
        'Carne, linguica',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 1,
    name: 'Iara',
    amountSpent: '50.00',
    items:
        'Queijo coalho',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 2,
    name: 'Paulo',
    amountSpent: '10.00',
    items:
        'Pão',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 3,
    name: 'Leonardo',
    amountSpent: '30.00',
    items:
        'Gelo',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 4,
    name: 'Lilian',
    amountSpent: '50.00',
    items:
        'Cerveja',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 5,
    name: 'Bianca',
    amountSpent: '70.00',
    items:
        'Sobremesa',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 6,
    name: 'Larissa',
    amountSpent: '25.00',
    items:
        'Suco de uva',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 7,
    name: 'Gustavo',
    amountSpent: '20.00',
    items:
        'Farofa',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Guest(
    id: 7,
    name: 'Henrique',
    amountSpent: '30.00',
    items:
        'Refrigerante',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
];