d := DATASET([{'<library><book isbn="123456789X">' +
  '<author>Bayliss</author><title>A Way Too Far</title></book>' +
  '<book isbn="1234567801">' +
  '<author>Smith</author><title>A Way Too Short</title></book>' +
  '</library>'}],
  {STRING line });


rform := RECORD
  STRING author := XMLTEXT('author');
  STRING title := XMLTEXT('title');
END;


books := PARSE(d,line,rform,XML('library/book'));


OUTPUT(books);
