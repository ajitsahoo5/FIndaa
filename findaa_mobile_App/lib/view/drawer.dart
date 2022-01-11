import 'package:findaa/view/login.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/male_avatar.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            "Ajit Sahoo",
                            style: TextStyle(fontSize: 22),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 0.5,
                endIndent: 20,
                indent: 20,
              ),
              /*(FindaaData.userType == "customer")
                  ? customerList()
                  : businessOwnerList(),*/
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomItem(Icons.person_outline_outlined, 'Profile'),
                      CustomItem(
                          Icons.add_business_outlined, 'Add your Business'),
                      CustomItem(Icons.business_outlined, 'My Business'),
                      CustomItem(Icons.request_quote_outlined,
                          'Post your Requirement'),
                      CustomItem(Icons.chat_outlined, 'Chat history'),
                      CustomItem(Icons.add_comment_outlined, 'Suppor chat'),
                      CustomItem(Icons.article_outlined, 'Term and Conditions'),
                      CustomItem(Icons.settings_outlined, 'Settings'),
                      CustomItem(Icons.info_outline, 'About Us'),
                      CustomItem(Icons.settings_outlined, 'Company'),
                      CustomItem(Icons.feedback_outlined, 'Feedback'),
                      CustomItem(Icons.logout, 'Logout'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customerList() {
    return Column(
      children: [
        CustomItem(Icons.person_outline_outlined, 'Profile'),
        CustomItem(Icons.add_business_outlined, 'Add your Business'),
        CustomItem(Icons.business_outlined, 'My Business'),
        CustomItem(Icons.request_quote_outlined, 'Post your Requirement'),
        CustomItem(Icons.chat_outlined, 'Chat history'),
        CustomItem(Icons.add_comment_outlined, 'Suppor chat'),
        CustomItem(Icons.article_outlined, 'Term and Conditions'),
        CustomItem(Icons.settings_outlined, 'Settings'),
        CustomItem(Icons.info_outline, 'About Us'),
        CustomItem(Icons.settings_outlined, 'Company'),
        CustomItem(Icons.feedback_outlined, 'Feedback'),
        CustomItem(Icons.logout, 'Logout'),
      ],
    );
  }

  Widget businessOwnerList() {
    return Column(
      children: [
        CustomItem(Icons.person_outline_outlined, 'Profile'),
        CustomItem(Icons.add_business_outlined, 'Add your Business'),
        CustomItem(Icons.business_outlined, 'My Business'),
        CustomItem(Icons.request_quote_outlined, 'Post your Requirement'),
        CustomItem(Icons.chat_outlined, 'Chat history'),
        CustomItem(Icons.add_comment_outlined, 'Suppor chat'),
        CustomItem(Icons.article_outlined, 'Term and Conditions'),
        CustomItem(Icons.settings_outlined, 'Settings'),
        CustomItem(Icons.logout, 'Logout')
      ],
    );
  }
}

class CustomItem extends StatelessWidget {
  IconData icon;
  String lebel;

  CustomItem(this.icon, this.lebel);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10, 8.0, 0),
      child: InkWell(
        onTap: () => {
          if (lebel == "Logout")
            {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()))
            },
        },
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 30),
              Icon(
                icon,
                color: Colors.orange,
                size: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lebel,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
