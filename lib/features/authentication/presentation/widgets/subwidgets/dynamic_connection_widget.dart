import 'package:flutter/material.dart';

import '../../../../../core/connection_management.dart';

class DynamicConnexionWidget extends StatelessWidget{
  final String link ;
  final String tag ;
  final String buttonContent ;
  final Color buttonColor ;
  DynamicConnexionWidget({required this.buttonColor,required this.buttonContent,required this.link,required this.tag,super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: connectionStream.stream,
      initialData: true,
      builder: (context, snapshot) {
        bool isConnected = snapshot.data ?? false;
        return SizedBox(
          height: 40,
          child: FloatingActionButton.extended(
            onPressed: isConnected
                ? () {
              // Optional: You can still manually trigger a connection check here if needed
              // checkConnectionAndUpdate();
              Navigator.pushNamed(context, link);
            }
                : null,
            heroTag: tag,
            elevation: 0,
            backgroundColor: isConnected ?  buttonColor : Colors.grey,
            label:  Text(
              buttonContent,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}