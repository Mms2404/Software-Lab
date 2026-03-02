import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:software_lab/core/constants/app_colors.dart';
import 'package:software_lab/core/constants/app_strings.dart';
import 'package:software_lab/core/theme/app_text_styles.dart';
import 'package:software_lab/core/widgets/app_buttons.dart';
import 'package:software_lab/core/widgets/app_notification.dart';
import 'package:software_lab/features/signup/presentation/helpers/signup_flow_data.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final flow = GoRouterState.of(context).extra as SignupFlowData;

    return Scaffold(
      backgroundColor: const Color(0xffEDE7E6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("FarmerEats", style: AppTextStyles.clue),

                SizedBox(height: 24.h),

                Text("Signup 3 of 4", style: AppTextStyles.clue),
                SizedBox(height: 8.h),

                Text("Verification", style: AppTextStyles.title),

                SizedBox(height: 16.h),

                Text(
                  AppStrings.signupStep4,
                  style: AppTextStyles.clue,
                ),

                SizedBox(height: 40.h),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Attach proof of registration",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    GestureDetector(
                      onTap: pickFile,
                      child: Container(
                        height: 48.h,
                        width: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child:Image.asset("assets/icons/camera.png")
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                if (selectedFile != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            selectedFile!.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFile = null;
                            });
                          },
                          child: Image.asset("assets/icons/exit.png",height: 15.h,width: 15.w,),
                        ),
                      ],
                    ),
                  ),

                const Spacer(),


                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),

                    SizedBox(width: 20.w),

                    Expanded(
                      child: AppButtons.full(
                        text: "Submit",
                        onPressed: () {
                          if (selectedFile == null) {
                            AppNotification.error(context, "Please upload registration proof");
                            return;
                          }
                          
                          flow.registrationProofPath = selectedFile!.path!;
                          context.push("/signup/hours", extra: flow);
                          
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}