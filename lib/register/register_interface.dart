
import 'package:todo_app/model/user_dataclass.dart';

abstract class RegisterNavigator{
  void showLoading();
  void hideLoading();
  void showPositiveDialog(String msg);
  void showNegativeDialog(String msg);
  void addUserToGlobalProvider(Users user);

}