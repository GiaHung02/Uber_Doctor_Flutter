import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart'; // Assuming Doctor model is in this path
import 'package:uber_doctor_flutter/src/theme/extention.dart';
import 'package:uber_doctor_flutter/src/theme/light_color.dart';
import 'package:uber_doctor_flutter/src/theme/text_styles.dart';
import 'package:uber_doctor_flutter/src/theme/theme.dart';
import 'package:uber_doctor_flutter/src/widgets/progress_widget.dart';
import 'package:uber_doctor_flutter/src/widgets/rating_start.dart';

class DetailPage extends StatelessWidget {
  final List<Doctor> doctors;
  final int selectedIndex;

  DetailPage({required this.doctors, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    // Check if the doctors list is not empty and selectedIndex is valid
    Doctor selectedDoctor =
        (doctors.isNotEmpty && selectedIndex < doctors.length)
            ? doctors[selectedIndex]
            : Doctor(); // Replace Doctor() with the default value for a Doctor object

    TextStyle titleStyle = TextStyles.title
        .copyWith(fontSize: 25)
        .copyWith(fontWeight: FontWeight.bold);
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title
          .copyWith(fontSize: 23)
          .copyWith(fontWeight: FontWeight.bold);
    }

    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: AppTheme.fullHeight(context) * 0.45,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/goku.jpg'),
                ),
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: EdgeInsets.only(left: 19, right: 19, top: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${selectedDoctor.fullName}',
                                style: titleStyle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                              Spacer(),
                              RatingStar(
                                rating: (selectedDoctor.rate ?? 0).toDouble(),
                              )
                            ],
                          ),
                          subtitle: Text(
                            '${selectedDoctor.spectiality}',
                            style: TextStyles.bodySm.subTitleColor
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Row(
                          children: <Widget>[
                            ProgressWidget(
                              value: (selectedDoctor.id ?? 0).toDouble(),
                              totalValue: 10,
                              activeColor: LightColor.purpleExtraLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Good Review",
                              durationTime: 500,
                            ),
                            ProgressWidget(
                              value: (selectedDoctor.exp ?? 0).toDouble(),
                              totalValue: 10,
                              activeColor: LightColor.purpleLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Total Score",
                              durationTime: 300,
                            ),
                            ProgressWidget(
                              value: (selectedDoctor.rate ?? 0).toDouble(),
                              totalValue: 5,
                              activeColor: LightColor.purple,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Satisfaction",
                              durationTime: 800,
                            ),
                          ],
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("About", style: titleStyle).vP16,
                        Text(
                          selectedDoctor.email ?? '',
                          style: TextStyles.body.subTitleColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _appBar(context),
            Positioned(
              top: AppTheme.fullHeight(context) * 0.45,
              left: 0,
              right: 0,
              child: _buildInfoCards(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
        // You can add more app bar actions or icons here if needed
      ],
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    // Customize this part based on the information you want to display
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // _buildInfoCard("Experience", "${selectedDoctor.goodReviews} years"),
        // _buildInfoCard("Patients", "${selectedDoctor.totalScore}k+"),
        // _buildInfoCard("Certifications", "${selectedDoctor.satisfaction}"),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: LightColor.purple,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
