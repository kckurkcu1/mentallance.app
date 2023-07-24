part of appointment;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<String> topBarTitles = ['Gelecek Randevular', 'Geçmiş Randevular', 'Silinen Randevular'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Takvim'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: _focusedDay.subtract(const Duration(days: 7)),
            lastDay: _focusedDay.add(const Duration(days: 7)),
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(topBarTitles.length, (index) {
              return Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 40,
                color: lightColorScheme.primaryContainer,
                child: Center(
                  child: Text(
                    topBarTitles[index],
                    style:  TextStyle(
                      color: lightColorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
