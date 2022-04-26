import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String verificationId = '';

  void verify({required String phonenumber}) async {
    emit(AuthLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            emit(AuthSuccessState());
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(const AuthErrorState(
              error: 'Something Went Wrong, Check Your Phone Number!'));
        },
        codeSent: (String verificationId, int? resendtoken) {
          this.verificationId = verificationId;
          emit(PhoneNumberSubmittedState());
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  void submitOTP({required String smsCode}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      emit(AuthSuccessState());
    }).catchError((e) {
      emit(const AuthErrorState(
          error:
              'Something Went Wrong, Please Check Your Verification Code and Check Again!'));
    });
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    emit(UnAuthState());
  }
}
