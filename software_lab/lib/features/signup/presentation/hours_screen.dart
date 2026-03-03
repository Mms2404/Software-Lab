import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/constants/app_strings.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_logo.dart';
import 'package:software_lab/core/widgets/app_notification.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_event.dart';
import 'package:software_lab/features/signup/presentation/bloc/signup_state.dart';
import 'package:software_lab/features/signup/presentation/helpers/signup_flow_data.dart';

class HoursScreen extends StatefulWidget {
  const HoursScreen({super.key});

  @override
  State<HoursScreen> createState() => _HoursScreenState();
}

class _HoursScreenState extends State<HoursScreen> {
  int? selectedDayIndex;

  final days = ["M", "T", "W", "Th", "F", "S", "Su"];
  final dayKeys = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];

  final timeSlots = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm",
    "4:00pm - 7:00pm",
    "7:00pm - 10:00pm",
  ];

  Map<String, Set<int>> selectedHours = {};

  Set<int> get _currentDaySlots {
    if (selectedDayIndex == null) return {};
    final key = dayKeys[selectedDayIndex!];
    return selectedHours[key] ?? {};
  }

  void _toggleTimeSlot(int timeIndex) {
    if (selectedDayIndex == null) return;
    final key = dayKeys[selectedDayIndex!];
    setState(() {
      selectedHours.putIfAbsent(key, () => {});
      if (selectedHours[key]!.contains(timeIndex)) {
        selectedHours[key]!.remove(timeIndex);
        if (selectedHours[key]!.isEmpty) selectedHours.remove(key);
      } else {
        selectedHours[key]!.add(timeIndex);
      }
    });
  }

  Map<String, List<String>> _buildBusinessHours() {
    final result = <String, List<String>>{};
    for (final entry in selectedHours.entries) {
      final slots = entry.value.toList()..sort();
      result[entry.key] = slots.map((i) => timeSlots[i]).toList();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final flow = GoRouterState.of(context).extra as SignupFlowData;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case SignupSuccess(:final entity):
            AppNotification.success(context, entity.message);
            context.go("/signup/confirmation");
          case SignupFailure(:final failure):
            AppNotification.error(context, failure.message);
          case _:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 40.h, left: 25.w, right: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  AppLogo(),
                  SizedBox(height: 24.h),
                  Text("Signup 4 of 4", style: AppTextStyles.clue),
                  SizedBox(height: 6.h),
                  Text("Business Hours", style: AppTextStyles.title),
                  SizedBox(height: 12.h),
                  Text(
                    AppStrings.signupStep5,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade500,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
              
                  /// DAYS ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(days.length, (index) {
                      final key = dayKeys[index];
                      final hasSlots = selectedHours.containsKey(key);
                      final isActive = selectedDayIndex == index;
              
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDayIndex = index;
                          });
                        },
                        child: Container(
                          width: 38.w,
                          height: 38.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: isActive
                                ? const Color(0xFFD5715B)
                                : hasSlots 
                                 ? Colors.grey.shade200
                                 : Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.grey.shade300)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            days[index],
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: isActive
                                  ? Colors.white
                                  : hasSlots
                                      ? AppColors.logo
                                      : Colors.grey.shade500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
              
                  SizedBox(height: 28.h),
              
                  /// TIME SLOTS
                  if (selectedDayIndex != null)
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: List.generate(timeSlots.length, (index) {
                        final isSelected = _currentDaySlots.contains(index);
                        return GestureDetector(
                          onTap: () => _toggleTimeSlot(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.secondary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: isSelected
                              ? null
                              : Border.all(color: Colors.grey.shade300,
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              timeSlots[index],
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? AppColors.logo
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  else
                    Text(
                      "Select a day to set hours",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
              
                  const Spacer(),
              
                  /// BOTTOM ROW
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Image.asset(
                            "assets/icons/back.png",
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w),
                      Expanded(
                        child: state is SignupLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: const Color(0xFFD5715B),
                                  strokeWidth: 2.5,
                                ),
                              )
                            : GestureDetector(
                                onTap: () => _submit(context, flow),
                                child: Container(
                                  height: 52.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD5715B),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit(BuildContext context, SignupFlowData flow) {
    if (selectedHours.isEmpty) {
      AppNotification.warning(
        context,
        "Please select at least one day and time slot",
      );
      return;
    }

    flow.businessHours = _buildBusinessHours();

    context.read<SignupBloc>().add(
          SignupSubmitted(flow.toRequestModel()),
        );
  }
}