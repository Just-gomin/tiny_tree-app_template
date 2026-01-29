import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Entity', () {
    test('같은 ID를 가진 엔티티는 동등하다', () {
      const TestEntity entity1 = TestEntity(id: '1', name: 'Alice');
      const TestEntity entity2 = TestEntity(id: '1', name: 'Bob');

      expect(entity1, equals(entity2));
      expect(entity1.name, isNot(equals(entity2.name)));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('다른 ID를 가진 엔티티는 동등하지 않다', () {
      const TestEntity entity1 = TestEntity(id: '1', name: 'Alice');
      const TestEntity entity2 = TestEntity(id: '2', name: 'Alice');

      expect(entity1, isNot(equals(entity2)));
      expect(entity1.name, equals(entity2.name));
      expect(entity1.hashCode, isNot(equals(entity2.hashCode)));
    });

    test('stringify가 올바르게 작동한다', () {
      const TestEntity entity = TestEntity(id: '1', name: 'Alice');

      expect(entity.toString(), contains('TestEntity'));
      expect(entity.toString(), contains('1'));
    });
  });
}

// 테스트용 Entity 구현
class TestEntity extends Entity<String> {
  const TestEntity({required String id, required this.name}) : super(id);

  final String name;

  @override
  List<Object?> get props => <Object?>[id]; // ID만으로 비교
}
