import 'dart:math';

import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/colors.dart';
import 'package:split_the_bill/models/guest.dart';

class SplitBill extends StatefulWidget {
  const SplitBill({super.key});

  @override
  State<SplitBill> createState() => _SplitBillState();
}

class _SplitBillState extends State<SplitBill> {
  List<Guest> filteredGuests = [];
  bool sorted = false;
  late double total;
  late double amount_divided;
  late int numberGuests;

  @override
  void initState() {
    super.initState();
    filteredGuests = sampleGuests;
    total = filteredGuests.fold<double>(0, (sum, guest) => sum + double.parse(guest.amountSpent));
    numberGuests = filteredGuests.length;
    amount_divided = total / numberGuests;
    
  }

  List<Guest> sortGuestsByName(List<Guest> guests) {
    if (sorted) {
      guests.sort((a, b) => a.name.compareTo(b.name));
    } else {
      guests.sort((b, a) => a.name.compareTo(b.name));
    }

    sorted = !sorted;

    return guests;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredGuests = sampleGuests
          .where((guest) =>
              guest.items.toLowerCase().contains(searchText.toLowerCase()) ||
              guest.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Split the bill',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        filteredGuests =
                            sortGuestsByName(filteredGuests);
                      });
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: onSearchTextChanged,
              style: TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                hintText: "Search people...",
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                fillColor: Colors.grey.shade800,
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Text('Total spent',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        )),
                    Text('R\$ ${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text('${numberGuests.toString()} people | R\$ ${amount_divided.toStringAsFixed(2)} each',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 30),
                itemCount: filteredGuests.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 20),
                    color: getRandomColor(),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: '${filteredGuests[index].name}\n',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                  text:
                                      'Spent R\$ ${filteredGuests[index].amountSpent} \n',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.5),
                                ),
                              ]),
                        ),
                        trailing: Text(
                          (double.parse(filteredGuests[index].amountSpent) > amount_divided) ?
                          '+ R\$ ${(amount_divided - double.parse(filteredGuests[index].amountSpent)).abs().toStringAsFixed(2)}' : '- R\$ ${(amount_divided - double.parse(filteredGuests[index].amountSpent)).abs().toStringAsFixed(2)}',
                          style: TextStyle(
                              
                              color: (double.parse(filteredGuests[index].amountSpent) > amount_divided) ?Color.fromARGB(255, 4, 142, 9) : Colors.red,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
