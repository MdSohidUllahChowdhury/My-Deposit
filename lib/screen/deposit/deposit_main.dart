import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:my_deposit/screen/deposit/add_deposit.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_card.dart';
import 'package:my_deposit/utils/custom/widget/deposit/dev_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../utils/custom/widget/deposit/logout.dart';

class DepositMain extends StatefulWidget {
  const DepositMain({super.key});

  @override
  State<DepositMain> createState() => _DepositMainState();
}

class _DepositMainState extends State<DepositMain> {
  @override
  Widget build(BuildContext context) {
    const double mainBalance = 27000.00;

    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('solo_deposit_amount')
            .stream(primaryKey: ['id'])
            .order('created_at'),
        builder: (context, snapshot) {
          double totalDeposit = 0;
          List<Map<String, dynamic>> deposits = [];

          if (snapshot.hasData) {
            deposits = snapshot.data!;
            for (var item in deposits) {
              totalDeposit += double.tryParse(item['amount'].toString()) ?? 0;
            }
          }

          double currentUpdatedBalance = mainBalance + totalDeposit;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // User Info
              ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('lib/asset/ShaMaNa.jpeg'),
                ),
                title: Text(
                  "${Supabase.instance.client.auth.currentUser?.email}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.padauk().fontFamily,
                  ),
                ),
                subtitle: const Text(
                  "Every Payment Matter 🪩",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Total Amount Card
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.all(10),
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
                          "Total Vault Balance 🪴",
                          style: TextStyle(
                            color: const Color.fromARGB(160, 255, 255, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.numans().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "৳ ${currentUpdatedBalance.toStringAsFixed(0)}.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            fontFamily: GoogleFonts.numans().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 10),
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
              const SizedBox(height: 20),

              // Options Text
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "     Options  ⤵ ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      showDeveloperInfo();
                    },
                    child: const GlassCard(
                      child: Column(
                        children: [
                          Icon(
                            Iconsax.teacher_copy,
                            size: 35,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text('Dev Info'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Get.to(
                        transition: Transition.rightToLeft,
                        () => const AddDeposit(),
                      );
                      setState(() {});
                    },
                    child: const GlassCard(
                      child: Column(
                        children: [
                          Icon(
                            Iconsax.arrow_down_2_copy,
                            size: 35,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text('Add'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Logout().logout();
                    },
                    child: const GlassCard(
                      child: Column(
                        children: [
                          Icon(
                            Iconsax.logout_1_copy,
                            size: 35,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Recent Activity Text
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "     Recent Activity  ⤵ ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Activity List
              Expanded(
                child: snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : deposits.isEmpty
                    ? const Center(
                        child: Text(
                          "No deposit history found.",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: deposits.length,
                        itemBuilder: (context, index) {
                          final item = deposits[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color.fromARGB(
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
                              "${item['user_name']}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              "৳${item['amount']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            trailing: Text(
                              "Date: ${item['created_at'].toString().split('T')[0]}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
