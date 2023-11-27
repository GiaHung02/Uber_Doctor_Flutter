import 'package:flutter/material.dart';
import 'package:uber_doctor_flutter/src/model/doctor_model.dart';
import 'package:uber_doctor_flutter/src/theme/extention.dart';
import 'package:uber_doctor_flutter/src/theme/light_color.dart';
import 'package:uber_doctor_flutter/src/theme/text_styles.dart';
import 'package:uber_doctor_flutter/src/theme/theme.dart';
import 'package:uber_doctor_flutter/src/widgets/progress_widget.dart';
import 'package:uber_doctor_flutter/src/widgets/rating_start.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DoctorModel? doctorModel =
        ModalRoute.of(context)?.settings.arguments as DoctorModel?;

    if (doctorModel == null) {
      // Handle the case where the doctorModel is null, e.g., show an error message
      return Scaffold(body: Center(child: Text('Error: Doctor not found')));
    }

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
                  image:
                      AssetImage(doctorModel.image),
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
                                doctorModel.name,
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
                                rating: doctorModel.rating,
                              )
                            ],
                          ),
                          subtitle: Text(
                            doctorModel.type,
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
                              value: doctorModel.goodReviews,
                              totalValue: 100,
                              activeColor: LightColor.purpleExtraLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Good Review",
                              durationTime: 500,
                            ),
                            ProgressWidget(
                              value: doctorModel.totalScore,
                              totalValue: 100,
                              activeColor: LightColor.purpleLight,
                              backgroundColor: LightColor.grey.withOpacity(.3),
                              title: "Total Score",
                              durationTime: 300,
                            ),
                            ProgressWidget(
                              value: doctorModel.satisfaction,
                              totalValue: 100,
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
                          doctorModel.description,
                          style: TextStyles.body.subTitleColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _appBar(context, doctorModel),
            Positioned(
              top: AppTheme.fullHeight(context) * 0.45,
              left: 0,
              right: 0,
              child: _buildInfoCards(context, doctorModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, DoctorModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
        IconButton(
          icon: Icon(
            model.isfavourite ? Icons.favorite : Icons.favorite_border,
            color: model.isfavourite ? Colors.red : LightColor.grey,
          ),
          onPressed: () {
            // Handle favorite button tap
          },
        ),
      ],
    );
  }

  Widget _buildInfoCards(BuildContext context, DoctorModel doctorModel) {
    return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // children: <Widget>[
        //   _buildInfoCard("Experience", "${doctorModel.goodReviews} years"),
        //   _buildInfoCard("Patients", "${doctorModel.totalScore}k+"),
        //   _buildInfoCard("Certifications", "${doctorModel.satisfaction}"),
        // ],
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
