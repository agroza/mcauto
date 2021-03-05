{ --------------------------------------------------------------------------- }
{ - MORSE Code Automation (mcauto.pas)                                      - }
{ - Copyright (C) 1998-2021 Alexandru Groza of Microprogramming TECHNIQUES  - }
{ - All rights reserved.                                                    - }
{ --------------------------------------------------------------------------- }
{ - License: GNU General Public License v3.0                                - }
{ --------------------------------------------------------------------------- }

program mcauto;

uses
  Consts,
  Crt,
  Engine,
  Routines,
  Types,
  Video;

procedure WriteProgramHeader;
begin
  TextColor(clHighlight);
  Writeln(sProgramTitle);

  TextColor(clNormal);
  Writeln(sProgramCopyright);
  Writeln(sProgramAuthor);
  Writeln(sProgramRights);
  Writeln;
end;

procedure UIDraw;
begin
  VideoWriteRegion(1, 1, 80, 1, cSpace, VideoAttribute(clTitleBarFore, clTitleBarBack));
  VideoWriteStringAt(2, 1, sTitleBarText, clTitleBarFore, clTitleBarBack);

  VideoWriteRegion(1, 25, 80, 1, cSpace, VideoAttribute(clStatusBarFore, clStatusBarBack));
  VideoWriteStringAt(2, 25, sStatusBarText, clStatusBarFore, clStatusBarBack);
end;

procedure UIUpdateSpeed(const ASpeed: Word);
begin
  VideoWriteRegion(18, 1, 3, 1, cSpace, VideoAttribute(clTitleBarFore, clTitleBarBack));
  VideoWriteStringAt(18, 1, IntToStr(ASpeed), clTitleBarFore, clTitleBarBack);
end;

procedure UIUpdateDotFrequency(const AValue: Word);
begin
  VideoWriteRegion(32, 1, 3, 1, cSpace, VideoAttribute(clTitleBarFore, clTitleBarBack));
  VideoWriteStringAt(32, 1, IntToStr(AValue), clTitleBarFore, clTitleBarBack);
end;

procedure UIUpdateDashFrequency(const AValue: Word);
begin
  VideoWriteRegion(48, 1, 3, 1, cSpace, VideoAttribute(clTitleBarFore, clTitleBarBack));
  VideoWriteStringAt(48, 1, IntToStr(AValue), clTitleBarFore, clTitleBarBack);
end;

procedure UIUpdateStatus(const AStatus: TStatus);
begin
  VideoWriteRegion(66, 1, 9, 1, cSpace, VideoAttribute(clTitleBarFore, clTitleBarBack));
  VideoWriteStringAt(66, 1, sStatusStrings[AStatus], clTitleBarFore, clTitleBarBack);
end;

function UIShowMsgReadValue(const AMessage: String; const ADefault: Word): Word;
var
  LValue: String;

begin
  TextColor(clHighlight);
  Write(AMessage);

  TextColor(clNormal);
  Readln(LValue);

  UIShowMsgReadValue := StrToIntDef(LValue, ADefault);
end;

procedure UIEncode(const AMessage: String);
begin
  if AMessage <> sEmpty then
  begin
    UIUpdateStatus(stEncoding);

    Encode(AMessage);

    UIUpdateStatus(stListening);

    Writeln;
  end;
end;

procedure UILoop;
var
  LKey: Char;
  LInput: String;
  LRepeat: String;
  LValue: Word;

begin
  LInput := sEmpty;
  LRepeat := sEmpty;

  InitTiming(kDefaultSpeed);
  InitDotFrequency(kDefaultDotFrequency);
  InitDashFrequency(kDefaultDashFrequency);

  UIUpdateSpeed(kDefaultSpeed);
  UIUpdateDotFrequency(kDefaultDotFrequency);
  UIUpdateDashFrequency(kDefaultDashFrequency);
  UIUpdateStatus(stListening);

  while True do
  begin
    LKey := LowCase(ReadKey);

    case LKey of
      kKeyExtended:
        begin
          case ReadKey of
            kKeyF3:
              begin
                Write(LRepeat);

                UIEncode(LRepeat);
              end;

            kKeyF5:
              begin
                LValue := UIShowMsgReadValue(sEnterNewSpeed, kDefaultSpeed);
                InitTiming(LValue);
                UIUpdateSpeed(LValue);
              end;

            kKeyF6:
              begin
                LValue := UIShowMsgReadValue(sEnterNewDotFrequency, kDefaultDotFrequency);
                InitDotFrequency(LValue);
                UIUpdateDotFrequency(LValue);
              end;

            kKeyF7:
              begin
                LValue := UIShowMsgReadValue(sEnterNewDashFrequency, kDefaultDashFrequency);
                InitDashFrequency(LValue);
                UIUpdateDashFrequency(LValue);
              end;

          end;
        end;

      kKeyBackspace:
        begin
          if LInput <> sEmpty then
          begin
            Delete(LInput, Length(LInput), 1);
            VideoWriteCharAt(WhereX, WhereY + 2, cSpace);
            GotoXY(Pred(WhereX), WhereY);
           end;
        end;

      kKeyEnter:
        begin
          UIEncode(LInput);

          LRepeat := LInput;
          LInput := sEmpty;
        end;

      kKeyEscape:
        Break;

      cSpace, '0'..'9', 'a'..'z':
        begin
          LInput := LInput + LKey;
          Write(LKey);
        end;

    end;
  end;
end;

procedure StartProgram;
var
  LSaveY: Byte;
  LVideoRAMData: PVideoRAMData;

begin
  LSaveY := WhereY;

  GetMem(LVideoRAMData, kVGARAMSize);
  VideoSaveScreen(LVideoRAMData);
  VideoClearScreen;
  VideoEnableHighColors;

  Window(Succ(k80x25Left), Succ(Succ(k80x25Top)), Pred(k80x25Width), Pred(Pred(k80x25Height)));

  UIDraw;
  UILoop;

  Window(k80x25Left, k80x25Top, k80x25Width, k80x25Height);

  VideoDisableHighColors;
  VideoRestoreScreen(LVideoRAMData);
  FreeMem(LVideoRAMData, kVGARAMSize);

  GotoXY(k80x25Left, LSaveY);
end;

begin
  WriteProgramHeader;
  StartProgram;
end.
