{ --------------------------------------------------------------------------- }
{ - MORSE Code Automation - Types (types.pas)                               - }
{ - Copyright (C) 1998-2021 Alexandru Groza of Microprogramming TECHNIQUES  - }
{ - All rights reserved.                                                    - }
{ --------------------------------------------------------------------------- }
{ - License: GNU General Public License v3.0                                - }
{ --------------------------------------------------------------------------- }

unit Types;

interface

type
  TConfig = record
    DotFrequency: Word;
    DashFrequency: Word;

    DotTiming: Word;
  end;

  TTiming = record
    Dot: Word;
    Dash: Word;
    SymbolSpace: Word;
    LetterSpace: Word;
    WordSpace: Word;
  end;

  TFrequency = record
    Dot: Word;
    Dash: Word;
  end;

  TStatus = (
    stListening,
    stEncoding,
    stDecoding
  );

implementation

end.
