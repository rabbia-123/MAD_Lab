/// Prints a welcome banner.
void printWelcome(String appName) {
  print('=== $appName ===');
}

void main() {
  // Part 1
  printWelcome('Course Roster Manager');

  //Part 2:
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();
  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};

  print('$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}');

  //Part 3:
  String? instructorEmail;
  print(instructorEmail ?? 'TBA');
  String generateCode(String title) => title.substring(0, 2).toUpperCase() + '101';

  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);
  print('Enrollment code: $enrollmentCode');

  print(instructorEmail?.length ?? 0);

  // Prt 4:
  String rawNames = ' Aiden , maria ,JAMAL , Priya ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }
  print(cleanNames);

  String courseDescription = '''
This course covers mad
using Flutter and Dart planguage.
''';
  print(courseDescription);

  print('Seats left: ${capacity - enrolledStudents.length}');
    //Part 5
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full groups of 3: $fullGroups, leftover: $leftover');

  Object formInput = 'twenty-two';
  if (formInput is String) {
    print('This is text!');
  }
  if (formInput is! int) {
    print('This is not a number!');
  }

  var report = StringBuffer()
    ..write('Report: $courseTitle | ')
    ..write('Cap: $capacity | ')
    ..write('Roster: ${enrolledStudents.length}');
  print(report.toString());

  List<String>? extraNotes;
  extraNotes?..add('Room pending');
  print(extraNotes);

  int? bonusSeats;
  bonusSeats ??= 0;
  print(bonusSeats);

  // Part 6
  if (isOpen && enrolledStudents.length < capacity) {
    print("You're inWelcome");
  } else {
    print('Sorry enrollment  closed');
  }

  int enrollmentStatusCode = 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  // Part 7
  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((key, value) {
    print('$key: $value');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist) 'Reminder: $student, please cofirm attendance',
  ];

  for (var announcement in announcements) {
    print(announcement);
  }
    }