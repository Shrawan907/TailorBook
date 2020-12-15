import 'dart:async';

import 'package:flutter/material.dart';
import 'package:TailorsBook/common/buttons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

DateTime selectedDate = DateTime.now();

class RegisterNewData extends StatefulWidget {
  @override
  _RegisterNewDataState createState() => _RegisterNewDataState();
}

class _RegisterNewDataState extends State<RegisterNewData> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String showDate;
  int regNo;
  int branch = 0;
  bool update = false;
  bool dateSelected = false;
  bool value1 = false,
      value2 = false,
      value3 = false,
      value4 = false,
      value5 = false,
      value6 = false,
      value7 = false,
      value8 = false,
      value9 = false,
      value10 = false;
  int val1 = 0,
      val2 = 0,
      val3 = 0,
      val4 = 0,
      val5 = 0,
      val6 = 0,
      val7 = 0,
      val8 = 0,
      val9 = 0,
      val10 = 0;

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // This will change to light theme.
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateSelected = true;
        showDate =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
  }

  submit() {
    print("REG NO. : $regNo");
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SnackBar snackBar = SnackBar(
        content: Text("Saved Details of ${regNo.toString()}"),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context, regNo.toString());
      });
    } else
      print("blaa blaa");
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Register"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 30.0, top: 10, bottom: 10),
            child: Container(
              width: 120,
              child: RaisedButton(
                child: Text(
                  update == true ? "Update" : "New",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
                onPressed: () {
                  setState(() {
                    if (update == true) {
                      update = false;
                    } else {
                      update = true;
                    }
                  });
                },
                // shape: CircleBorder(
                //   side: BorderSide(color: Colors.blue),
                // ),
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    height: 90,
                    //decoration: BoxDecoration(color: Colors.yellow),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Center(
                              child: RaisedButton(
                                  child: Container(
                                    margin: EdgeInsets.all(9.0),
                                    child: Text(
                                      branch == 0 ? "A" : "B",
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w500,
                                          color: branch == 0
                                              ? Colors.blue
                                              : Colors.blueGrey),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (branch == 0) {
                                        branch = 1;
                                      } else {
                                        branch = 0;
                                      }
                                    });
                                  },
                                  shape: CircleBorder(
                                    side: BorderSide(color: Colors.black),
                                  ),
                                  color: Colors.white)),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Form(
                              // here we associate a form key with our form with the help of key
                              key: _formKey,
                              autovalidate:
                                  true, // to immediate execute validator
                              // as soon as user typed
                              child: TextFormField(
                                  validator: (val) {
                                    if (val.trim().isEmpty)
                                      return "Must Not Empty";
                                    else if (val.trim().length > 6)
                                      return "Wrong Entry";
                                    else
                                      return null;
                                  },
                                  onChanged: (val) => regNo = int.parse(val),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Reg. Number",
                                    labelStyle: TextStyle(fontSize: 15.0),
                                    hintText: "Register Number",
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/coat.svg',
                          height: 30,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "COAT",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value1 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val1 > 1) val1--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val1.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val1++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                        value: this.value1,
                        onChanged: (bool value) {
                          setState(() {
                            if (this.value1 == false) {
                              this.value1 = true;
                              val1 = 1;
                            } else {
                              this.value1 = false;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/trouser.svg',
                          height: 27,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "PENT",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value2 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val2 > 1) val2--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val2.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val2++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                          value: this.value2,
                          onChanged: (bool value) {
                            setState(() {
                              if (this.value2 == false) {
                                this.value2 = true;
                                val2 = 1;
                              } else {
                                this.value2 = false;
                              }
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 11),
                      child: Container(
                        width: 30,
                        child: Image.asset(
                          "assets/images/shirt_.png",
                          height: 20,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "SHIRT",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value3 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val3 > 1) val3--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val3.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val3++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                          value: this.value3,
                          onChanged: (bool value) {
                            setState(() {
                              if (this.value3 == false) {
                                this.value3 = true;
                                val3 = 1;
                              } else {
                                this.value3 = false;
                              }
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/vest.svg',
                          height: 30,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "JACKET",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value4 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val4 > 1) val4--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val4.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val4++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                          value: this.value4,
                          onChanged: (bool value) {
                            setState(() {
                              if (this.value4 == false) {
                                this.value4 = true;
                                val4 = 1;
                              } else {
                                this.value4 = false;
                              }
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 14),
                      child: Container(
                        width: 20,
                        child: Image.asset(
                          "assets/images/kurta.png",
                          height: 30,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "KURTA",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value5 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val5 > 1) val5--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val5.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val5++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                          value: this.value5,
                          onChanged: (bool value) {
                            setState(() {
                              if (this.value5 == false) {
                                this.value5 = true;
                                val5 = 1;
                              } else {
                                this.value5 = false;
                              }
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/pajama.svg',
                          height: 30,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "PAJAMA",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value6 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val6 > 1) val6--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val6.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val6++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                          value: this.value6,
                          onChanged: (bool value) {
                            setState(() {
                              if (this.value6 == false) {
                                this.value6 = true;
                                val6 = 1;
                              } else {
                                this.value6 = false;
                              }
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/achkan.svg',
                          height: 30,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "ACHKAN",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value7 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val7 > 1) val7--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val7.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val7++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                          value: this.value7,
                          onChanged: (bool value) {
                            setState(() {
                              if (this.value7 == false) {
                                this.value7 = true;
                                val7 = 1;
                              } else {
                                this.value7 = false;
                              }
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/others.svg',
                          height: 30,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      "Other",
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                      child: value8 == true
                          ? Container(
                              child: Row(
                                children: [
                                  UpdateValueButton(
                                    icon: Icons.remove,
                                    perform: () {
                                      setState(() {
                                        if (val8 > 1) val8--;
                                      });
                                    },
                                  ),
                                  Container(
                                    height: 30,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        val8.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  UpdateValueButton(
                                    icon: Icons.add,
                                    perform: () {
                                      setState(() {
                                        val8++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Checkbox(
                          value: this.value8,
                          onChanged: (bool value) {
                            setState(() {
                              if (this.value8 == false) {
                                this.value8 = true;
                                val8 = 1;
                              } else {
                                this.value8 = false;
                              }
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "RETURN DATE:",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: dateSelected == true
                          ? Text(showDate,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple,
                              ))
                          : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 23),
                      child: GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.green,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 50.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: branch == 0 ? Colors.blue : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
