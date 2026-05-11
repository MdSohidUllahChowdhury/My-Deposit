import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:my_deposit/screen/deposit/deposit_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddDeposit extends StatefulWidget {
  const AddDeposit({super.key});

  @override
  State<AddDeposit> createState() => _AddDepositState();
}

class _AddDepositState extends State<AddDeposit> {
  final amount = TextEditingController();
  final amountKey = const Key("amount");
  final nameController = TextEditingController();
  final nameKey = const Key("name");

  @override
  void dispose() {
    super.dispose();
    amount.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.to(() => DepositMain(), transition: Transition.upToDown);
          },
          icon: Icon(Iconsax.back_square, color: Colors.white, size: 35),
        ),
        title: Text(
          "Deposit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.numans().fontFamily,
            letterSpacing: 1.4,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add Amount Text
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "\n   Add Your Amount",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Add Amount Card
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.36,
                width: MediaQuery.of(context).size.width * 0.98,
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color.fromRGBO(255, 255, 255, 0.2),
                  ),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add Amount Text
                    Text(
                      "Enter your Total Amount 🪴".toUpperCase(),
                      style: TextStyle(
                        color: const Color.fromARGB(192, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.numans().fontFamily,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      key: amountKey,
                      controller: amount,
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                        fontFamily: GoogleFonts.numans().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () async {
                        double? enteredAmount = double.tryParse(amount.text);

                        if (amount.text.isEmpty || enteredAmount == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  'Please enter a valid amount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: GoogleFonts.numans().fontFamily,
                                  ),
                                ),
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }
                        try {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                elevation: 30,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Colors.blueGrey,
                                title: Text(
                                  "Enter Full Name".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: GoogleFonts.numans().fontFamily,
                                  ),
                                ),
                                content: TextField(
                                  key: nameKey,
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Enter your name to confirm payment",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      fontFamily:
                                          GoogleFonts.numans().fontFamily,
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                        198,
                                        149,
                                        211,
                                        3,
                                      ),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 5,
                                    ),

                                    onPressed: () async {
                                      if (nameController.text.trim().isEmpty) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Center(
                                              child: Text(
                                                'Name is required to confirm!',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily:
                                                      GoogleFonts.numans()
                                                          .fontFamily,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      try {
                                        await Supabase.instance.client
                                            .from('solo_deposit_amount')
                                            .insert({
                                              'amount': amount.text,
                                              'user_name': nameController.text
                                                  .trim(),
                                              'uid': Supabase
                                                  .instance
                                                  .client
                                                  .auth
                                                  .currentUser
                                                  ?.id, // link to the logged-in user
                                            });

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Center(
                                              child: Text(
                                                'Payment confirmed successfully!',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily:
                                                      GoogleFonts.numans()
                                                          .fontFamily,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text('Error: $e')),
                                        );
                                      }
                                      setState(() {
                                        amount.clear();
                                        nameController.clear();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "Confirm Payment",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      },

                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(198, 149, 211, 3),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color.fromRGBO(255, 255, 255, 0.2),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "ACC: 2156211021594\nPREMIER BANK",
                      style: TextStyle(
                        color: const Color.fromARGB(160, 255, 255, 255),
                        fontFamily: GoogleFonts.numans().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Your deposit list text
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "\n   Your latest deposits",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: Supabase.instance.client
                  .from('solo_deposit_amount')
                  .stream(primaryKey: ['id'])
                  .eq('uid', Supabase.instance.client.auth.currentUser!.id)
                  .order('created_at'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No deposit history found."));
                }
                final deposits = snapshot.data!;
                return ListView.builder(
                  itemCount: deposits.length,
                  itemBuilder: (context, index) {
                    final item = deposits[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item['amount'] > 0
                            ? Colors.greenAccent.withValues(alpha: 0.55)
                            : Colors.red.withValues(alpha: 0.7),
                        radius: 25,
                        child: const Icon(
                          Iconsax.dollar_circle_copy,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      subtitle: Text(
                        "${item['user_name']}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "৳${item['amount']}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                          fontFamily: GoogleFonts.numans().fontFamily,
                        ),
                      ),
                      trailing: Text(
                        "Date: ${item['created_at'].toString().split('T')[0]}",
                        style: TextStyle(
                          color: const Color.fromARGB(167, 255, 255, 255),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
