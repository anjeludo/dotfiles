
#!/bin/sh

cnee --record --keyboard 2>/dev/null |
awk -F, -v wanted=37 '$1==7{
 down = ($2==2); keycode = $6; tod = $8;
 if(keycode==wanted){
   if(down){
     diff = tod-last
     if(diff>500){ last = tod; next } # note time of first press
     else{
       	#printf "%s %s %d\n",down?"down":"up",keycode,diff
	system("tilix --quake&")
     }
   }else next
 }
 last = 0
}'
