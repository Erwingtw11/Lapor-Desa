import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/report_model.dart';
import '../providers/auth_provider.dart';
import '../providers/report_provider.dart';
import '../widgets/report_card.dart';
import 'add_report_screen.dart';
import 'login_screen.dart';
import 'report_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportProvider>().fetchReports();
    });
  }

  Future<void> _openAddReport() async {
    final shouldRefresh = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddReportScreen()),
    );

    if (shouldRefresh == true && mounted) {
      await context.read<ReportProvider>().fetchReports();
    }
  }

  Future<void> _logout() async {
    await context.read<AuthProvider>().logout();

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _openDetail(ReportModel report) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportDetailScreen(report: report),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final reportProvider = context.watch<ReportProvider>();
    final reports = reportProvider.reports;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lapor Desa'),
        actions: [
          IconButton(
            onPressed: _logout,
            tooltip: 'Logout',
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddReport,
        backgroundColor: const Color(0xFFF46E50),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah Laporan'),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ReportProvider>().fetchReports(),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF10243E), Color(0xFF1E436A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${authProvider.user?.name ?? 'Warga Desa'}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sampaikan kondisi di lapangan dengan cepat. Pantau status laporan Anda langsung dari aplikasi.',
                    style: TextStyle(
                      height: 1.6,
                      color: Color(0xFFD7E9FF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Laporan Saya',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF10243E),
                  ),
                ),
                Text(
                  '${reports.length} item',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7A90),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (reportProvider.isLoading && reports.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (reportProvider.errorMessage != null && reports.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  reportProvider.errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              )
            else if (reports.isEmpty)
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.inbox_rounded,
                      size: 48,
                      color: Color(0xFF7B8AA0),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada laporan.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF10243E),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tekan tombol tambah laporan untuk mengirim laporan pertama Anda.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        color: Color(0xFF6B7A90),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...reports.map(
                (report) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ReportCard(
                    report: report,
                    onTap: () => _openDetail(report),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

