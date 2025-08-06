import 'package:bhk_artisan/common/myUtils.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/resources/images.dart';
import 'package:flutter/material.dart';

import '../../../data/response/status.dart';

class Stocks extends StatelessWidget {
  const Stocks({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            color: appColors.backgroundColor,
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Column(
                          children: [
                            // Header Text
                            Text(
                              "Hi, there.",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            SizedBox(height: 100),
                            // Mammoth Image (Use asset image here)
                            Image.asset(
                              appImages
                                  .firststock, // Add your mammoth image to assets
                              height: 200,
                              width: 180,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(height: 70),
                            // Greeting Text
                            Text(
                              'Add Your Stocks',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[900],
                              ),
                            ),
                            SizedBox(height: 10),
                            // Subtext
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "Thanks for checking out Harry's, we hope our products can "
                                "make your morning routine a little more enjoyable.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]),
                              ),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
          // Progress bar overlay
          progressBarTransparent(
            Status.COMPLETED == Status.LOADING,
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
          ),
        ],
    );
  }
}
