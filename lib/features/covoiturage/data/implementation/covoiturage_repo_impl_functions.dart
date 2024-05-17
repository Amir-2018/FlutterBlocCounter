import 'package:pfechotranasmartvillage/core/database/database_helper.dart';
import '../../domain/model/covoiturage_model.dart';
import '../../presentation/covoiturage/covoiturages_search_field.dart';
import '../../presentation/list_covoiturages/list_covoiturage.dart';

class CovoiturageRepositoryImplFunctions{

  Future<List<CovoiturageModel>> getCovoituragesAndTitles(int page, int pageSize,DatabaseHelper databaseHelper) async {
    List<CovoiturageModel> listCovoiturages = await databaseHelper.getAllCovoiturages(page, pageSize);
    List<String> titles = await databaseHelper.getAllCovoiturageTitles();

    CovoiturageSearchField.options.addAll(titles.toSet());
    ListCovoiturages.page += 1;

    return listCovoiturages;

  }}