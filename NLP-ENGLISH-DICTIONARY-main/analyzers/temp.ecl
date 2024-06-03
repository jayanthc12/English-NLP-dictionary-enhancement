// Generate nested xml
import nlp from lib_nlp;

article := RECORD
  STRING title;
  STRING url;
  STRING text;
END;

articles := DATASET('~xml::files::datafiles.xml',article,XML('articles/article'));
articles;

nlpResults := RECORD
  STRING title;
  INTEGER id;
  STRING url;
  STRING text;
  STRING xmlEntities;
END;
  
nlpResults ExtractEntities(article L, INTEGER c) := TRANSFORM
  SELF.title := L.title;
  SELF.id := c;
  SELF.url := L.url;
  SELF.text := L.text;
  SELF.xmlEntities := nlp.AnalyzeText('NLPAnalzyer',L.text);
END;

entities := PROJECT(articles,ExtractEntities(LEFT,COUNTER));
entities;

posrec := RECORD
  STRING pos;
  END;

wordrec := RECORD
  STRING word;
  DATASET(posrec) pos;
  END;

parsedrec t1(wordrec L) := TRANSFORM
  SELF.word := XMLTEXT('word/text');
  SELF.pos := XMLPROJECT('word',
                            TRANSFORM(posrec,
                                      SELF.pos := XMLTEXT('pos')
                                      ))
  END;

out := PARSE(entities, xmlEntities, t1(LEFT), XML('words'));
out;
