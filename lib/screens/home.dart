import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/constants/colors.dart';
import 'package:split_the_bill/models/guest.dart';
import 'package:split_the_bill/screens/edit.dart';
import 'package:split_the_bill/screens/split.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Guest> filteredGuests = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
    filteredGuests = sampleGuests;
  }

  List<Guest> sortGuestsByModifiedTime(List<Guest> guests) {
    if (sorted) {
      guests.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      guests.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
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

  void deleteGuest(int index) {
    setState(() {
      Guest guest = filteredGuests[index];
      sampleGuests.remove(guest);
      filteredGuests.removeAt(index);
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
                  'Guests',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SplitBill()));
                    },
                    padding: EdgeInsets.all(0),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.attach_money_sharp,
                        color: Colors.white,
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        filteredGuests =
                            sortGuestsByModifiedTime(filteredGuests);
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
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditScreen(guest: filteredGuests[index]),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              int originalIndex =
                                  sampleGuests.indexOf(filteredGuests[index]);

                              sampleGuests[originalIndex] = Guest(
                                  id: sampleGuests[originalIndex].id,
                                  name: result[0],
                                  amountSpent: result[1],
                                  items: result[2],
                                  modifiedTime: DateTime.now());

                              filteredGuests[index] = Guest(
                                  id: filteredGuests[index].id,
                                  name: result[0],
                                  amountSpent: result[1],
                                  items: result[2],
                                  modifiedTime: DateTime.now());
                            });
                          }
                        },
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
                                      'R\$ ${filteredGuests[index].amountSpent} \n',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.5),
                                ),
                                TextSpan(
                                  text: '${filteredGuests[index].items} \n',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.5),
                                )
                              ]),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Edited: ${DateFormat('EEE MMM d, yyy h:mm a').format(filteredGuests[index].modifiedTime)}',
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade800),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await confirmDialog(context);
                            if (result != null && result) {
                              deleteGuest(index);
                            }
                          },
                          icon: Icon(
                            Icons.delete,
                          ),
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
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const EditScreen(),
              ),
            );

            if (result != null) {
              setState(() {
                sampleGuests.add(Guest(
                    id: sampleGuests.length,
                    name: result[0],
                    amountSpent: result[1],
                    items: result[2],
                    modifiedTime: DateTime.now()));
                filteredGuests = sampleGuests;
              });
            }
          },
          elevation: 10,
          backgroundColor: Colors.grey.shade800,
          child: const Icon(
            Icons.add,
            size: 38,
          )),
    );
  }
}

Future<dynamic> confirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          icon: const Icon(
            Icons.info,
            color: Colors.grey,
          ),
          title: const Text(
            'Are you sure you want to delete?',
            style: TextStyle(color: Colors.white),
          ),
          content:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'Yes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ]),
        );
      });
}
