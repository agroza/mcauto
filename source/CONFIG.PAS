{ --------------------------------------------------------------------------- }
{ - MORSE Code Automation - Configuration (config.pas)                      - }
{ - Copyright (C) 1998-2021 Alexandru Groza of Microprogramming TECHNIQUES  - }
{ - All rights reserved.                                                    - }
{ --------------------------------------------------------------------------- }
{ - License: GNU General Public License v3.0                                - }
{ --------------------------------------------------------------------------- }

unit Config;

interface

uses
  Types;

var
  GConfig: TConfig;

function ConfigLoad: Boolean;
function ConfigSave: Boolean;

procedure ConfigDefault;

implementation

uses
  Consts,
  Dos,
  Routines;

type
  TFileSignature = array[0..7] of Char;

  TConfig = record
    Speed: Word;
    DotFrequency: Word;
    DashFrequency: Word;
  end;

const
  kFileSignature: TFileSignature = 'AG86.BIN';

{ public declarations }

function ConfigLoad: Boolean;
var
  LFile: File;
  LFileName: String;
  LFileSignature: TFileSignature;

begin
  ConfigLoad := False;

  LFileName := ReplaceFileExt(FExpand(ParamStr(0)), fmBINFiles);

  if not FileExists(LFileName) then
    Exit;

  FillChar(GConfig, SizeOf(GConfig), $00);

{$I-}
  Assign(LFile, LFileName);
  FileMode := fmReadOnly;
  Reset(LFile, 1);

  BlockRead(LFile, LFileSignature, SizeOf(kFileSignature));
  BlockRead(LFile, GConfig, SizeOf(GConfig));

  Close(LFile);
{$I+}

  if (IOResult <> 0) or (LFileSignature <> kFileSignature) then
    Exit;

  ConfigLoad := True;
end;

function ConfigSave: Boolean;
var
  LFile: File;
  LFileName: String;

begin
  ConfigSave := False;

  LFileName := ReplaceFileExt(FExpand(ParamStr(0)), fmBINFiles);

{$I-}
  Assign(LFile, LFileName);
  Rewrite(LFile, 1);

  BlockWrite(LFile, kFileSignature, SizeOf(kFileSignature));
  BlockWrite(LFile, GConfig, SizeOf(GConfig));

  Close(LFile);
{$I+}

  if IOResult <> 0 then
    Exit;

  ConfigSave := True;
end;

procedure ConfigDefault;
begin
  GConfig.DotFrequency := kDefaultDotFrequency;
  GConfig.DashFrequency := kDefaultDashFrequency;

  GConfig.DotTiming := kDefaultDotTiming;
end;

end.
