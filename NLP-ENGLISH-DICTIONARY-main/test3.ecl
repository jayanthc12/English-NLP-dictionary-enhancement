import nlp from lib_nlp;

page := RECORD
  STRING title;
  STRING text;
END;

pages := DATASET('test::test::ansx.xml', page, XML('xml/page'));
pages;
nlpResults := RECORD
INTEGER count ;
  STRING title;
  STRING xmlWords;
END;

nlpResults ExtractWords(page L, INTEGER c) := TRANSFORM
  SELF.count := c;
  SELF.title := L.title;
  SELF.xmlWords := nlp.AnalyzeText('afterlang', L.text);
  
END;

words := PROJECT(pages, ExtractWords(LEFT, COUNTER));
OUTPUT(words);

posrec := RECORD
  STRING pos;
  END;

wordrec := RECORD
    STRING word;
    DATASET(posrec) pos;
  END;

wordrec extractpos(nlpResults L) := TRANSFORM
  SELF.word  := L.title;
  SELF.pos := XMLPROJECT('word',
                          TRANSFORM(posrec ,
                          SELF.pos := XMLTEXT('pos')));

END;

// out := PARSE(words, xmlWords, extractpos(LEFT),XML('xml'));
// out;
// <word>     <wordid>1</wordid>     <word>==English==</word> </word> <xml>    <word>    <text>==English==     </text>    <pos>verb</pos>    <pos>noun</pos>    </word> </xml>