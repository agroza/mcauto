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
  Config,
  Crt,
  Engine,
  UI,
  Video;

procedure WriteProgramHeader;
begin
  VideoWriteNewln;

  VideoSetBackground(clBlack);

  VideoSetForeground(clHighlight);
  VideoWriteln(sProgramTitle);

  VideoSetForeground(clNormal);
  VideoWriteln(sProgramCopyright);
  VideoWriteln(sProgramAuthor);
  VideoWriteln(sProgramRights);

  VideoWriteNewln;
end;

begin
  WriteProgramHeader;

  if not ConfigLoad then
  begin
    ConfigDefault;
  end;

  UIStart;
end.
