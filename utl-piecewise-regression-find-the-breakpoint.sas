Piecewise regression find the breakpoint                                                                       
                                                                                                               
I could not find SAS code to do this?                                                                          
                                                                                                               
github                                                                                                         
https://tinyurl.com/y9uyr4so                                                                                   
https://github.com/rogerjdeangelis/utl-piecewise-regression-find-the-breakpoint                                
                                                                                                               
https://tinyurl.com/yacjlg3a                                                                                   
https://stackoverflow.com/questions/53670197/piecewise-regression-davies-test-returns-p-value-na               
                                                                                                               
Ben Bolker                                                                                                     
https://stackoverflow.com/users/190277/ben-bolker                                                              
                                                                                                               
INPUT                                                                                                          
=====                                                                                                          
                                                                                                               
 WORK.HAVE total obs=21                                                                                        
                                                                                                               
    X       Y                                                                                                  
                                                                                                               
  0.00    0.00                                                                                                 
  0.05    0.05                                                                                                 
  0.10    0.10                                                                                                 
  0.15    0.15                                                                                                 
  0.20    0.20                                                                                                 
  0.25    0.25                                                                                                 
  0.30    0.30                                                                                                 
  0.35    0.35                                                                                                 
  0.40    0.40                                                                                                 
  0.45    0.45                                                                                                 
  0.50    0.50                                                                                                 
  0.55    0.55                                                                                                 
  0.60    0.90                                                                                                 
  0.65    1.10                                                                                                 
  0.70    1.30                                                                                                 
  0.75    1.50                                                                                                 
  0.80    1.70                                                                                                 
  0.85    1.90                                                                                                 
  0.90    2.10                                                                                                 
  0.95    2.30                                                                                                 
  1.00    2.50                                                                                                 
                                                                                                               
                            Optimum                                                                            
                              0.55                                                                             
  2.5 +                        |                 *                                                             
      |                        |                                                                               
      |                        |               *                                                               
      |                        |                                                                               
      |                        |             *                                                                 
  2.0 +                        |                                                                               
      |                        |           *                                                                   
      |                        |                                                                               
      |                        |         *                                                                     
      |                        |                                                                               
  1.5 +                        |       *                                                                       
      |                        |                                                                               
      |                        |     *                                                                         
      |                        |                                                                               
      |                        |   *                                                                           
  1.0 +                        |                                                                               
      |                        | *                                                                             
      |                        |                                                                               
      |                        |                                                                               
      |                        *                                                                               
  0.5 +                    * * |                                                                               
      |                * *     |                                                                               
      |            * *         |                                                                               
      |        * *             |                                                                               
      |    * *                 |                                                                               
  0.0 +  *                     |                                                                               
      |                        |                                                                               
      ---+---------+---------+---------+---------+--                                                           
       0.00      0.25      0.50      0.75      1.00                                                            
                                                                                                               
                                                                                                               
EXAMPLE OUTPUT                                                                                                 
-------------                                                                                                  
                                                                                                               
 WORK.WANT total obs=8                                                                                         
                                                                                                               
 Obs  CAPTURE                                                                                                  
                                                                                                               
 1                                                                                                             
 2    Davies test for a change in the slope                                                                    
 3                                                                                                             
 4    data:  formula = y ~ x ,   method = lm                                                                   
 5    model = gaussian , link = identity                                                                       
 6    segmented variable = x                                                                                   
                  ****                                                                                         
 7    'best' at = 0.55, n.points = 10, p-value = 3.683e-14                                                     
                  ****                                                                                         
 8    alternative hypothesis: two.sided                                                                        
                                                                                                               
                                                                                                               
PROCESS                                                                                                        
=======                                                                                                        
                                                                                                               
%utlfkil(d:/xpt/want.xpt);                                                                                     
                                                                                                               
%utl_submit_r64('                                                                                              
library(SASxport);                                                                                             
library(segmented);                                                                                            
library(haven);                                                                                                
have<-read_sas("d:/sd1/have.sas7bdat");                                                                        
have;                                                                                                          
x<-have$X;                                                                                                     
y<-have$Y;                                                                                                     
res<-davies.test(lm(y ~ x), seg.Z = ~ x);                                                                      
want<-as.data.frame(capture.output(print(res)));                                                               
want[] <- lapply(want, function(x) if(is.factor(x)) as.character(x) else x);                                   
write.xport(want,file="d:/xpt/want.xpt");                                                                      
');                                                                                                            
                                                                                                               
libname xpt xport "d:/xpt/want.xpt";                                                                           
data want;                                                                                                     
  set xpt.want;                                                                                                
run;quit;                                                                                                      
                                                                                                               
proc print data=want;                                                                                          
run;quit;                                                                                                      
                                                                                                               
*                _              _       _                                                                      
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _                                                               
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |                                                              
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |                                                              
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|                                                              
                                                                                                               
;                                                                                                              
                                                                                                               
options validvarname=upcase;                                                                                   
libname sd1 "d:/sd1";                                                                                          
data sd1.have;                                                                                                 
  do x=0 to 1 by .05;                                                                                          
    if x < .6 then y=x;                                                                                        
    if x => .6 then y=4*x -1.5;                                                                                
    output;                                                                                                    
  end;                                                                                                         
run;quit;                                                                                                      
                                                                                                               
                                                                                                               
                                                                                                               
                                                                                                               
