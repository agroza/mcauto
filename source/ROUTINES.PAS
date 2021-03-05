{ --------------------------------------------------------------------------- }
{ - MORSE Code Automation - Routines (routines.pas)                         - }
{ - Copyright (C) 1998-2021 Alexandru Groza of Microprogramming TECHNIQUES  - }
{ - All rights reserved.                                                    - }
{ --------------------------------------------------------------------------- }
{ - License: GNU General Public License v3.0                                - }
{ --------------------------------------------------------------------------- }

unit Routines;

interface

function StrToIntDef(const AString: String; const ADefault: Longint): Longint;
function IntToStr(const AInteger: Longint): String;
function LowCase(const ACharacter: Char): Char;

implementation

{ public declarations }

function StrToIntDef(const AString: String; const ADefault: Longint): Longint;
var
  LValue: Longint;
  LErrorCode: Integer;

begin
  Val(AString, LValue, LErrorCode);
  if LErrorCode = 0 then
  begin
    StrToIntDef := LValue;
  end else
  begin
    StrToIntDef := ADefault;
  end;
end;

function LowCase(const ACharacter: Char): Char; assembler;
asm
  mov al,ACharacter

  cmp al,'A'
  jb @exit
  cmp al,'Z'
  ja @exit
  add al,20h

@exit:

end;

function IntToStr(const AInteger: Longint): String;
var
  S: String;

begin
  Str(AInteger, S);
  IntToStr := S;
end;

end.
