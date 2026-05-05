import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:my_deposit/screen/deposit/add_deposit.dart';
import 'package:my_deposit/utils/custom/widget/auth/glass_card.dart';

class DepositMain extends StatelessWidget {
  const DepositMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 80),

          // User Info
          ListTile(
            leading: const CircleAvatar(
              radius: 40,
              backgroundColor: Color.fromARGB(82, 255, 255, 255),
              child: Icon(
                Iconsax.direct_notification_copy,
                size: 30,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Shakil Chowdhury",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              "shakilkhanvip@gmail.com",
              style: TextStyle(
                color: const Color.fromARGB(192, 255, 255, 255).withAlpha(-1),
                fontSize: 14,
              ),
            ),
            trailing: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('lib/asset/logo.png'),
            ),
          ),
          const SizedBox(height: 30),

          // Total Amount
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
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
                      "৳ 27000.00",
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
          const SizedBox(height: 30),

          // Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlassCard(
                child: Column(
                  children: [
                    Icon(
                      Iconsax.profile_circle_copy,
                      size: 35,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Text('Profile'),
                  ],
                ),
              ),
              GlassCard(
                child: Column(
                  children: [
                    Icon(Iconsax.bank_copy, size: 35, color: Colors.white),
                    const SizedBox(height: 5),
                    Text('Deposit'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(transition: Transition.rightToLeft, () {
                    return const AddDeposit();
                  });
                },
                child: GlassCard(
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.arrow_down_2_copy,
                        size: 35,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      Text('Add'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Activity
          Align(
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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(82, 255, 255, 255),
                    child: Icon(
                      Iconsax.avalanche_avax,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    "Masumur Rahaman",
                    style: TextStyle(
                      fontFamily: GoogleFonts.numans().fontFamily,
                    ),
                  ),
                  subtitle: Text("5000 BDT "),
                  trailing: Text("05-05-2026"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
