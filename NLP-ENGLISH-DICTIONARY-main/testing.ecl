import nlp from lib_nlp; 
text01 := 'amaze'+
'==English=='+
'===Verb==='+
'{{en-verb}}';

parsedtext01 := nlp.AnalyzeText('afterlang',text01); 
output(parsedtext01);