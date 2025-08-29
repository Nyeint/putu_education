import 'package:flutter/material.dart';
import '../../../app/config/config.dart';

class ProgressBarView extends StatelessWidget {
  int currentStep;
  int totalSteps;
  ProgressBarView({super.key, required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                width: context.width,
                height: 15,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorResources.primary, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ColorResources.white
                ),
              ),
              FractionallySizedBox(
                widthFactor: currentStep/totalSteps,
                child: Container(
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ColorResources.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10,),
        Text('$currentStep/$totalSteps', style: FontFamily().semiBold.copyWith(fontSize: FontSize().sixteen),)
      ],
    );
  }
}
