{ --------------------------------------------------------------------------- }
{ - MORSE Code Automation - Constants (consts.pas)                          - }
{ - Copyright (C) 1998-2021 Alexandru Groza of Microprogramming TECHNIQUES  - }
{ - All rights reserved.                                                    - }
{ --------------------------------------------------------------------------- }
{ - License: GNU General Public License v3.0                                - }
{ --------------------------------------------------------------------------- }

unit Consts;

interface

uses
  Crt,
  Types;

const
  { program stringtable }
  sEmpty                  = '';

  sProgramTitle           = 'MORSE Code Automation  VER: 0.2 REV: A';
  sProgramCopyright       = 'Copyright (C) 1998-2021 Microprogramming TECHNIQUES';
  sProgramAuthor          = 'Programming/PC Code: Alexandru Groza';
  sProgramRights          = 'All rights reserved.';

  sTitleBarText           = 'MCAUTO ³ SPEED:    wpm ³ DOT:     kHz ³ DASH:     kHz ³ Status:';
  sStatusBarText          = 'ESC - Exit ³ ENTER - Encode ³ F3 - Repeat ³ F5 - Speed ³ F6 - Dot ³ F7 - Dash';

  sEnterNewSpeed          = 'New speed in wpm: ';
  sEnterNewDotFrequency   = 'New dot frequency in kHz: ';
  sEnterNewDashFrequency  = 'New dash frequency in kHz: ';

  sStatusStrings: array[TStatus] of String[9] = (
    'Listening',
    'Encoding',
    'Decoding'
  );

  { character constants }
  cSpace                  = ' ';
  cDot                    = '.';
  cDash                   = '_';

  { keyboard codes }
  kKeyBackspace           = #08;
  kKeyEnter               = #13;
  kKeyEscape              = #27;
  kKeyExtended            = #00;
  kKeyF3                  = #61;
  kKeyF5                  = #63;
  kKeyF6                  = #64;
  kKeyF7                  = #65;

  { MORSE codes for numbers }
  kMCNumbers: array['0'..'9'] of String[5] = (
    '_____', { 0 }
    '.____', { 1 }
    '..___', { 2 }
    '...__', { 3 }
    '...._', { 4 }
    '.....', { 5 }
    '_....', { 6 }
    '__...', { 7 }
    '___..', { 8 }
    '____.'  { 9 }
  );

  { MORSE codes for letters }
  kMCLetters: array['a'..'z'] of String[4] = (
    '._',    { A }
    '_...',  { B }
    '_._.',  { C }
    '_..',   { D }
    '.',     { E }
    '.._.',  { F }
    '__.',   { G }
    '....',  { H }
    '..',    { I }
    '.___',  { J }
    '_._',   { K }
    '._..',  { L }
    '__',    { M }
    '_.',    { N }
    '___',   { O }
    '.__.',  { P }
    '__._',  { Q }
    '._.',   { R }
    '...',   { S }
    '_',     { T }
    '.._',   { U }
    '..._',  { V }
    '.__',   { W }
    '_.._',  { X }
    '_.__',  { Y }
    '__..'   { Z }
  );

  { general program constants }
  kDefaultDotFrequency    = 640;
  kDefaultDashFrequency   = 630;

  kDefaultSpeed           = 20;

  { color constants }
  clNormal                = LightGray;
  clHighlight             = White;

  clTitleBarFore          = White;
  clTitleBarBack          = Red;

  clStatusBarFore         = White;
  clStatusBarBack         = Blue;

implementation

end.
