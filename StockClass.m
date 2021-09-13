classdef StockClass
   properties(Access = private)
       symbol
       dates
       returns
   end
  
   methods
       function obj = StockClass(stockSymbol, datesArray, closingsArray)
           obj.symbol = stockSymbol;
           obj.dates = datesArray;
           for i = 2:504
               obj.returns(i-1) = (closingsArray(i) - closingsArray(i-1)) / closingsArray(i);
           end
       end
       function pl = plot(obj)
               pl = 0;
               x = 1:503;
               figure;
               plot(x, 100 * obj.returns);
               xlim([-100, 600]);
               x1 = obj.dates{1}.getDate ;
               x2 = obj.dates{252}.getDate;
               x3 = obj.dates{503}.getDate;
               xticks([1 252 503]);
               xticklabels({x1, x2, x3});
               xlabel("Date");
               ylabel("Percent Change (%)");
               title("Percent Returns of " + obj.symbol);
       end  
           
   end

end
