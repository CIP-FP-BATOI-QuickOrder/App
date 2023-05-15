import 'package:flutter/material.dart';
import 'package:quick_order/extensions/in_progress.dart';
import 'package:quick_order/screens/welcome/widgets/signing_button.dart';
import 'package:quick_order/screens/welcome/widgets/social_media_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_welcome.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome_gradient.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          Container(
            padding: const EdgeInsets.all(28.0),
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                Image.asset(
                  'assets/images/welcome_text.png',
                  height: 100,
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Your favourite foods delivered \nfast at your door.',
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                        ),
                        child: Text(
                          'sign in with',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const ButtonSigninWith(
                  positionButtom: false,
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ButtonWidget(
                    onPress: () => Navigator.pushNamed(
                      context,
                      "login",
                    ),
                    title: 'Start with email',
                    buttonColor: Colors.white.withOpacity(0.3),
                    titleColor: Colors.white,
                    borderColor: Colors.white,
                    paddingHorizontal: 16.0,
                    paddingVertical: 16.0,
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        "login",
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
    );
  }
}
