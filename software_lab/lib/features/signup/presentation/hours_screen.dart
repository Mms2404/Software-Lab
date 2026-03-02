import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/constants/app_strings.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_notification.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_event.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_state.dart';
import 'package:software_lab/features/signup/presentation/helpers/signup_flow_data.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_bloc.dart';

class HoursScreen extends StatefulWidget {
  const HoursScreen({super.key});

  @override
  State<HoursScreen> createState() => _HoursScreenState();
}

class _HoursScreenState extends State<HoursScreen> {
  int? selectedDayIndex;
  int? selectedTimeIndex;
  bool loading = false;

  final days = ["M", "T", "W", "Th", "F", "S", "Su"];

  final timeSlots = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm",
    "4:00pm - 7:00pm",
    "7:00pm - 10:00pm",
  ];

  Map<String, List<String>> selectedHours = {};

  @override
  Widget build(BuildContext context) {
    final flow = GoRouterState.of(context).extra as SignupFlowData;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          setState(() {
            loading = true;
          });
        }

        if (state is SignupSuccess) {
          setState(() {
            loading = false;
          });
          AppNotification.success(context, "Account created successfully");
          context.go("/home");
        }

        if (state is SignupFailure) {
          setState(() {
            loading = false;
          });
          AppNotification.error(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFEDE6E4),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLogo(),
                  SizedBox(height: 20.h),

                  Text("Signup 4 of 4", style: AppTextStyles.clue),
                  SizedBox(height: 6.h),

                  Text("Business Hours", style: AppTextStyles.title),
                  SizedBox(height: 12.h),

                  Text(
                    AppStrings.signupStep5,
                    style: AppTextStyles.paragraph,
                  ),

                  SizedBox(height: 30.h),

                  /// DAYS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(days.length, (index) {
                      return AppButtons.chooseDay(
                        text: days[index],
                        state: selectedDayIndex == index
                            ? DaySelectionState.active
                            : DaySelectionState.defaultState,
                        onPressed: () {
                          setState(() {
                            selectedDayIndex = index;
                          });
                        },
                      );
                    }),
                  ),

                  SizedBox(height: 30.h),

                  /// TIME SLOTS
                  Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    children: List.generate(timeSlots.length, (index) {
                      return AppButtons.choose(
                        text: timeSlots[index],
                        isSelected: selectedTimeIndex == index,
                        onPressed: () {
                          setState(() {
                            selectedTimeIndex = index;
                          });
                        },
                      );
                    }),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Image.asset(
                          "assets/icons/back.png",
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),

                      SizedBox(width: 20.w),


                      loading 
                      ? CircularProgressIndicator(color: AppColors.primary,)
                      : Expanded(
                        child: AppButtons.full(
                          text: state is SignupLoading
                              ? "Please wait..."
                              : "Signup",
                          onPressed:(){
                            if( state is SignupLoading) return;
                            _submit(context, flow);
                          }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit(BuildContext context, SignupFlowData flow) {
    if (selectedDayIndex == null || selectedTimeIndex == null) {
      AppNotification.warning(
        context,
        "Please select a day and time slot",
      );
      return;
    }

    final selectedDay = days[selectedDayIndex!];
    final selectedTime = timeSlots[selectedTimeIndex!];

    selectedHours[selectedDay] = [selectedTime];

    flow.businessHours = selectedHours;

    context.read<SignupBloc>().add(
          SignupSubmitted(flow.toEntity()),
        );
  }
}