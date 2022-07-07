import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/cloud/student_cloud.dart';
import '../../theme/colors.dart';
import 'form_screen.dart';
import 'providers.dart';

// cloud StudentCloud
StudentCloud _studentCloud = StudentCloud();

class CaptureForm extends ConsumerWidget {
  const CaptureForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the currentScreenIndex
    final currentScreenIndex =
        ref.watch(currentScreenIndexProvider.state).state;

    // curentScreen
    final currentScreen = formScreens[currentScreenIndex];

    // check if we are on the first or last screen
    final isFirstScreen = currentScreenIndex == 0;

    // check if we are on the last screen
    final isLastScreen = currentScreenIndex == (screenList.length - 1);

    // return currentScreen;
    //
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(currentScreen.screenName),
        backgroundColor: kyuBlue,
      ),
      body: currentScreen.screenWidget,
      // bottom nav bar with 2 buttons next and back
      bottomNavigationBar: Container(
        color: kyuBlue,
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TExt button
            isFirstScreen
                ? const SizedBox()
                : TextButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    style: TextButton.styleFrom(primary: kyuWhite),
                    onPressed: () {
                      // go back to previous screen by decrementing the index
                      ref.read(currentScreenIndexProvider.notifier).state--;
                    },
                  ),

            // next button

            Consumer(builder: (context, ref, _) {
              return TextButton.icon(
                icon: Icon(isLastScreen ? Icons.check : Icons.arrow_forward),
                label: Text(isLastScreen ? "Submit" : 'Next'),
                style: TextButton.styleFrom(primary: kyuWhite),
                onPressed: isLastScreen
                    ? () {
                        // student
                        final student = ref.watch(studentProvider);

                        //
                        // ignore: avoid_print
                        print(student.toString());
                        // submit the form
                        _studentCloud.addNewStudent(student: student);
                      }
                    : () {
                        // go forward to next screen by incrementing the index
                        ref.read(currentScreenIndexProvider.notifier).state++;
                      },
              );
            }),
          ],
        ),
      ),
    );
  }
}
