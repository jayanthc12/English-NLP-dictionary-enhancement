nlp := SERVICE : plugin('nlp'), namespace('nlp'), library('nlp'), CPP, PURE
  string AnalyzeText(const string analyzer, const string txt) : cpp,pure,context,entrypoint='AnalyzeText';
  unicode UnicodeAnalyzeText(const string analyzer, const unicode txt) : cpp,pure,context,entrypoint='AnalyzeTextU';
END;
linerec ParseLines(wordpages L) :=
  TRANSFORM
    SELF.line := L.line;
    SELF.parsed := nlp.AnalyzeText('LegalNames', L.line);
  END;

parses := PROJECT(wordpages, ParseLines(LEFT));

posrec := RECORD
  STRING language;
  STRING pos;
END;

wordrec := RECORD
  STRING word;
  DATASET(posrec) pos;
END;

parsedrec t1(linerec L) :=
  TRANSFORM
    SELF.word := L.word;
    SELF.entities := XMLPROJECT('entity',
      TRANSFORM(entityrec,
        SELF.language := XMLTEXT('language');
        SELF.pos := XMLTEXT('pos')
      )
    );
  END;

out := PARSE(parses, parsed, t1(LEFT), XML('xml'));
OUTPUT(out);