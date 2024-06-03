import nlp from lib_nlp;

article := RECORD
  STRING title;
  STRING text;
END;

articles := DATASET('~test::test::ans.xml', article, XML('xml/page'));

nlpResults := RECORD
  STRING title;
  STRING xmlEntities;
END;

nlpResults ExtractEntities(article L, INTEGER c) := TRANSFORM
  SELF.title := L.title;
  // SELF.xmlEntities := nlp.AnalyzeText('afterlang', L.text);
  SELF.xmlEntities := XMLPROJECT('entity',
                            TRANSFORM(article,
                                      SELF.title := XMLTEXT('title'),
                                      SELF.text := XMLTEXT('pos')))
  END;
out := PARSE(parses, parsed, t1(LEFT), XML('xml'));

OUTPUT(out);

END;

entities := PROJECT(articles, ExtractEntities(LEFT));
OUTPUT(entities);

