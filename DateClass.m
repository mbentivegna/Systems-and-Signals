classdef DateClass
   properties(Access = private)
       year
       month
       day
   end
   properties(Constant)
       months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
   end
   
   methods
       function obj = DateClass(dateString)
           newString = split(dateString, "/");
 
           obj.month = newString(1);
           obj.day = newString(2);
           obj.year = newString(3);
       end
       
       function displayedDate = getDate(obj)
          intMonth = str2double(obj.month);
          properMonth = obj.months(intMonth);
           
          displayedDate = properMonth + " " + obj.day + ", " + obj.year;
       end
   end
end
