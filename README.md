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





 1. First, you must register into the apps, and validate your email on inbox or spam
![register](/images/1.PNG)
 2. login page
![Login](/images/2.PNG)
 3. input exspenses apps 
![expense](/images/3.PNG)
 3. homepage 
![homepage](/images/4.PNG)
 4. income 
![income](/images/5.PNG)
 5. total money left (income month - expense month) 
![card](/images/5.PNG)
 6. mutasi 
![mutasi](/images/6.PNG)
                               
