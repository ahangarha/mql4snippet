#property copyright "Copyright 2014, File45"
#property link      "http://codebase.mql4.com/en/author/file45"
#property show_inputs
// Script: 0-A-SL-500   

// Default Inputs: Start
extern int StopLoss = 500;
// Default Inputs: End

double ot;
     
int start()
{  
   ot=OrdersTotal();
   for(int cnt=ot-1;cnt>=0;cnt--) 
   {
      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
      
      if (OrderSymbol()==Symbol() && OrderType()==OP_BUY)
      {
         if (StopLoss == 0)
         {
             ModifyStopLoss(0);
         }
         else
         {
             ModifyStopLoss(OrderOpenPrice() - StopLoss*Point);
         } 
      }
      
      if (OrderSymbol()==Symbol() && OrderType()==OP_SELL)
      {
         if (StopLoss == 0)
         {
             ModifyStopLoss(0);
         }       
         else
         {    
            ModifyStopLoss(OrderOpenPrice() + StopLoss*Point);
         }        
      }  
   }
   return(0);
}

void ModifyStopLoss(double xStopLoss) 
{
   bool modSL;
   modSL=OrderModify(OrderTicket(),OrderOpenPrice(),xStopLoss,OrderTakeProfit(),0,Red);
}

