{ --------------------------------------------------------------------------- }
{ - MORSE Code Automation - Engine (engine.pas)                             - }
{ - Copyright (C) 1998-2021 Alexandru Groza of Microprogramming TECHNIQUES  - }
{ - All rights reserved.                                                    - }
{ --------------------------------------------------------------------------- }
{ - License: GNU General Public License v3.0                                - }
{ --------------------------------------------------------------------------- }

unit Engine;

interface

procedure InitDotFrequency(const AValue: Word);
procedure InitDashFrequency(const AValue: Word);

procedure InitTiming(const AValue: Word);

procedure Encode(const AString: String);
procedure Decode(var AString: String);

implementation

uses
  Consts,
  Crt,
  Types;

var
  GTiming: TTiming;
  GFrequency: TFrequency;

{ private declarations }

procedure Play(const ASymbol: Char);
var
  LFrequency: Word;
  LDuration: Word;

begin
  case ASymbol of
    cDot:
      begin
        LFrequency := GFrequency.Dot;
        LDuration := GTiming.Dot;
      end;

    cDash:
      begin
        LFrequency := GFrequency.Dash;
        LDuration := GTiming.Dash;
      end;

  end;

  Sound(LFrequency);
  Delay(LDuration);
  NoSound;

  Delay(GTiming.SymbolSpace);
end;

{ public declarations }

procedure InitDotFrequency(const AValue: Word);
begin
  GFrequency.Dot := AValue;
end;

procedure InitDashFrequency(const AValue: Word);
begin
  GFrequency.Dash := AValue;
end;

procedure InitTiming(const AValue: Word);
begin
  GTiming.Dot := 1200 div AValue;
  GTiming.Dash := 3 * GTiming.Dot;
  GTiming.SymbolSpace := GTiming.Dot;
  GTiming.LetterSpace := 3 * GTiming.Dot;
  GTiming.WordSpace := 7 * GTiming.Dot;
end;

procedure Encode(const AString: String);
var
  I: Byte;
  J: Byte;

begin
  if AString <> sEmpty then
  begin
    for I := 1 to Length(AString) do
    begin
      case AString[I] of
        cSpace:
          begin
            Delay(GTiming.WordSpace);
          end;

        '0'..'9':
          begin
            for J := 1 to Length(kMCNumbers[AString[I]]) do
            begin
              Play(kMCNumbers[AString[I]][J]);
            end;

            Delay(GTiming.LetterSpace);
          end;

        'a'..'z':
          begin
            for J := 1 to Length(kMCLetters[AString[I]]) do
            begin
              Play(kMCLetters[AString[I]][J]);
            end;

            Delay(GTiming.LetterSpace);
          end;

      end;
    end;
  end;
end;

procedure Decode(var AString: String);
begin
  { TODO -oagroza -cImplement : Decode operation based on hardware interface. }
end;

end.
