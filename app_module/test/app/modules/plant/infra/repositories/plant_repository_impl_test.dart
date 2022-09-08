import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plantae/app/core/errors/datasource_error.dart';
import 'package:plantae/app/core/helpers/either.dart';
import 'package:plantae/app/modules/plant/domain/entities/plant_entity.dart';
import 'package:plantae/app/modules/plant/domain/params/create_plant_params.dart';
import 'package:plantae/app/modules/plant/domain/repositories/i_plant_repository.dart';
import 'package:plantae/app/modules/plant/infra/datasources/i_plant_datasource.dart';
import 'package:plantae/app/modules/plant/infra/repositories/plant_repository_impl.dart';

class PlantDatasourceMock extends Mock implements IPlantDatasource {}

void main() {
  late final IPlantDatasource plantDatasource;
  late final IPlantRepository sut;

  const kCreatePlantParams = CreatePlantParams(name: '', images: []);

  setUpAll(() {
    plantDatasource = PlantDatasourceMock();
    sut = PlantRepositoryImpl(plantDatasource);
  });

  setUp(() {
    registerFallbackValue(kCreatePlantParams);
  });

  group('Plant Repository | ', () {
    group('Create Plant | ', () {
      test('should be able to call the datasource and return a Unit if succeded', () async {
        when(() => plantDatasource.createPlant(any())).thenAnswer((_) async {});

        final response = await sut.createPlant(kCreatePlantParams);

        verify(() => plantDatasource.createPlant(any())).called(1);
        expect(response.fold((l) => l, (r) => r), isA<Unit>());
      });

      test('should return a DatasourceError if datasource fails', () async {
        when(() => plantDatasource.createPlant(any())).thenThrow(
          DatasourceError(message: 'Error', stackTrace: StackTrace.empty),
        );

        final response = await sut.createPlant(kCreatePlantParams);

        verify(() => plantDatasource.createPlant(any())).called(1);
        expect(response.fold((l) => l, (r) => r), isA<DatasourceError>());
      });
    });

    group('Get Plant | ', () {
      test('should be able to return a List of PlantEntity when calls Datasource', () async {
        when(() => plantDatasource.getPlants()).thenAnswer((_) async => []);

        final response = await sut.getPlants();

        verify(() => plantDatasource.getPlants()).called(1);
        expect(response.fold((l) => l, (r) => r), isA<List<PlantEntity>>());
      });

      test('should return a DatasourceError when datasource fails trying to get plants', () async {
        when(() => plantDatasource.getPlants()).thenThrow(DatasourceError(message: '', stackTrace: StackTrace.empty));

        final response = await sut.getPlants();

        expect(response.fold((l) => l, (r) => r), isA<DatasourceError>());
      });
    });
  });
}
