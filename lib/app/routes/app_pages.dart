import 'package:get/get.dart';

import '../modules/day_month/bindings/day_month_binding.dart';
import '../modules/day_month/views/day_month_view.dart';
import '../modules/days_all/bindings/days_all_binding.dart';
import '../modules/days_all/views/days_all_view.dart';
import '../modules/days_daily/bindings/days_daily_binding.dart';
import '../modules/days_daily/views/days_daily_view.dart';
import '../modules/days_frequency/bindings/days_frequency_binding.dart';
import '../modules/days_frequency/views/days_frequency_view.dart';
import '../modules/days_zakat/bindings/days_zakat_binding.dart';
import '../modules/days_zakat/views/days_zakat_view.dart';
import '../modules/directed/bindings/directed_binding.dart';
import '../modules/directed/views/directed_view.dart';
import '../modules/expenses/bindings/expenses_binding.dart';
import '../modules/expenses/views/expenses_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inclusions/bindings/inclusions_binding.dart';
import '../modules/inclusions/views/inclusions_view.dart';
import '../modules/income_list/bindings/income_list_binding.dart';
import '../modules/income_list/views/income_list_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/months_income/bindings/months_income_binding.dart';
import '../modules/months_income/views/months_income_view.dart';
import '../modules/months_list/bindings/months_list_binding.dart';
import '../modules/months_list/views/months_list_view.dart';
import '../modules/mutasi/bindings/mutasi_binding.dart';
import '../modules/mutasi/views/mutasi_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/update_exspense/bindings/update_exspense_binding.dart';
import '../modules/update_exspense/views/update_exspense_view.dart';
import '../modules/update_income/bindings/update_income_binding.dart';
import '../modules/update_income/views/update_income_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';
import '../modules/week_month/bindings/week_month_binding.dart';
import '../modules/week_month/views/week_month_view.dart';
import '../modules/weeks_list/bindings/weeks_list_binding.dart';
import '../modules/weeks_list/views/weeks_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MUTASI,
      page: () => MutasiView(),
      binding: MutasiBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.EXPENSES,
      page: () => ExpensesView(),
      binding: ExpensesBinding(),
    ),
    GetPage(
      name: _Paths.INCLUSIONS,
      page: () => InclusionsView(),
      binding: InclusionsBinding(),
    ),
    GetPage(
      name: _Paths.DAY_MONTH,
      page: () => DayMonthView(),
      binding: DayMonthBinding(),
    ),
    GetPage(
      name: _Paths.DIRECTED,
      page: () => DirectedView(),
      binding: DirectedBinding(),
    ),
    GetPage(
      name: _Paths.DAYS_DAILY,
      page: () => DaysDailyView(),
      binding: DaysDailyBinding(),
    ),
    GetPage(
      name: _Paths.DAYS_FREQUENCY,
      page: () => DaysFrequencyView(),
      binding: DaysFrequencyBinding(),
    ),
    GetPage(
      name: _Paths.DAYS_ZAKAT,
      page: () => DaysZakatView(),
      binding: DaysZakatBinding(),
    ),
    GetPage(
      name: _Paths.DAYS_ALL,
      page: () => DaysAllView(),
      binding: DaysAllBinding(),
    ),
    GetPage(
      name: _Paths.WEEK_MONTH,
      page: () => WeekMonthView(),
      binding: WeekMonthBinding(),
    ),
    GetPage(
      name: _Paths.WEEKS_LIST,
      page: () => WeeksListView(),
      binding: WeeksListBinding(),
    ),
    GetPage(
      name: _Paths.MONTHS_LIST,
      page: () => MonthsListView(),
      binding: MonthsListBinding(),
    ),
    GetPage(
      name: _Paths.MONTHS_INCOME,
      page: () => MonthsIncomeView(),
      binding: MonthsIncomeBinding(),
    ),
    GetPage(
      name: _Paths.INCOME_LIST,
      page: () => IncomeListView(),
      binding: IncomeListBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_EXSPENSE,
      page: () => UpdateExspenseView(),
      binding: UpdateExspenseBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_INCOME,
      page: () => UpdateIncomeView(),
      binding: UpdateIncomeBinding(),
    ),
  ];
}
