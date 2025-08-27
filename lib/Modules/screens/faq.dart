import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:bhk_artisan/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';

class FAQ extends ParentWidget {
  const FAQ({super.key});
  
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar("FAQ"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FAQ's",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "View your bill, sign up for alerts and reminders, view your payment history, pay your bill and more with our Mobile Apps and Mobile Web App.",
                style: TextStyle(fontSize: 11),
              ),
             10.kH,
              Text(
                "Where do I go to setup an account?",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "The account setup can be completed by going to this link. You can also reach this page by clicking Customer Login in the top right of our webpage. Then click login, followed by New User under the login area.",
                style: TextStyle(fontSize: 11),
              ),
             10.kH,
              Text(
                "Where do I go to setup an account?",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "The account setup can be completed by going to this link. You can also reach this page by clicking Customer Login in the top right of our webpage. Then click login, followed by New User under the login area.",
                style: TextStyle(fontSize: 11),
              ),
             10.kH,
              Text(
                "What do I need to have to setup my account?",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "In order to setup your account, you'll need the account number, telephone number on the account, and a working email address.If you don't have a telephone number on your account, just give the office a call at (662)837-8139 and we can update your account.",
                style: TextStyle(fontSize: 11),
              ),
             10.kH,
              Text(
                "What is the difference between the Mobile App and the Mobile Web App?",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "Our Mobile Apps are native Apps that can be downloaded and installed on your compatible mobile device, while the Mobile Web App is a web portal that runs directly in the mobile browser on your smart phone or other mobile device. Both the native Apps and the Mobile Web App give you secure access to maintain your account information, to view your bills and your payment history, to manage your alerts and reminders, and to make payments on one or more accounts directly from your mobile device. The native Apps also allow you to register your accounts to receive push notifications for account milestones, such as an approaching or a missed due date. Push notifications are not available through the Mobile Web App. The Mobile Web App can be reached here or by clicking Customer Login in the top right of the page.",
                style: TextStyle(fontSize: 11),
              ),
             10.kH,
              Text(
                "Is the Mobile App secure?",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "Yes! All critical information is encrypted in every transaction run through the Apps and the Mobile Web App, and no personal information is stored on your mobile device. However, mobile devices do offer you the ability to store your login information for apps installed on the device. If you choose to store your login information, any person who has access to your mobile device can access your account.",
                style: TextStyle(fontSize: 11),
              ),
             10.kH,
              Text(
                "What features does the Mobile App have?",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "Both the Mobile Apps and the Mobile Web App give you the ability to view your accounts, view your bills, make secure payments directly from your mobile device, view your payment history, modify or maintain your subscriptions for alerts and reminders, and contact us via email or phone. Once you've installed a Mobile App on your phone, you'll also have the ability to receive push notifications and view a map of our offices and payment locations.",
                style: TextStyle(fontSize: 11),
              ),
              Text(
                "How do I get the Mobile App for my phone?",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
             10.kH,
              Text(
                "Simply look for our name in the App Store or in the Android Market. In the Android Market, if you can't find our App, that likely means your phone is not supported - see the list of supported operating systems. You may also click on the pictures below.",
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
