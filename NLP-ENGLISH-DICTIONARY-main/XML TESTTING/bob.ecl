// Define the dataset with the XML data
IMPORT STD;
xmlData := 
DATASET([
{'<xml>' +
'<page>' +
'<title>amaze</title>' +
'<ns>0</ns>' +
'<id>37907</id>' +
'<revision>' +
'<id>69378557</id>' +
'<parentid>68766239</parentid>' +
'<timestamp>2022-09-26T08:00:52Z</timestamp>' +
'<contributor>' +
'<username>WingerBot</username>' +
'<id>2024159</id>' +
'</contributor>' +
'<minor />' +
'<comment>clean up {{defdate}}, remove stray Unicode bidi marks (manually assisted)</comment>' +
'<model>wikitext</model>' +
'<format>text/x-wiki</format>' +
'<text bytes="3988" xml:space="preserve">' +
'<!-- Rest of the XML data -->' +
'</text>' +
'</revision>' +
'</page>' +
'<page>' +
'<title>either</title>' +
'<ns>0</ns>' +
'<id>49363</id>' +
'<revision>' +
'<id>69251290</id>' +
'<parentid>69244329</parentid>' +
'<timestamp>2022-09-13T16:08:49Z</timestamp>' +
'<contributor>' +
'<username>Glades12</username>' +
'<id>3496740</id>' +
'</contributor>' +
'<comment>/* Translations */Correct translation</comment>' +
'<model>wikitext</model>' +
'<format>text/x-wiki</format>' +
'<text bytes="12527" xml:space="preserve">' +
'<!-- Rest of the XML data -->' +
'</text>' +
'</revision>' +
'</page>' +
'</xml>'}
], {STRING line});

OUTPUT(xmldata);

// Define the RECORD structure for the transformation
rform := 
RECORD
STRING title:=XMLTEXT('title');
END;

ans := 
PARSE(xmlData,line,rform,XML('xml/page'));

// Output the result dataset containing only the word

OUTPUT(ans);
STD.Str.Find( xmlData[1].line, 'amaze', 1 );
STD.Str.Find( xmlData[1].line, 'either', 1 );
STD.Str.Find( xmlData[1].line, '<title>', 1 );
STD.Str.Find( xmlData[1].line, '<title>', 2 );





 
