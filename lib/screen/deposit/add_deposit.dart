import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddDeposit extends StatefulWidget {
  const AddDeposit({super.key});

  @override
  State<AddDeposit> createState() => _AddDepositState();
}

final amount = TextEditingController();
final amountKey = const Key("amount");


class _AddDepositState extends State<AddDeposit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "\n   Add Your Amount ⤵ ",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.9,
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
                        // ignore: unrelated_type_equality_checks
                        if (amount == 0 || amount.text.isEmpty) return;

                        try {
                          await Supabase.instance.client
                              .from('solo_deposit_amount')
                              .insert({
                                'amount': amount.text,
                                'uid': Supabase
                                    .instance
                                    .client
                                    .auth
                                    .currentUser
                                    ?.id, // link to the logged-in user
                              });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data sent successfully!'),
                            ),
                          );
                        } catch (e) {
                          //print(e);
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                        setState(() {
                          amount.clear();
                        });
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

          // your deposit list
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
                        backgroundColor: const Color.fromARGB(
                          52,
                          234,
                          230,
                          230,
                        ),
                        radius: 35,
                        child: Icon(
                          Iconsax.money_add_copy,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      subtitle: Text(
                        "${Supabase.instance.client.auth.currentUser?.email}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      title: Text(
                        "৳${item['amount']}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      trailing: Text(
                        "Date: ${item['created_at'].toString().split('T')[0]}",
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
