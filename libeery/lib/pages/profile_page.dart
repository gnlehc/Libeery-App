import 'package:flutter/material.dart';
import 'package:libeery/models/msmhs_model.dart';
import 'package:libeery/models/msuser_model.dart';
import 'package:libeery/pages/home_page.dart';
import 'package:libeery/services/msuser_service.dart';
import 'package:libeery/styles/style.dart';
import 'package:libeery/widgets/navbar_widget.dart';
import 'package:libeery/pages/books_page.dart';
import 'package:libeery/pages/login_page.dart';
import 'package:libeery/arguments/user_argument.dart';

class ProfilePage extends StatefulWidget {
  final int selectedIndex;
  final String userId;

  const ProfilePage({
    Key? key,
    required this.selectedIndex,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;
  late MsMhs msMhs;
  MsUser? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    msMhs = MsMhs(
      nim: _userProfile?.nim ?? '',
      mhsPassword: '',
    );
    _getProfileData();
  }

  Future<void> _getProfileData() async {
    try {
      RequestUserBookedSession requestUser =
          RequestUserBookedSession(userID: widget.userId);
      MsUser userProfile = await MsUserService.getUserProfile(requestUser);
      setState(() {
        _userProfile = userProfile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error (e.g., show a Snackbar or dialog)
    }
  }

  Future<void> _logout() async {
    // Clear user data
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    UserArguments emptyArgs = UserArguments('', '');

    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const ChooseLoginPage(),
          settings: RouteSettings(arguments: emptyArgs)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userId: widget.userId,
            username: _userProfile?.mhsName,
            selectedIndex: 0,
          ),
        ),
      );
    } else if (_selectedIndex == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BooksPage(
            userId: widget.userId,
            username: _userProfile?.mhsName,
            selectedIndex: 1,
          ),
        ),
      );
    } else if (_selectedIndex == 2) {
      // stay on this page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show a loading indicator while fetching data
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_userProfile?.mhsName}',
                    style: const TextStyle(
                      fontSize: FontSizes.title,
                      fontWeight: FontWeights.bold,
                      color: AppColors.black
                    ),
                  ),
                  Text(
                    '${_userProfile?.nim}', 
                    style: const TextStyle(
                      fontSize: FontSizes.subtitle,
                      fontWeight: FontWeights.regular,
                      color: AppColors.black
                    ),
                  ),
                  const SizedBox(height: Spacing.large),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC75E5E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Keluar Akun',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: FontSizes.medium,
                          fontWeight: FontWeights.medium
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
