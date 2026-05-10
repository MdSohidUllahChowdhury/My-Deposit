import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:my_deposit/screen/deposit/add_deposit.dart';
import 'package:my_deposit/screen/profile/profile.dart';
import 'package:my_deposit/utils/custom/widget/deposit/dev_info.dart';
import 'package:my_deposit/utils/custom/widget/deposit/exit.dart';
import 'package:my_deposit/utils/custom/widget/deposit/quick_action_btn.dart';
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
              const SizedBox(height: 30),

              // User Info
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Get.to(
                      () => ProfileScreen(),
                      transition: Transition.upToDown,
                    );
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('lib/asset/ShaMaNa.jpeg'),
                  ),
                ),
                title: Text(
                  "${Supabase.instance.client.auth.currentUser?.email}"
                      .toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.saira().fontFamily,
                  ),
                ),
                subtitle: Text(
                  "Every Payment Matter 🪩",
                  style: TextStyle(
                    fontFamily: GoogleFonts.notoColorEmoji().fontFamily,
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Iconsax.icon_icx,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () => showExitDialog(context),
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
                    width: MediaQuery.of(context).size.width * 0.95,
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
              const SizedBox(height: 10),

              // Options Text
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "     Options ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuickActionButton(
                    icon: Iconsax.teacher_copy,
                    label: 'Dev Info',
                    onTap: showDeveloperInfo,
                  ),
                  QuickActionButton(
                    icon: Iconsax.wallet_add_1_copy,
                    label: 'Deposit',
                    onTap: () async {
                      await Get.to(
                        () => const AddDeposit(),
                        transition: Transition.downToUp,
                      );
                      setState(() {});
                    },
                  ),
                  QuickActionButton(
                    icon: Iconsax.logout_1_copy,
                    label: 'Logout',
                    onTap: () => Logout().logout(),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Recent Activity Text
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "     Recent Activity",
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
