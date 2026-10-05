// Path: err_state_widget/maintain_widget.dart
import 'package:flutter/material.dart';

class ServerMaintenance extends StatelessWidget {
  final VoidCallback? fun;

  const ServerMaintenance({super.key, this.fun});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xff3DB86B);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffFFF8E6),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/icons/maintenance.png"),
                  const SizedBox(height: 24),
                  const Text(
                    "PuTu is currently under maintenance\nto make your learning experience better.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff4A4E69)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Please check back again later.",
                    style: TextStyle(fontSize: 14, color: Color(0xff6B6F85)),
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton.icon(
                    onPressed: fun,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text("Try Again"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(220, 52),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: const StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
