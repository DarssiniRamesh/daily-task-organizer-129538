import 'package:flutter/material.dart';

// PUBLIC_INTERFACE
class LoginScreen extends StatefulWidget {
  /// This is the Login Screen UI that replicates the Figma-derived HTML/CSS/JS design for the login page.
  /// It matches layout, spacing, colors, typography approximations, and basic interactions:
  /// - Back button
  /// - Username and Password fields
  /// - Password visibility toggle
  /// - Login button
  /// - "or" divider
  /// - Social login buttons (Google and Apple)
  /// - Footer "Don’t have an account? Register"
  ///
  /// This screen is purely UI; submission and social actions show simple SnackBars to simulate app.js demo alerts/logs.
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// Color tokens based on common.css variables used on this screen.
class _LoginTokens {
  static const Color colorFFFFFF = Color(0xFFFFFFFF);
  static const Color color121212 = Color(0xFF121212);
  static const Color color8875ff = Color(0xFF8875FF);
  static const Color color8687e7 = Color(0xFF8687E7);
  static const Color color979797 = Color(0xFF979797);
  static const Color color535353 = Color(0xFF535353);
  static const Color color283544 = Color(0xFF283544);
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();

  bool _obscure = true;

  @override
  void dispose() {
    _usernameCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  // PUBLIC_INTERFACE
  void handleBack() {
    /** Handles the back button tap, attempting Navigator.pop when possible, otherwise no-op. */
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  // PUBLIC_INTERFACE
  void handleLoginTap() {
    /** Validates and simulates submit by showing a SnackBar, mirroring app.js behavior (demo). */
    final String username = _usernameCtl.text.trim();
    final String password = _passwordCtl.text;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login submitted (demo). User: $username, Password length: ${password.length}'),
      ),
    );
  }

  // PUBLIC_INTERFACE
  void handleSocialTap(String provider) {
    /** Simulates a social login tap by showing a SnackBar. */
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Clicked: $provider (demo)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Base scaffold with dark background as per design
    return Scaffold(
      backgroundColor: _LoginTokens.color121212,
      body: SafeArea(
        bottom: false,
        child: Center(
          // Constrain to 375x812 like the design artboard; keep responsive by scaling inside
          child: LayoutBuilder(
            builder: (context, constraints) {
              // width cap to 375
              final double width = constraints.maxWidth < 375 ? constraints.maxWidth : 375;
              return SizedBox(
                width: width,
                child: Stack(
                  children: <Widget>[
                    // Top spacing similar to iOS notch area (status bar is native, but simulate placements)
                    _buildBackButton(),
                    _buildTitle(),
                    _buildUsernameField(),
                    _buildPasswordField(),
                    _buildLoginButton(),
                    _buildDividerWithOr(),
                    _buildGoogleButton(),
                    _buildAppleButton(),
                    _buildFooterRegister(),
                    _buildBottomDragBar(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Absolute positioned components follow the Figma-derived HTML coordinates:
  // Title at left:24, top:122
  Widget _buildTitle() {
    return const Positioned(
      left: 24,
      top: 122,
      child: SizedBox(
        width: 78,
        height: 38,
        child: Text(
          'Login',
          // Approximating Lato 32/700; use default font but match weight/size
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 38.4 / 32,
            color: _LoginTokens.colorFFFFFF,
          ),
        ),
      ),
    );
  }

  // Back button at left:24, top:52 (24x24)
  Widget _buildBackButton() {
    return Positioned(
      left: 24,
      top: 52,
      child: SizedBox(
        width: 24,
        height: 24,
        child: InkWell(
          onTap: handleBack,
          borderRadius: BorderRadius.circular(12),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: _LoginTokens.colorFFFFFF,
          ),
        ),
      ),
    );
  }

  // Username group at left:24, top:213, width:327, height:80
  Widget _buildUsernameField() {
    return Positioned(
      left: 24,
      top: 213,
      child: SizedBox(
        width: 327,
        height: 80,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24.08 / 16,
                    color: _LoginTokens.colorFFFFFF,
                  ),
                ),
              ),
              _DarkFieldContainer(
                child: TextField(
                  controller: _usernameCtl,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 24.08 / 16,
                    color: _LoginTokens.colorFFFFFF,
                  ),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Mahsa Esfehany',
                    hintStyle: TextStyle(
                      color: _LoginTokens.color535353,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24.08 / 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Password group at left:24, top:318, width:327, height:80
  Widget _buildPasswordField() {
    return Positioned(
      left: 24,
      top: 318,
      child: SizedBox(
        width: 327,
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 24.08 / 16,
                  color: _LoginTokens.colorFFFFFF,
                ),
              ),
            ),
            _DarkFieldContainer(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _passwordCtl,
                      obscureText: _obscure,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 24.08 / 16,
                        color: _LoginTokens.colorFFFFFF,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: '••••••••••••',
                        hintStyle: TextStyle(
                          color: _LoginTokens.color535353,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 24.08 / 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: _LoginTokens.color979797,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Login button at left:24, top:467, width:327, height:48
  Widget _buildLoginButton() {
    return Positioned(
      left: 24,
      top: 467,
      child: SizedBox(
        width: 327,
        height: 48,
        child: ElevatedButton(
          onPressed: handleLoginTap,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(_LoginTokens.color8687e7),
            foregroundColor: WidgetStateProperty.all(_LoginTokens.colorFFFFFF),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            elevation: WidgetStateProperty.all(0),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 24.08 / 16,
              color: _LoginTokens.colorFFFFFF,
            ),
          ),
        ),
      ),
    );
  }

  // Divider with "or" at left:24, top:546, width:327, height:24
  Widget _buildDividerWithOr() {
    return Positioned(
      left: 24,
      top: 546,
      child: SizedBox(
        width: 327,
        height: 24,
        child: Stack(
          children: [
            // Left line 154px from left, vertical center at 12px high
            Positioned(
              left: 0,
              top: 12 - 0.5, // 1px height line centered
              child: Container(
                width: 154,
                height: 1,
                color: _LoginTokens.color979797,
              ),
            ),
            // "or"
            const Positioned(
              left: 155.5,
              top: 0,
              child: SizedBox(
                width: 16,
                height: 24,
                child: Center(
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24.08 / 16,
                      color: _LoginTokens.color979797,
                    ),
                  ),
                ),
              ),
            ),
            // Right line 153px wide from right
            Positioned(
              right: 0,
              top: 12 - 0.5,
              child: Container(
                width: 153,
                height: 1,
                color: _LoginTokens.color979797,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Google button at left:24, top:599, width:327, height:48
  Widget _buildGoogleButton() {
    return Positioned(
      left: 24,
      top: 599,
      child: SizedBox(
        width: 327,
        height: 48,
        child: OutlinedButton(
          onPressed: () => handleSocialTap('Google'),
          style: ButtonStyle(
            side: WidgetStateProperty.all(const BorderSide(color: _LoginTokens.color8875ff, width: 1)),
            foregroundColor: WidgetStateProperty.all(_LoginTokens.colorFFFFFF),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Approximate Google icon per HTML styled boxes
              SizedBox(
                width: 24,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 7,
                      top: 7,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4285F4),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 3,
                      top: 10,
                      child: Container(
                        width: 17,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF34A853),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 9,
                      top: 5,
                      child: Container(
                        width: 5,
                        height: 9,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBC05),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 3,
                      top: 0,
                      child: Container(
                        width: 17,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEB4335),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Login with Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 24.08 / 16,
                  color: _LoginTokens.colorFFFFFF,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Apple button at left:24, top:667, width:327, height:48
  Widget _buildAppleButton() {
    return Positioned(
      left: 24,
      top: 667,
      child: SizedBox(
        width: 327,
        height: 48,
        child: OutlinedButton(
          onPressed: () => handleSocialTap('Apple'),
          style: ButtonStyle(
            side: WidgetStateProperty.all(const BorderSide(color: _LoginTokens.color8875ff, width: 1)),
            foregroundColor: WidgetStateProperty.all(_LoginTokens.colorFFFFFF),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Square background with inner white block
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _LoginTokens.color283544,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 10.5,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _LoginTokens.colorFFFFFF,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Keep the original text as in HTML ("Appe" typo preserved)
              const Text(
                'Login with Appe',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 24.08 / 16,
                  color: _LoginTokens.colorFFFFFF,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Footer "Don’t have an account? Register" at left:104, top:761, width:167, height:18
  Widget _buildFooterRegister() {
    return const Positioned(
      left: 104,
      top: 761,
      child: SizedBox(
        width: 167,
        height: 18,
        child: Center(
          child: Text(
            'Don’t have an account? Register',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 18.06 / 12,
              color: _LoginTokens.colorFFFFFF,
            ),
          ),
        ),
      ),
    );
  }

  // Bottom drag bar at left:121, top:799, width:134, height:5
  Widget _buildBottomDragBar() {
    return Positioned(
      left: 121,
      top: 799,
      child: Container(
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: _LoginTokens.colorFFFFFF,
          borderRadius: BorderRadius.circular(36),
        ),
      ),
    );
  }
}

/// Dark field container replicating style_38 from CSS:
/// background #1d1d1d; border 0.8px solid #979797; radius 4px; height 48px; padding 0 12
class _DarkFieldContainer extends StatelessWidget {
  final Widget child;
  const _DarkFieldContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _LoginTokens.color979797, width: 0.8),
      ),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
