void main() {
  final parent = Parent(id: 1);

  print(parent.id);

  final child = Child(id: 3);

  print(child.id);

  final parent2 = Parent.fromInt(5);

  print(parent2.id);

  // Instance of 'Child'
  print(parent2);
}

class Parent {
  final int id;

  Parent({
    required this.id,
  });

  // factory constructor: 일반 메소드, 함수처럼 body가 있습니다. 그리고 현재 클래스의 인스턴스를 무조건 반환해줘야합니다.
  // ? named constructor
  factory Parent.fromInt(int id) {
    // return Parent(id: id);
    // factory constructor !!!
    // 현재 클래스(Parent)의 Instance 뿐만 아니라
    // 현재 클래스(Parent)를 상속하고 있는 클래스(Child)의 인스턴스도 반환할 수 있다. (만들 수 있다.)
    return Child(id: id);
  }
}

class Child extends Parent {
  Child({
    required super.id,
  });
}
