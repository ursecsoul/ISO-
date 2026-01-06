import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RekapAbsenPage extends StatelessWidget {
  RekapAbsenPage({Key? key}) : super(key: key);

  final List<Map<String, String>> absenData = [
    {'tanggal': '2025-05-17', 'status': 'Hadir'},
    {'tanggal': '2025-05-16', 'status': 'Izin'},
    {'tanggal': '2025-05-15', 'status': 'Sakit'},
    {'tanggal': '2025-05-14', 'status': 'Alpha'},
    {'tanggal': '2025-05-13', 'status': 'Hadir'},
  ];

  @override
  Widget build(BuildContext context) {
    final primaryGreen = const Color(0xFF2E7D32);
    final accentGreen = const Color(0xFF4CAF50);
    final backgroundGreen = const Color(0xFFF1F8E9);
    final cardBackground = Colors.white;
    final textPrimary = const Color(0xFF1B5E20);
    final textSecondary = const Color(0xFF4E4E4E);
    final textMuted = const Color(0xFF757575);

    final now = DateTime.now();
    final tanggalHariIni = DateFormat.yMMMMEEEEd('id_ID').format(now);

    int hadir = absenData.where((e) => e['status'] == 'Hadir').length;
    int izin = absenData.where((e) => e['status'] == 'Izin').length;
    int sakit = absenData.where((e) => e['status'] == 'Sakit').length;
    int alpha = absenData.where((e) => e['status'] == 'Alpha').length;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan tanggal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 20,
                top: 20,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.mark_email_read_outlined,
                      color: primaryGreen,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rekap Absen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tanggalHariIni,
                        style: TextStyle(
                          fontSize: 13,
                          color: textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryGreen.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: accentGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.analytics_rounded,
                          color: primaryGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Ringkasan Kehadiran',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildModernStatBox('Hadir', hadir, const Color(0xFF2E7D32), Icons.check_circle_rounded),
                      _buildModernStatBox('Izin', izin, const Color(0xFFFF8F00), Icons.info_rounded),
                      _buildModernStatBox('Sakit', sakit, const Color(0xFF1976D2), Icons.local_hospital_rounded),
                      _buildModernStatBox('Alpha', alpha, const Color(0xFFD32F2F), Icons.cancel_rounded),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: accentGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.history_rounded,
                          color: primaryGreen,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Riwayat Kehadiran',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.refresh_rounded, size: 18, color: primaryGreen),
                    label: Text(
                      'Refresh',
                      style: TextStyle(color: primaryGreen, fontWeight: FontWeight.w600),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: cardBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: primaryGreen.withOpacity(0.1),
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: absenData.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final absen = absenData[index];
                  final tgl = DateFormat.yMMMMd('id_ID').format(DateTime.parse(absen['tanggal']!));
                  final hari = DateFormat.EEEE('id_ID').format(DateTime.parse(absen['tanggal']!));

                  return Container(
                    decoration: BoxDecoration(
                      color: cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: _getColor(absen['status']!).withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: _getColor(absen['status']!).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _getColor(absen['status']!),
                              _getColor(absen['status']!).withOpacity(0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _getIcon(absen['status']!),
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      title: Text(
                        tgl,
                        style: TextStyle(
                          color: textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        hari,
                        style: TextStyle(
                          color: textMuted,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _getColor(absen['status']!).withOpacity(0.15),
                              _getColor(absen['status']!).withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: _getColor(absen['status']!).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          absen['status']!,
                          style: TextStyle(
                            color: _getColor(absen['status']!),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildModernStatBox(String label, int count, Color color, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color, color.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text('$count',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                )),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4E4E4E),
                )),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String status) {
    switch (status) {
      case 'Hadir':
        return Icons.check_circle_rounded;
      case 'Izin':
        return Icons.info_rounded;
      case 'Sakit':
        return Icons.local_hospital_rounded;
      case 'Alpha':
        return Icons.cancel_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  Color _getColor(String status) {
    switch (status) {
      case 'Hadir':
        return const Color(0xFF2E7D32);
      case 'Izin':
        return const Color(0xFFFF8F00);
      case 'Sakit':
        return const Color(0xFF1976D2);
      case 'Alpha':
        return const Color(0xFFD32F2F);
      default:
        return Colors.grey;
    }
  }
}
