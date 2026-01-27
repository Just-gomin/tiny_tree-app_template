import 'package:flutter/material.dart';
import 'core/constants/mock_data.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'models/inquiry_model.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/history/history_screen.dart';
import 'screens/review/review_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Host Copilot',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: const _MainScreen(),
    );
  }
}

class _MainScreen extends StatefulWidget {
  const _MainScreen();

  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  late List<Inquiry> _inquiries;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _inquiries = MockData.getInquiries();
  }

  void _navigateToReview(Inquiry inquiry) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          inquiry: inquiry,
          onApprove: _handleApprove,
          onReject: _handleReject,
        ),
      ),
    );
  }

  void _handleApprove(Inquiry inquiry, String response) {
    setState(() {
      final int index = _inquiries.indexWhere((i) => i.id == inquiry.id);
      if (index != -1) {
        _inquiries[index] = inquiry.copyWith(
          status: InquiryStatus.sent,
          aiResponse: response,
          respondedAt: DateTime.now(),
        );
      }
    });
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('응답이 전송되었습니다')),
    );
  }

  void _handleReject() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('응답이 거절되었습니다')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardScreen(
            inquiries: _inquiries,
            onInquiryTap: _navigateToReview,
          ),
          HistoryScreen(inquiries: _inquiries),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textGray,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: '대시보드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '히스토리',
          ),
        ],
      ),
    );
  }
}
