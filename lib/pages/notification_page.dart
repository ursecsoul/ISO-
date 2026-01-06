import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> allNotifications = [
    {
      "id": 1,
      "title": "Absen Berhasil",
      "message": "Kamu telah absen pada pukul 07:30, 18 Mei 2025",
      "icon": Icons.check_circle_outline,
      "color": Colors.green,
      "time": "5 menit yang lalu",
      "type": "Absen",
      "read": false,
    },
    {
      "id": 2,
      "title": "Belum Absen Hari Ini",
      "message": "Segera lakukan absen sebelum pukul 08:00",
      "icon": Icons.warning_amber_outlined,
      "color": Colors.orange,
      "time": "1 jam yang lalu",
      "type": "Absen",
      "read": false,
    },
    {
      "id": 3,
      "title": "Izin Disetujui",
      "message": "Pengajuan izin kamu telah disetujui oleh wali kelas.",
      "icon": Icons.check_circle,
      "color": Colors.blue,
      "time": "Kemarin",
      "type": "Izin",
      "read": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _markAsRead(int id) {
    setState(() {
      final index = allNotifications.indexWhere((n) => n['id'] == id);
      if (index != -1) {
        allNotifications[index]['read'] = true;
      }
    });
  }

  void _deleteNotification(int id) {
    setState(() {
      allNotifications.removeWhere((n) => n['id'] == id);
    });
  }

  List<Map<String, dynamic>> _filteredNotifications(String type) {
    if (type == "Semua") return allNotifications;
    return allNotifications.where((n) => n['type'] == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tabTypes = ["Semua", "Absen", "Izin"];
    final primaryColor = const Color(0xFF4CAF50);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          // Modern header design similar to "Pengajuan Izin Online"
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and title like in the reference image
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: primaryColor,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pusat Notifikasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Kelola notifikasi kamu",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Modern tab bar - smaller size
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey[700],
                    indicator: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 13,
                    ),
                    tabs: tabTypes.map((t) => Tab(text: t)).toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabTypes.map((tab) {
                final notifs = _filteredNotifications(tab);

                if (notifs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off_outlined, 
                          size: 64, 
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Tidak ada notifikasi",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifs.length,
                  itemBuilder: (context, index) {
                    final notif = notifs[index];

                    return Dismissible(
                      key: Key(notif['id'].toString()),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {
                        _deleteNotification(notif['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Notifikasi dihapus'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () => _markAsRead(notif['id']),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: notif['color'].withOpacity(0.1),
                                  radius: 24,
                                  child: Icon(
                                    notif['icon'], 
                                    color: notif['color'],
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              notif['title'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          if (!notif['read'])
                                            Container(
                                              margin: const EdgeInsets.only(left: 8),
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                            )
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        notif['message'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 14,
                                            color: Colors.grey[500],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            notif['time'],
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8, 
                                              vertical: 3
                                            ),
                                            decoration: BoxDecoration(
                                              color: (notif['type'] == 'Absen' 
                                                ? Colors.green 
                                                : Colors.blue).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              notif['type'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: notif['type'] == 'Absen' 
                                                  ? Colors.green 
                                                  : Colors.blue,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}