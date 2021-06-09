// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: Duration(seconds: 10),
    minimumFetchInterval: Duration(seconds: 10),
  ));

  final bool updated = await remoteConfig.fetchAndActivate();
  final bool blackButton = remoteConfig.getBool("blackButton");

  runApp(
    MaterialApp(
      home: RemoteConfigHome(
        blackButton: blackButton,
      ),
    ),
  );
}

class RemoteConfigHome extends StatelessWidget {
  final bool blackButton;

  const RemoteConfigHome({
    Key? key,
    required this.blackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Go to screen a"),
                style: ElevatedButton.styleFrom(
                  primary: blackButton ? Colors.black : Colors.white,
                ),
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: false,
                    pageBuilder: (context, animation1, animation2) {
                      return Dialog(
                        child: Container(
                          height: 300,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "ok",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
