import 'package:ecommerce_app_mobile/data/service/impl/user_service_impl.dart';
import 'package:ecommerce_app_mobile/data/service/user_service.dart';
import 'package:ecommerce_app_mobile/sddklibrary/util/Log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'email_verification_event.dart';
import 'email_verification_state.dart';

class EmailVerificationBloc extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  final UserService userService = UserServiceImpl();

  EmailVerificationBloc() : super(InitialEmailVerificationState()) {
    on<SendEmailVerificationEvent>(
      (event, emit) async {
        final resource = await userService.sendVerificationEmail(event.user);

        if (resource.isSuccess) {
          emit(VerificationLinkSendSuccessState());
        } else {
          emit(VerificationLinkSendFailState(resource.error!));
        }
      },
    );

    on<IsUserVerifiedEvent>((event, emit) async {
      final resource = await userService.isEmailVerified();
      if (!resource.isSuccess) {
        emit(EmailVerificationFailState(resource.error!));
      } else if (resource.data!.firebaseUser!.emailVerified) {
        emit(EmailVerifiedState(resource.data!));
      } else {
        emit(EmailNotVerifiedState());
      }
    });
  }
}
