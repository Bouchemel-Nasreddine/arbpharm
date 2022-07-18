import 'package:arbpharm/Views/Component/contact_element.dart';
import 'package:flutter/material.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import '../Component/back_app_bar.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
        child: const CustomBackAppBar(
          title: "Contactez-nous",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ContactElement(
              type: 0,
              icon: Icon(
                Icons.phone,
                color: spaceCadet,
              ),
              title: '+213770490594',
              titleSizeFactor: 2,
            ),
          ),
          Expanded(
            flex: 1,
            child: ContactElement(
              type: 0,
              icon: Icon(
                Icons.phone,
                color: spaceCadet,
              ),
              title: '+213770490595',
              titleSizeFactor: 2,
            ),
          ),
          Expanded(
            flex: 1,
            child: ContactElement(
              type: 0,
              icon: Icon(
                Icons.phone,
                color: spaceCadet,
              ),
              title: '+213770490596',
              titleSizeFactor: 2,
            ),
          ),
          Expanded(
            flex: 1,
            child: ContactElement(
              type: 1,
              icon: Icon(
                Icons.mail,
                color: spaceCadet,
              ),
              title: 'arbpharmaceutique@gmail.com',
              titleSizeFactor: 1.8,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
        ],
      ),
    );
  }
}
