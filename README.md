/// how to sort week in year

void main() {
 
  var a = [
    {
      "nama" : "adi",
      "week"  : 7
    },
    {
      "nama" : "hadi",
      "week"  : 6
    },
    {
      "nama" : "fadi",
      "week"  : 7
    },
    {
      "nama" : "dadi",
      "week"  : 13
    },
    {
      "nama" : "hjadi",
      "week"  : 45
    },
  ];
  
  Map<String, List<Object>> week ={};
  
  for (int i = 1; i < 53; i++) {
    List<Object> content= [];
   for(int j = 0; j < a.length; j++){
         if(a[j]["week"] == i){
           content.add(a[j]);
         }
   }
//     print(content);
    week["week"+i.toString()] = content; 
  }
  print(week);
}





<br>
 1. First, you must register into the apps, and validate your email on inbox or spam
![Register](/images/1.PNG)
 <br>
 2. then login into the apps 
![Login](/images/2.PNG)
 <br>
 3. home page apps 
![homepage](/images/3.PNG)
 <br>
