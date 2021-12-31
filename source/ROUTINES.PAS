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

function FileExists(const AFileName: String): Boolean;
function ReplaceFileExt(const AFileName, AExtension: String): String;

implementation

uses
  Consts;

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

function FileExists(const AFileName: String): Boolean;
var
  LFile: File of Byte;

begin
{$I-}
  Assign(LFile, AFileName);
  Reset(LFile);
  Close(LFile);
{$I+}

  FileExists := IOResult = 0;
end;

function ReplaceFileExt(const AFileName, AExtension: String): String;
const
  cFullStop = '.';

var
  I: Byte;

begin
  for I := Length(AFileName) downto 1 do
  begin
    if AFileName[I] = cFullStop then
    begin
      Break;
    end;
  end;

  if (I = 1) and (AFileName[I] <> cFullStop) then
  begin
    ReplaceFileExt := AFileName;
  end else
  begin
    ReplaceFileExt := Copy(AFileName, 1, I) + AExtension;
  end;
end;

end.
