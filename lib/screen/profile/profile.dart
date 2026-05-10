import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:my_deposit/utils/custom/widget/deposit/logout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    const double baseBalance = 00.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Iconsax.back_square, color: Colors.white, size: 35),
        ),
        title: Text(
          "Account Holder Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.numans().fontFamily,
            letterSpacing: 1.4,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // Only fetch records where 'uid' matches the logged-in user
        stream: Supabase.instance.client
            .from('solo_deposit_amount')
            .stream(primaryKey: ['id'])
            .eq('uid', user?.id ?? '')
            .order('created_at', ascending: false),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.cyanAccent),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error loading balance",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data ?? [];
          final double totalDeposit = data.fold(0, (sum, item) {
            return sum + (double.tryParse(item['amount'].toString()) ?? 0);
          });

          final String displayName = data.isNotEmpty
              ? data.first['user_name']
              : (user?.email ?? "User");

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Avatar and Name Section
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('lib/asset/ShaMaNa.jpeg'),
                ),
                const SizedBox(height: 15),
                Text(
                  displayName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user?.email ?? "",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 35),

                // Main Balance Display
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Your Total Deposit Amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.cyanAccent,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "৳ ${(baseBalance + totalDeposit).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          fontFamily: GoogleFonts.numans().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Transaction Info Tiles
                _buildProfileTile(
                  icon: Iconsax.wallet_1_copy,
                  title: "Total Deposits",
                  value: "৳ ${totalDeposit.toStringAsFixed(2)}",
                ),
                _buildProfileTile(
                  icon: Iconsax.nem_xem_copy,
                  title: "Deposit Count",
                  value: "${data.length}",
                ),
                _buildProfileTile(
                  icon: Iconsax.calendar_1_copy,
                  title: "Last Activity",
                  value: data.isNotEmpty
                      ? _formatDate(data.first['created_at'])
                      : "No activity",
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(
                      0.2,
                    ), // Subtle red background
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    onTap: () {
                      Logout().logout();
                    },

                    leading: Icon(Iconsax.logout_copy, color: Colors.redAccent),
                    title: Text(
                      "Log Out",
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper for info tiles
  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.cyanAccent, size: 24),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    final date = DateTime.parse(isoString);
    return "${date.day}.${date.month}.${date.year}";
  }
}
