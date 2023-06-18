import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_order/provider/worker_restaurant_provider.dart';
import 'package:quick_order/routes/routes.dart';
import 'package:quick_order/screens/welcome/widgets/signing_button.dart';
import 'package:quick_order/screens/welcome/widgets/social_media_buttons.dart';

class WorkersWelcomeScreen extends StatelessWidget {
  const WorkersWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (_) => WorkerRestaurantProvider(),
      child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/workers.png'),
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
                      const Spacer(flex: 3),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 1,
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
                                thickness: 1,
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
                      Consumer<WorkerRestaurantProvider>(
                        builder: (context, workerRestaurantProvider, _) {
                          return Expanded(
                            child: ButtonWidget(
                              onPress: () => Navigator.pushNamed(
                                  context,
                                  Routes.workersLogin,
                                  arguments: workerRestaurantProvider
                              ),
                              title: 'Start with nif',
                              buttonColor: Colors.white.withOpacity(0.3),
                              titleColor: Colors.white,
                              borderColor: Colors.white,
                              paddingHorizontal: 16.0,
                              paddingVertical: 16.0,
                            ),
                          );
                        },
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
                          Consumer<WorkerRestaurantProvider>(
                            builder: (context, workerRestaurantProvider, _) {
                              return InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.workersRegister,
                                  arguments: workerRestaurantProvider,
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
