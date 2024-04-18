extractDateTime(DateTime dateTime){
  // 2024 ,2,5  12:90:30 time during create new task sent to database --> selected time
  // 2024,2,5  00:00:00 time when focus on date in my application --> focus time
  // i need to convert and filter time to became 12:00:00 -->selected time = focus time
  //1-->filetring to 2024,2,5 and ignore hours,minutes,seconds became 00:00: and send to data base during create task
  //2-->During get data from database i will search about query ("date time") using .where("date time",is equal
  //3-->after get date you should make selected time = focus time
  return DateTime(dateTime.year,dateTime.month,dateTime.day);
}