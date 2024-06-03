nlp := SERVICE : plugin('nlp'), namespace('nlp'), library('nlp'), CPP, PURE
  string AnalyzeText(const string analyzer, const string txt) : cpp,pure,context,entrypoint='AnalyzeText';
  unicode UnicodeAnalyzeText(const string analyzer, const unicode txt) : cpp,pure,context,entrypoint='AnalyzeTextU';
END;




//read in create a dataset from logical files
linerec ParseLines(wordpages L) :=
  TRANSFORM
    SELF.line := L.line;
    SELF.parsed := nlp.AnalyzeText('after_lang', L.line);
  END;
//name of variable is wordpages
parses := PROJECT(wordpages, ParseLines(LEFT));
OUTPUT(parses);

// posrec := RECORD
//   STRING language;
//   STRING pos;
// END;

// wordrec := RECORD
//   STRING word;
//   DATASET(posrec) pos;
// END;

// parsedrec t1(linerec L) :=
//   TRANSFORM
//     SELF.word := L.word;
//     SELF.entities := XMLPROJECT('entity',
//       TRANSFORM(entityrec,
//         SELF.language := XMLTEXT('language');
//         SELF.pos := XMLTEXT('pos')
//       )
//     );
//   END;

// out := PARSE(parses, parsed, t1(LEFT), XML('xml'));
// OUTPUT(out);

textfile:=RECORD
  STRING pages;
END;

Wordfile:=RECORD
  STRING title;
END;




NLPRec := RECORD
  STRING language;
  STRING pos;
END;

LineRec := RECORD
  STRING line;
  DATASET(NLPRec) parsed;
END;

ParseLines(LineRec L) :=
  TRANSFORM
    SELF.line := L.line;
    SELF.parsed := FROMXML(NLPRec, L.line, ONFAIL(FAIL));
  END;

wordpages := DATASET('test.xml', {STRING line}, FLAT);
parses := PROJECT(wordpages, ParseLines(LEFT));
OUTPUT(parses);




// NLPRec := RECORD
//   STRING language;
//   STRING pos;
// END;

// LineRec := RECORD
//   STRING line;
//   DATASET(NLPRec) parsed;
// END;

// // Define the parsing function for each line
// ParseLines(LineRec L) :=
//   TRANSFORM
//     SELF.line := L.line;
//     SELF.parsed := FROMXML(NLPRec, L.line, ONFAIL(FAIL));
//   END;

// // Create a dataset with the parsed data
// wordpages := DATASET('test.xml', {STRING line}, FLAT);
// parses := PROJECT(wordpages, ParseLines(LEFT));
// OUTPUT(parses);
