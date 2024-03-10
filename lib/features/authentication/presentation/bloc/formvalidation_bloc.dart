// import 'package:email_validator/email_validator.dart';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// part 'formvalidation_event.dart';
// part 'formvalidation_state.dart';

// class InputValuesBloc extends Bloc<InputValuesEvent, FormValuesState> {
//   InputValuesBloc() : super(InitialFormVauesState()) {
//     on<NameValueEvent>((event, emit) {
//       if (event.content == "") {
//         emit(InputError(""));
//       } else if (!(EmailVaalidator.validate(event.content))) {
//         emit(InputError("Please enter a valid email address "));
//       } else {
//         emit(InputSuccess("Valid email input"));
//       }
//     });

//     on<UsernameValueEvent>((event, emit) {
//       if (event.content == "") {
//         emit(InputError(""));
//       } else if (!(EmailValidator.validate(event.content))) {
//         emit(InputError("Please enter a valid email address "));
//       } else {
//         emit(InputSuccess("Valid email input"));
//       }
//     });

//     on<EmailValueEvent>((event, emit) {
//       if (event.content == "") {
//         emit(InputError(""));
//       } else if (!(EmailValidator.validate(event.content))) {
//         emit(InputError("Please enter a valid email address "));
//       } else {
//         emit(InputSuccess("Valid email input"));
//       }
//     });
//   }
// }
