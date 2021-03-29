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
  TextColor(clHighlight);
  Writeln(sProgramTitle);

  TextColor(clNormal);
  Writeln(sProgramCopyright);
  Writeln(sProgramAuthor);
  Writeln(sProgramRights);
  Writeln;
end;

begin
  WriteProgramHeader;

  if not ConfigLoad then
  begin
    ConfigDefault;
  end;

  UIStart;
end.
