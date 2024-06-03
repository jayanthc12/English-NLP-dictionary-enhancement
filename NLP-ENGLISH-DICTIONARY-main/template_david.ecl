import nlp from lib_nlp;

linerec ParseLines(lines L) := TRANSFORM
 SELF.line := L.line;
  SELF.parsed := nlp.AnalyzeText('LegalNames',L.line);
END;

parses := PROJECT(lines,ParseLines(LEFT));
// OUTPUT(parses);

entityrec := RECORD
  STRING title;
  STRING name;
  END;

parsedrec := RECORD
  STRING line;
  DATASET(entityrec) entities;
  END;
parsedrec t1(linerec L) := TRANSFORM
  SELF.line := L.line;
  SELF.entities := XMLPROJECT('entity',
                            TRANSFORM(entityrec,
                                      SELF.title := XMLTEXT('title'),
                                      SELF.name := XMLTEXT('name')))
  END;
out := PARSE(parses, parsed, t1(LEFT), XML('xml'));

OUTPUT(out);