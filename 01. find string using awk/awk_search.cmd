BEGIN \
{\
   flag=0;\
   # Miplatform Tag Info
   arraytmp[0]="<Button";\
   arraytmp[1]="<Edit";\
   arraytmp[2]="<Checkbox";\
   arraytmp[3]="<MaskEdit";\
   arraytmp[4]="<Shape";\
   arraytmp[5]="<List";\
   arraytmp[6]="<Combo";\
   arraytmp[7]="<Radio";\
   arraytmp[8]="<Grid";\
   arraytmp[9]="<Spin";\
   arraytmp[10]="<Static";\
   arraytmp[11]="<Pie";\
   arraytmp[12]="<FileDialog";\
   arraytmp[13]="<File";\
   arraytmp[14]="<TextArea";\
   arraytmp[15]="<Progressbar";\
   arraytmp[16]="<TreeView";\
   arraytmp[17]="<Image";\
   arraytmp[18]="<Calendar";\
   arraytmp[19]="<Tab";\
   arraytmp[20]="<Div";\
   arraytmp[21]="<MultiLineTab";\
   arraytmp[22]="<WebBrowser";\
   arraytmp[23]="<HttpFile";\
   arraytmp[24]="<PopDiv";\
   arraytmp[25]="<WGateEx";\
   arraytmp[26]="<CyNamoWeCtl";\
   arraytmp[27]="<SKTNavigate";\
   arraytmp[28]="<AsyncSocket";\
   arraytmp[29]="<Form";\
   arraytmp[30]="<AxMSIE";\
   arraytmp[31]="<Datasets";\

   #Input Filename
   filename=ARGV[1];
}\
# Find Event function
function extract_evt(chk_line){\
   result=""
   nx1=index(chk_line, "On"); \

   #find Event Token initial keyword
   if ( nx1 > 0 ) {\
      #filtering not Keyword - must to exist space on the left position
      tmp=substr(chk_line, nx1-1,1); \
      if ( tmp != " " ) {
         extract_evt( substr(chk_line,nx1+2) );\
      }\
      else { \
          str1=substr(chk_line, nx1); \
     
          nx2=index(str1, "="); \

          #find Event Token final keyword
          if ( nx2 > 0 ) { \
             findstr=substr(str1,1,nx2-1);\
   
             #filtering not Keyword - must to exist no space in string
             if ( 0 == index(findstr," ") ) {\
                #print out Event Info
                printf( "%s ", findstr);\
                str2=substr(str1,nx2);\
                nx3=index(str2," ");\
                if ( nx3 > 0 ) {\
                    #next Keywork find
                    extract_evt(substr(str2,nx3));\
                }\
             }\
          }\
      }\
   }\
   return result;
}\
{\

   for ( ix=0; ix <= 28; ix++ ) { \
      # find Keyword and filtering
      if ( ( idx=index($1,arraytmp[ix]) > 0 ) && ( 0 == index($1,">") ) ) {\
         printf("%s %s  ",filename, substr($1,2)); extract_evt($0); printf("\n");\
      }\
   }\
}\
END\
{\
}\
