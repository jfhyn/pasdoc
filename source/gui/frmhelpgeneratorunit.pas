{
  Original version 2004-2005 Richard B. Winston, U.S. Geological Survey (USGS)
  Modifications copyright 2005 Michalis Kamburelis
  Additional modifications by Richard B. Winston, April 26, 2005.

  This file is part of pasdoc_gui.

  pasdoc_gui is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  pasdoc_gui is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with pasdoc_gui; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

{
  @abstract(@name contains the main form of Help Generator.)
  @author(Richard B. Winston <rbwinst@usgs.gov>)
  @author(Michalis Kamburelis)
  @created(2004-11-28)
  @cvs($Date$)
}

unit frmHelpGeneratorUnit;

{$mode DELPHI}

interface

uses
  SysUtils, Classes, LResources, Graphics, Controls, Forms,
  Dialogs, PasDoc_Gen, PasDoc_GenHtml, PasDoc_Base, StdCtrls, PasDoc_Types,
  ComCtrls, ExtCtrls, CheckLst, PasDoc_Languages, Menus,
  Buttons, Spin, PasDoc_GenLatex, Process, PasDoc_Serialize,
  IniFiles, PasDoc_GenHtmlHelp, EditBtn, Utils, LCLType;

type
  EInvalidSpellingLanguage = class(Exception);
  
  // @abstract(TfrmHelpGenerator is the class of the main form of Help
  // Generator.) Its published fields are mainly components that are used to
  // save the project settings.

  { TfrmHelpGenerator }

  TfrmHelpGenerator = class(TForm)
    // Click @name  to select a directory that may
    // have include directories.
    btnBrowseIncludeDirectory: TButton;
    // Click @name to select one or more sorce files for the
    // project.
    btnBrowseSourceFiles: TButton;
   // Click @name  to generate web pages.
    btnGenerateWebPages: TButton;
    cbCheckSpelling: TCheckBox;
    cbVizGraphClasses: TCheckBox;
    cbVizGraphUses: TCheckBox;
    CheckAutoAbstract: TCheckBox;
    CheckUseTipueSearch: TCheckBox;
    // @name controls whether of private, protected, public, published and
    // automated properties, methods, events, and fields will be included in
    // generated output.
    clbMethodVisibility: TCheckListBox;
    clbSorting: TCheckListBox;
    // @name determines what sort of files will be created
    comboGenerateFormat: TComboBox;
    // comboLanguages is used to set the language in which the web page will
    // be written.  Of course, this only affects tha language for the text
    // generated by the program, not the comments about the program.
    comboLanguages: TComboBox;
    comboLatexGraphicsPackage: TComboBox;
    edOutput: TDirectoryEdit;
    edGraphVizUrl: TEdit;
    EditConclusionFileName: TFileNameEdit;
    EditCssFileName: TFileNameEdit;
    EditHtmlBrowserCommand: TEdit;
    EditIntroductionFileName: TFileNameEdit;
    // @name is used to set the name of the project.
    edProjectName: TEdit;
    CssFileNameFileNameEdit1: TFileNameEdit;
    edSpellUrl: TEdit;
    edTitle: TEdit;
    HtmlHelpDocGenerator: THTMLHelpDocGenerator;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelHtmlBrowserCommand1: TLabel;
    lbNavigation: TListBox;
    MemoCommandLog: TMemo;
    memoCommentMarkers: TMemo;
    memoDefines: TMemo;
    // @name holds the complete paths of all the source files
    // in the project.
    memoFiles: TMemo;
    memoFooter: TMemo;
    memoHeader: TMemo;
    memoHyphenatedWords: TMemo;
    // The lines in @name are the paths of the files that
    // may have include files that are part of the project.
    memoIncludeDirectories: TMemo;
    // memoMessages displays compiler warnings.  See also @link(seVerbosity);
    memoMessages: TMemo;
    memoSpellCheckingIgnore: TMemo;
    MenuAbout: TMenuItem;
    MenuContextHelp: TMenuItem;
    NotebookMain: TNotebook;
    pageDefines: TPage;
    pageGenerate: TPage;
    pageGraphViz: TPage;
    pageHeadFoot: TPage;
    pageIncludeDirectories: TPage;
    pageLatexOptions: TPage;
    pageLocations: TPage;
    pageMarkers: TPage;
    pageOptions: TPage;
    pageSourceFiles: TPage;
    pageSpellChecking: TPage;
    pageWebPage: TPage;
    PanelGenerageBottom: TPanel;
    PanelMarkers: TPanel;
    PanelDefinesTop: TPanel;
    PanelGenerateTop: TPanel;
    PanelIncludeDirectoriesBottom: TPanel;
    PanelIncludeDirectoriesTop: TPanel;
    PanelSourceFilesBottom: TPanel;
    PanelSourceFilesTop: TPanel;
    PanelSpellCheckingTop1: TPanel;
    PanelWebPageTop: TPanel;
    // @name is the main workhorse of @classname.  It analyzes the source
    // code and cooperates with @link(HtmlDocGenerator)
    // and @link(TexDocGenerator) to create the output.
    PasDoc1: TPasDoc;
    // @name generates HTML output.
    HtmlDocGenerator: THTMLDocGenerator;
    OpenDialog1: TOpenDialog;
    DocBrowserProcess: TProcess;
    rgCommentMarkers: TRadioGroup;
    rgLineBreakQuality: TRadioGroup;
    // @name controls the severity of the messages that are displayed.
    seVerbosity: TSpinEdit;
    SaveDialog1: TSaveDialog;
    OpenDialog2: TOpenDialog;
    MainMenu1: TMainMenu;
    MenuFile: TMenuItem;
    MenuOpen: TMenuItem;
    MenuSave: TMenuItem;
    MenuExit: TMenuItem;
    MenuNew: TMenuItem;
    // @name generates Latex output.
    TexDocGenerator: TTexDocGenerator;
    MenuHelp: TMenuItem;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuContextHelpClick(Sender: TObject);
    procedure SomethingChanged(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure PasDoc1Warning(const MessageType: TMessageType;
      const AMessage: string; const AVerbosity: Cardinal);
    procedure btnBrowseSourceFilesClick(Sender: TObject);
    procedure cbCheckSpellingChange(Sender: TObject);
    procedure clbMethodVisibilityClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGenerateWebPagesClick(Sender: TObject);
    procedure comboLanguagesChange(Sender: TObject);
    procedure btnBrowseIncludeDirectoryClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure New1Click(Sender: TObject);
    procedure comboGenerateFormatChange(Sender: TObject);
    procedure lbNavigationClick(Sender: TObject);
    procedure rgCommentMarkersClick(Sender: TObject);
  private
    FChanged: boolean;
    FSettingsFileName: string;
    MisspelledWords: TStringList;
    procedure SaveChanges(var Action: TCloseAction);
    procedure SetChanged(const AValue: boolean);
    procedure SetDefaults;
    procedure SetSettingsFileName(const AValue: string);
    procedure UpdateCaption;
    function LanguageIdToString(const LanguageID: TLanguageID): string;
    procedure CheckIfSpellCheckingAvailable;
    procedure FillNavigationListBox;
    procedure SetOutputDirectory(const FileName: string);
  public
    // @name is @true when the user has changed the project settings.
    // Otherwise it is @false.
    property Changed: boolean read FChanged write SetChanged;
    { This is the settings filename (.pds file) that is currently
      opened. You can look at pasdoc_gui as a "program to edit pds files".
      It is '' if current settings are not associated with any filename
      (because user did not opened any pds file, or he chose "New" menu item). }
    property SettingsFileName: string read FSettingsFileName
      write SetSettingsFileName;
    DefaultDirectives: TStringList;
  end;

var
  // @name is the main form of Help Generator
  frmHelpGenerator: TfrmHelpGenerator;

implementation

uses PasDoc_Items, PasDoc_SortSettings, frmAboutUnit, HelpProcessor;

procedure TfrmHelpGenerator.PasDoc1Warning(const MessageType: TMessageType;
  const AMessage: string; const AVerbosity: Cardinal);
const
  MisText = 'Word misspelled "';
var
  MisspelledWord: string;
begin
  memoMessages.Lines.Add(AMessage);
  if Pos(MisText, AMessage) =1 then begin
    MisspelledWord := Copy(AMessage, Length(MisText)+1, MAXINT);
    SetLength(MisspelledWord, Length(MisspelledWord) -1);
    MisspelledWords.Add(MisspelledWord)
  end;
end;

procedure TfrmHelpGenerator.MenuAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmHelpGenerator.SetOutputDirectory(const FileName: string);
begin
  edOutput.Directory := ExtractFileDir(FileName)
    + PathDelim + 'PasDoc';
end;

procedure TfrmHelpGenerator.SomethingChanged(Sender: TObject);
begin
  Changed := true;
  if (memoFiles.Lines.Count > 0) and (edOutput.Directory = '') then begin
    SetOutputDirectory(memoFiles.Lines[0]);
  end;
end;

procedure TfrmHelpGenerator.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    MenuContextHelpClick(ActiveControl);
  end;
end;

procedure TfrmHelpGenerator.btnBrowseSourceFilesClick(Sender: TObject);
var
  Directory: string;
  FileIndex: integer;
  Files: TStringList;
begin
  if OpenDialog1.Execute then
  begin
    Files := TStringList.Create;
    try

      if edOutput.Directory = '' then
      begin
        SetOutputDirectory(OpenDialog1.FileName);
      end;

      Files.Sorted := True;
      Files.Duplicates := dupIgnore;

      Files.AddStrings(memoFiles.Lines);
      Files.AddStrings(OpenDialog1.Files);

      memoFiles.Lines := Files;

      for FileIndex := 0 to OpenDialog1.Files.Count - 1 do
      begin
        Directory := ExtractFileDir(OpenDialog1.Files[FileIndex]);
        if memoIncludeDirectories.Lines.IndexOf(Directory) < 0 then
        begin
          memoIncludeDirectories.Lines.Add(Directory);
        end;
      end;
    finally
      Files.Free;
    end;
  end;
end;

procedure TfrmHelpGenerator.CheckIfSpellCheckingAvailable;
var
  CheckIfSpellCheckingAvailable: boolean;
begin
  if not cbCheckSpelling.Enabled or not cbCheckSpelling.Checked then
  begin
    Exit;
  end;
  
  CheckIfSpellCheckingAvailable := comboGenerateFormat.ItemIndex in [0,1];
  if CheckIfSpellCheckingAvailable then
  begin
    try
      LanguageIdToString(TLanguageID(comboLanguages.ItemIndex));
    except on E: EInvalidSpellingLanguage do
      begin
        CheckIfSpellCheckingAvailable := False;
        Beep;
        MessageDlg(E.Message, Dialogs.mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TfrmHelpGenerator.FillNavigationListBox;
var
  Index: integer;
  page: TPage;
begin
  { Under GTK interface, lbNavigation.OnClick event may occur
    when we change lbNavigation.Items. Our lbNavigationClick
    is not ready to handle this, so we turn him off. }
  lbNavigation.OnClick := nil;
  try
    lbNavigation.Items.Clear;
    for Index := 0 to NotebookMain.PageCount -1 do
    begin
      page := NotebookMain.CustomPage(Index) as TPage;
      if page.Tag = 1 then begin
        lbNavigation.Items.AddObject(page.Caption, page);
      end;
    end;
  finally
    lbNavigation.OnClick := lbNavigationClick;
  end;
end;

procedure TfrmHelpGenerator.cbCheckSpellingChange(Sender: TObject);
begin
  Changed := True;
  if cbCheckSpelling.Checked then
  begin
    CheckIfSpellCheckingAvailable;
  end;
end;

procedure TfrmHelpGenerator.clbMethodVisibilityClick(Sender: TObject);
var
  Options: TVisibilities;
begin
  Options := [];
  if clbMethodVisibility.Checked[0] then
  begin
    Include(Options, viPublished);
  end;
  if clbMethodVisibility.Checked[1] then
  begin
    Include(Options, viPublic);
  end;
  if clbMethodVisibility.Checked[2] then
  begin
    Include(Options, viProtected);
  end;
  if clbMethodVisibility.Checked[3] then
  begin
    Include(Options, viPrivate);
  end;
  if clbMethodVisibility.Checked[4] then
  begin
    Include(Options, viAutomated);
  end;

  if PasDoc1.ShowVisibilities <> Options then
  begin
    Changed := True;
    PasDoc1.ShowVisibilities := Options;
  end;
end;

procedure TfrmHelpGenerator.SetDefaults;
var
  SortIndex: TSortSetting;
begin
  clbMethodVisibility.Checked[0] := True;
  clbMethodVisibility.Checked[1] := True;
  clbMethodVisibility.Checked[2] := False;
  clbMethodVisibility.Checked[3] := False;
  clbMethodVisibility.Checked[4] := False;
  clbMethodVisibilityClick(nil);

  comboLanguages.ItemIndex := Ord(lgEnglish);
  comboLanguagesChange(nil);
  
  comboGenerateFormat.ItemIndex := 0;
  comboGenerateFormatChange(nil);

  edProjectName.Text := '';
  edOutput.Directory := '';
  seVerbosity.Value := 2;
  comboGenerateFormat.ItemIndex := 0;
  memoFiles.Clear;
  memoIncludeDirectories.Clear;
  memoMessages.Clear;

  memoDefines.Lines.Assign(DefaultDirectives);

  EditCssFileName.FileName := '';
  EditIntroductionFileName.FileName := '';
  EditConclusionFileName.FileName := '';
  CheckAutoAbstract.Checked := false;
  CheckUseTipueSearch.Checked := false;
  
  for SortIndex := Low(TSortSetting) to High(TSortSetting) do
    clbSorting.Checked[Ord(SortIndex)] := false;

  Changed := False;
end;

procedure TfrmHelpGenerator.UpdateCaption;
var
  NewCaption: string;
begin
  { Caption value follows GNOME HIG 2.0 standard }
  NewCaption := '';
  if Changed then NewCaption += '*';
  if SettingsFileName = '' then
   NewCaption += 'Unsaved PasDoc settings' else
   NewCaption += ExtractFileName(SettingsFileName);
  NewCaption += ' - PasDoc GUI';
  Caption := NewCaption;
end;

function TfrmHelpGenerator.LanguageIdToString(const LanguageID: TLanguageID
  ): string;
begin
  try
    result := 'en';
    case LanguageID of
      lgBosnian: result := 'bs';
      lgBrasilian: result := 'pt';  // Portuguese used for brazilian.
      lgCatalan: result := 'ca';
      lgChinese_950: raise EInvalidSpellingLanguage.Create(
        'Sorry, that language is not supported for spell checking');
      lgDanish: result := 'da';
      lgDutch: result := 'nl';
      lgEnglish: result := 'en';
      lgFrench: result := 'fr';
      lgGerman: result := 'de';
      lgIndonesian: result := 'id';
      lgItalian: result := 'it';
      lgJavanese: result := 'jv';
      lgPolish_CP1250: result := 'pl';
      lgPolish_ISO_8859_2: result := 'pl';
      lgRussian_1251: result := 'ru';
      lgRussian_866: result := 'ru';
      lgRussian_koi8: result := 'ru';
      lgSlovak: result := 'sk';
      lgSpanish: result := 'es';
      lgSwedish: result := 'sv';
      lgHungarian_1250: result := 'hu';
    else raise EInvalidSpellingLanguage.Create(
        'Sorry, that language is not supported for spell checking');
    end;
  except on EInvalidSpellingLanguage do
    begin
      cbCheckSpelling.Checked := False;
      raise;
    end;
  end;
end;

procedure TfrmHelpGenerator.SetChanged(const AValue: boolean);
begin
  if FChanged = AValue then Exit;
  FChanged := AValue;
  UpdateCaption;
end;

procedure TfrmHelpGenerator.SetSettingsFileName(const AValue: string);
begin
  FSettingsFileName := AValue;
  UpdateCaption;
end;

procedure TfrmHelpGenerator.FormCreate(Sender: TObject);
var
  LanguageIndex: TLanguageID;
  Index: integer;
begin
  MisspelledWords:= TStringList.Create;
  MisspelledWords.Sorted := True;
  MisspelledWords.Duplicates := dupIgnore;
  EditHtmlBrowserCommand.Text :=
    {$ifdef WIN32} 'explorer %s' {$else} 'sh -c "$BROWSER %s"' {$endif};

  comboLanguages.Items.Capacity :=
    Ord(High(TLanguageID)) - Ord(Low(TLanguageID)) + 1;
  for LanguageIndex := Low(TLanguageID) to High(TLanguageID) do
  begin
    comboLanguages.Items.Add(LANGUAGE_ARRAY[LanguageIndex].Name);
  end;

  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;

  DefaultDirectives := TStringList.Create;
  
  { Original HelpGenerator did here
    DefaultDirectives.Assign(memoDefines.Lines)
    I like this solution, but unfortunately current Lazarus seems
    to sometimes "lose" value of TMemo.Lines...
    So I'm setting these values at runtime. }
    
  {$IFDEF FPC}
  DefaultDirectives.Append('FPC');
  {$ENDIF}
  {$IFDEF UNIX}
  DefaultDirectives.Append('UNIX');
  {$ENDIF}
  {$IFDEF LINUX}
  DefaultDirectives.Append('LINUX');
  {$ENDIF}
  {$IFDEF DEBUG}
  DefaultDirectives.Append('DEBUG');
  {$ENDIF}

  {$IFDEF VER130}
  DefaultDirectives.Append('VER130');
  {$ENDIF}
  {$IFDEF VER140}
  DefaultDirectives.Append('VER140');
  {$ENDIF}
  {$IFDEF VER150}
  DefaultDirectives.Append('VER150');
  {$ENDIF}
  {$IFDEF VER160}
  DefaultDirectives.Append('VER160');
  {$ENDIF}
  {$IFDEF VER170}
  DefaultDirectives.Append('VER170');
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  DefaultDirectives.Append('MSWINDOWS');
  {$ENDIF}
  {$IFDEF WIN32}
  DefaultDirectives.Append('WIN32');
  {$ENDIF}
  {$IFDEF CPU386}
  DefaultDirectives.Append('CPU386');
  {$ENDIF}
  {$IFDEF CONDITIONALEXPRESSIONS}
  DefaultDirectives.Append('CONDITIONALEXPRESSIONS');
  {$ENDIF}

  SetDefaults;
  
  { It's too easy to change it at design-time, so we set it at runtime. }
  NotebookMain.PageIndex := 0;
  Application.ProcessMessages;

  {$IFDEF WIN32}
  // Deal with bug in display of TSpinEdit in Win32.
  seVerbosity.Constraints.MinWidth := 60;
  seVerbosity.Width := seVerbosity.Constraints.MinWidth;
  {$ENDIF}
  
  { Workaround for Lazarus bug 0000713,
    [http://www.lazarus.freepascal.org/mantis/view.php?id=713]:
    we set menu shortcuts at runtime.
    (the bug is only for Win32, but we must do this workaround for every
    target). }
  MenuOpen.ShortCut := ShortCut(VK_O, [ssCtrl]);
  MenuSave.ShortCut := ShortCut(VK_S, [ssCtrl]);

  // A Tag of 1 means the page should be visible.
  for Index := NotebookMain.PageCount -1 downto 0 do
  begin
    NotebookMain.CustomPage(Index).Tag := 1;
  end;

  comboGenerateFormatChange(nil);
  
  FillNavigationListBox;
  Changed := False;
end;

procedure TfrmHelpGenerator.btnGenerateWebPagesClick(Sender: TObject);
var
  Files: TStringList;
  index: integer;
  SortIndex: TSortSetting;
const
  VizGraphImageExtension = 'png';
begin
  if edOutput.Directory = '' then
  begin
    Beep;
    MessageDlg('You need to specify the output directory on the "Locations" tab.',
      Dialogs.mtWarning, [mbOK], 0);
    Exit;
  end;
  Screen.Cursor := crHourGlass;
  try
    memoMessages.Clear;
    
    case comboGenerateFormat.ItemIndex of
      0: PasDoc1.Generator := HtmlDocGenerator;
      1: PasDoc1.Generator := HtmlHelpDocGenerator;
      2, 3:
         begin
           PasDoc1.Generator := TexDocGenerator;
           TexDocGenerator.Latex2rtf := (comboGenerateFormat.ItemIndex = 3);

           TexDocGenerator.LatexHead.Clear;
           if rgLineBreakQuality.ItemIndex = 1 then
           begin
             TexDocGenerator.LatexHead.Add('\sloppy');
           end;
           if memoHyphenatedWords.Lines.Count > 0 then
           begin
             TexDocGenerator.LatexHead.Add('\hyphenation{');
             for Index := 0 to memoHyphenatedWords.Lines.Count -1 do
             begin
               TexDocGenerator.LatexHead.Add(memoHyphenatedWords.Lines[Index]);
             end;
             TexDocGenerator.LatexHead.Add('}');
           end;
           
          case comboLatexGraphicsPackage.ItemIndex of
            0: // none
              begin
                // do nothing
              end;
            1: // PDF
              begin
                TexDocGenerator.LatexHead.Add('\usepackage[pdftex]{graphicx}');
              end;
            2: // DVI
              begin
                TexDocGenerator.LatexHead.Add('\usepackage[dvips]{graphicx}');
              end;
          else Assert(False);
          end;

           
         end;
    else
      Assert(False);
    end;
    
    PasDoc1.Generator.Language := TLanguageID(comboLanguages.ItemIndex);

    if PasDoc1.Generator is TGenericHTMLDocGenerator then
    begin
      TGenericHTMLDocGenerator(PasDoc1.Generator).Header := memoHeader.Lines.Text;
      TGenericHTMLDocGenerator(PasDoc1.Generator).Footer := memoFooter.Lines.Text;
      
      if EditCssFileName.FileName <> '' then
        TGenericHTMLDocGenerator(PasDoc1.Generator).CSS :=
          FileToString(EditCssFileName.FileName) else
        TGenericHTMLDocGenerator(PasDoc1.Generator).CSS := DefaultPasDocCss;
        
      TGenericHTMLDocGenerator(PasDoc1.Generator).UseTipueSearch :=
        CheckUseTipueSearch.Checked;
      TGenericHTMLDocGenerator(PasDoc1.Generator).AspellLanguage := LanguageIdToString(TLanguageID(comboLanguages.ItemIndex));
      TGenericHTMLDocGenerator(PasDoc1.Generator).CheckSpelling := cbCheckSpelling.Checked;
      if cbCheckSpelling.Checked then
      begin
        TGenericHTMLDocGenerator(PasDoc1.Generator).SpellCheckIgnoreWords.Assign(memoSpellCheckingIgnore.Lines);
      end;
    end;

    // Create the output directory if it does not exist.
    if not DirectoryExists(edOutput.Directory) then
    begin
      CreateDir(edOutput.Directory)
    end;
    PasDoc1.Generator.DestinationDirectory := edOutput.Directory;
    
    PasDoc1.Generator.AutoAbstract := CheckAutoAbstract.Checked;
    
    PasDoc1.ProjectName := edProjectName.Text;
    PasDoc1.IntroductionFileName := EditIntroductionFileName.Text;
    PasDoc1.ConclusionFileName := EditConclusionFileName.Text;

    Files := TStringList.Create;
    try
      Files.AddStrings(memoFiles.Lines);
      PasDoc1.SourceFileNames.Clear;
      PasDoc1.AddSourceFileNames(Files);

      Files.Clear;
      Files.AddStrings(memoIncludeDirectories.Lines);
      PasDoc1.IncludeDirectories.Assign(Files);

      Files.Clear;
      Files.AddStrings(memoDefines.Lines);
      PasDoc1.Directives.Assign(Files);
    finally
      Files.Free;
    end;
    PasDoc1.Verbosity := Round(seVerbosity.Value);
    
    case rgCommentMarkers.ItemIndex of
      0:
        begin
          PasDoc1.CommentMarkers.Clear;
          PasDoc1.MarkerOptional := True;
        end;
      1:
        begin
          PasDoc1.MarkerOptional := True;
          PasDoc1.CommentMarkers.Assign(memoCommentMarkers.Lines);
        end;
      2:
        begin
          PasDoc1.MarkerOptional := False;
          PasDoc1.CommentMarkers.Assign(memoCommentMarkers.Lines);
        end;
    else
      Assert(False);
    end;
    
    if edTitle.Text = '' then begin
      PasDoc1.Title := edProjectName.Text;
    end
    else begin
      PasDoc1.Title := edTitle.Text;
    end;
    
    if cbVizGraphClasses.Checked then begin
      PasDoc1.Generator.OutputGraphVizClassHierarchy := True;
      PasDoc1.Generator.LinkGraphVizClasses := VizGraphImageExtension;
    end
    else begin
      PasDoc1.Generator.OutputGraphVizClassHierarchy := False;
      PasDoc1.Generator.LinkGraphVizClasses := '';
    end;
    
    if cbVizGraphUses.Checked then begin
      PasDoc1.Generator.OutputGraphVizUses := True;
      PasDoc1.Generator.LinkGraphVizUses := VizGraphImageExtension;
    end
    else begin
      PasDoc1.Generator.OutputGraphVizUses := False;
      PasDoc1.Generator.LinkGraphVizUses := '';
    end;
    
    Assert(Ord(High(TSortSetting)) = clbSorting.Items.Count -1);
    PasDoc1.SortSettings := [];
    for SortIndex := Low(TSortSetting) to High(TSortSetting) do
    begin
      if clbSorting.Checked[Ord(SortIndex)] then begin
        PasDoc1.SortSettings := PasDoc1.SortSettings + [SortIndex];
      end;
    end;
    
    MisspelledWords.Clear;
    PasDoc1.Execute;
    
    if MisspelledWords.Count > 0 then
    begin
      memoMessages.Lines.Add('');
      memoMessages.Lines.Add('Misspelled Words');
      memoMessages.Lines.AddStrings(MisspelledWords)
    end;

    if cbVizGraphUses.Checked or cbVizGraphClasses.Checked then begin
      // To do: actually start dot here.
      MessageDlg('You will have to run the GraphViz "dot" program to generate '
        + 'the images used in your documentation.', Dialogs.mtInformation,
        [mbOK], 0);
    end;

    case comboGenerateFormat.ItemIndex of
      0, 1:
        begin
          DocBrowserProcess.CommandLine := Format(EditHtmlBrowserCommand.Text,
            [ HtmlDocGenerator.DestinationDirectory + 'index.html' ]);
          DocBrowserProcess.Execute;
          MemoCommandLog.Lines.Append('Executed: ' + DocBrowserProcess.CommandLine);
          NotebookMain.PageIndex := pageWebPage.PageIndex;
        end;
      2, 3:
        begin
        end;
    else
      Assert(False);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmHelpGenerator.comboLanguagesChange(Sender: TObject);
begin
  CheckIfSpellCheckingAvailable;
  Changed := True;
end;

procedure TfrmHelpGenerator.btnBrowseIncludeDirectoryClick(Sender: TObject);
var
  directory: string;
begin
  if memoIncludeDirectories.Lines.Count > 0 then
  begin
    directory := memoIncludeDirectories.Lines[
      memoIncludeDirectories.Lines.Count - 1];
  end
  else
  begin
    directory := '';
  end;

  if SelectDirectory('Select directory to include', '', directory)
    then
  begin
    if memoIncludeDirectories.Lines.IndexOf(directory) < 0 then
    begin
      memoIncludeDirectories.Lines.Add(directory);
    end
    else
    begin
      MessageDlg('The directory you selected, (' + directory
        + ') is already included.', Dialogs.mtInformation, [mbOK], 0);
    end;
  end;
end;

procedure TfrmHelpGenerator.btnOpenClick(Sender: TObject);
var
  Ini: TIniFile;

  procedure ReadStrings(const Section: string; S: TStrings);
  var i: Integer;
  begin
    S.Clear;
    for i := 0 to Ini.ReadInteger(Section, 'Count', 0) - 1 do
      S.Append(Ini.ReadString(Section, 'Item_' + IntToStr(i), ''));
  end;

var i: Integer;
begin
  // TODO: The following is needed and should work but does not.
  {if Changed then
  if (MessageDlg('Do you want to save your current file first?',
    Dialogs.mtInformation, [mbYes, mbNo], 0) = mrYes) then
  begin
    Save1Click(Sender);
  end; }
  if OpenDialog2.Execute then
  begin
    SettingsFileName := OpenDialog2.FileName;
    SaveDialog1.FileName := SettingsFileName;

    Ini := TIniFile.Create(SettingsFileName);
    try
      { Default values for ReadXxx() methods here are not so important,
        don't even try to set them right.
        *Good* default values are set in SetDefaults method of this class.
        Here we can assume that values are always present in ini file.

        Well, OK, in case user will modify settings file by hand we should
        set here some sensible default values... also in case we will add
        in the future some new values to this file...
        so actually we should set here sensible "default values".
        We can think of them as "good default values for user opening a settings
        file written by older version of pasdoc_gui program".
        They need not necessarily be equal to default values set by
        SetDefaults method, and this is very good, as it may give us
        additional possibilities. }

      comboLanguages.ItemIndex := Ini.ReadInteger('Main', 'Language', 0);
      comboLanguagesChange(nil);

      edOutput.Directory := Ini.ReadString('Main', 'OutputDir', '');

      comboGenerateFormat.ItemIndex := Ini.ReadInteger('Main', 'GenerateFormat', 0);
      comboGenerateFormatChange(nil);

      edProjectName.Text := Ini.ReadString('Main', 'ProjectName', '');
      seVerbosity.Value := Ini.ReadInteger('Main', 'Verbosity', 0);

      Assert(Ord(High(TVisibility)) = clbMethodVisibility.Items.Count -1);
      for i := Ord(Low(TVisibility)) to Ord(High(TVisibility)) do
        clbMethodVisibility.Checked[i] := Ini.ReadBool(
          'Main', 'ClassMembers_' + IntToStr(i), true);
      clbMethodVisibilityClick(nil);
      
      Assert(Ord(High(TSortSetting)) = clbSorting.Items.Count -1);
      for i := Ord(Low(TSortSetting)) to Ord(High(TSortSetting)) do
      begin
        clbSorting.Checked[i] := Ini.ReadBool(
          'Main', 'Sorting_' + IntToStr(i), True);
      end;

      ReadStrings('Defines', memoDefines.Lines);
      ReadStrings('Header', memoHeader.Lines);
      ReadStrings('Footer', memoFooter.Lines);
      ReadStrings('IncludeDirectories', memoIncludeDirectories.Lines);
      ReadStrings('Files', memoFiles.Lines);
      
      EditCssFileName.FileName := Ini.ReadString('Main', 'CssFileName', '');
      EditIntroductionFileName.FileName :=
        Ini.ReadString('Main', 'IntroductionFileName', '');
      EditConclusionFileName.FileName :=
        Ini.ReadString('Main', 'ConclusionFileName', '');
      CheckAutoAbstract.Checked := Ini.ReadBool('Main', 'AutoAbstract', false);
      CheckUseTipueSearch.Checked := Ini.ReadBool('Main', 'UseTipueSearch', false);
      rgLineBreakQuality.ItemIndex := Ini.ReadInteger('Main', 'LineBreakQuality', 0);
      ReadStrings('HyphenatedWords', memoHyphenatedWords.Lines);
      rgCommentMarkers.ItemIndex := Ini.ReadInteger('Main', 'SpecialMarkerTreatment', 1);
      ReadStrings('SpecialMarkers', memoCommentMarkers.Lines);
      edTitle.Text := Ini.ReadString('Main', 'Title', '');
      cbVizGraphClasses.Checked := Ini.ReadBool('Main', 'VizGraphClasses', false);
      cbVizGraphUses.Checked := Ini.ReadBool('Main', 'VizGraphUses', false);
      
      cbCheckSpelling.Checked := Ini.ReadBool('Main', 'CheckSpelling', false);
      comboLatexGraphicsPackage.ItemIndex := Ini.ReadInteger('Main', 'LatexGraphicsPackage', 0);

      ReadStrings('IgnoreWords', memoSpellCheckingIgnore.Lines);
    finally Ini.Free end;

    Changed := False;
  end;
end;

procedure TfrmHelpGenerator.Save1Click(Sender: TObject);
var
  Ini: TIniFile;

  procedure WriteStrings(const Section: string; S: TStrings);
  var i: Integer;
  begin
    { It's not really necessary for correctness but it's nice to protect
      user privacy by removing trash data from file (in case previous
      value of S had larger Count). }
    Ini.EraseSection(Section);

    Ini.WriteInteger(Section, 'Count', S.Count);
    for i := 0 to S.Count - 1 do
      Ini.WriteString(Section, 'Item_' + IntToStr(i), S[i]);
  end;

var i: Integer;
begin
  if SaveDialog1.Execute then
  begin
    SettingsFileName := SaveDialog1.FileName;

    Ini := TIniFile.Create(SettingsFileName);
    try
      Ini.WriteInteger('Main', 'Language', comboLanguages.ItemIndex);
      Ini.WriteString('Main', 'OutputDir', edOutput.Directory);
      Ini.WriteInteger('Main', 'GenerateFormat', comboGenerateFormat.ItemIndex);
      Ini.WriteString('Main', 'ProjectName', edProjectName.Text);
      Ini.WriteInteger('Main', 'Verbosity', Round(seVerbosity.Value));

      for i := Ord(Low(TVisibility)) to Ord(High(TVisibility)) do
        Ini.WriteBool('Main', 'ClassMembers_' + IntToStr(i),
          clbMethodVisibility.Checked[i]);

      for i := Ord(Low(TSortSetting)) to Ord(High(TSortSetting)) do
      begin
        Ini.WriteBool('Main', 'Sorting_' + IntToStr(i),
          clbSorting.Checked[i]);
      end;

      WriteStrings('Defines', memoDefines.Lines);
      WriteStrings('Header', memoHeader.Lines);
      WriteStrings('Footer', memoFooter.Lines);
      WriteStrings('IncludeDirectories', memoIncludeDirectories.Lines);
      WriteStrings('Files', memoFiles.Lines);

      Ini.WriteString('Main', 'CssFileName', EditCssFileName.FileName);
      Ini.WriteString('Main', 'IntroductionFileName',
        EditIntroductionFileName.FileName);
      Ini.WriteString('Main', 'ConclusionFileName',
        EditConclusionFileName.FileName);
      Ini.WriteBool('Main', 'AutoAbstract', CheckAutoAbstract.Checked);
      Ini.WriteBool('Main', 'UseTipueSearch', CheckUseTipueSearch.Checked);
      Ini.WriteInteger('Main', 'LineBreakQuality', rgLineBreakQuality.ItemIndex);
      WriteStrings('HyphenatedWords', memoHyphenatedWords.Lines);
      Ini.WriteInteger('Main', 'SpecialMarkerTreatment', rgCommentMarkers.ItemIndex);
      WriteStrings('SpecialMarkers', memoCommentMarkers.Lines);
      Ini.WriteString('Main', 'Title', edTitle.Text);

      Ini.WriteBool('Main', 'VizGraphClasses', cbVizGraphClasses.Checked);
      Ini.WriteBool('Main', 'VizGraphUses', cbVizGraphUses.Checked);

      Ini.WriteBool('Main', 'CheckSpelling', cbCheckSpelling.Checked);
      Ini.WriteInteger('Main', 'LatexGraphicsPackage', comboLatexGraphicsPackage.ItemIndex);
      WriteStrings('IgnoreWords', memoSpellCheckingIgnore.Lines);

      Ini.UpdateFile;
    finally Ini.Free end;

    Changed := False;
  end;
end;

procedure TfrmHelpGenerator.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmHelpGenerator.SaveChanges(var Action: TCloseAction);
var
  MessageResult: integer;
begin
  if Changed then
  begin
    MessageResult := MessageDlg(
      'Do you want to save the settings for this project?',
      Dialogs.mtInformation, [mbYes, mbNo, mbCancel], 0);
    case MessageResult of
      mrYes:
        begin
          Save1Click(nil);
        end;
      mrNo:
        begin
          // do nothing.
        end;
    else
      begin
        Action := caNone;
      end;
    end;
  end;
end;

procedure TfrmHelpGenerator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveChanges(Action);
  DefaultDirectives.Free;
  MisspelledWords.Free;
end;

procedure TfrmHelpGenerator.New1Click(Sender: TObject);
var
  Action: TCloseAction;
begin
  Action := caHide;
  if Changed then
  begin
    SaveChanges(Action);
    if Action = caNone then
      Exit;
  end;

  SetDefaults;

  SettingsFileName := '';

  Changed := False;
end;

procedure TfrmHelpGenerator.comboGenerateFormatChange(Sender: TObject);

  procedure SetColorFromEnabled(Edit: TEdit);
  { With WinAPI interface, this is useful to give user indication of 
    Edit.Enabled state. Other WinAPI programs also do this.
    With other widgetsets, like GTK, this is not needed, Lazarus + GTK
    already handle such things (e.g. edit boxes have automatically
    slightly dimmed background when they are disabled). }
  begin
    {$ifdef WIN32}
    if Edit.Enabled then begin
      edProjectName.Color := clWindow else
      edProjectName.Color := clBtnFace;
    {$endif}
  end;

begin
  CheckUseTipueSearch.Enabled := comboGenerateFormat.ItemIndex = 0;
  PageHeadFoot.Tag := Ord(comboGenerateFormat.ItemIndex in [0,1]);
  PageLatexOptions.Tag := Ord(comboGenerateFormat.ItemIndex in [2,3]);
  
  edProjectName.Enabled := comboGenerateFormat.ItemIndex <> 0;
  SetColorFromEnabled(edProjectName);
  
  EditCssFileName.Enabled := comboGenerateFormat.ItemIndex in [0,1];
  SetColorFromEnabled(EditCssFileName);
  
  PageWebPage.Tag := Ord(comboGenerateFormat.ItemIndex in [0,1]);
  comboLatexGraphicsPackage.Enabled := comboGenerateFormat.ItemIndex in [2,3];
  FillNavigationListBox;
  Changed := true;
end;

procedure TfrmHelpGenerator.lbNavigationClick(Sender: TObject);
var
  Page: TPage;
begin
  if lbNavigation.ItemIndex = -1 then Exit;
  
  Page := lbNavigation.Items.Objects[lbNavigation.ItemIndex] as TPage;
    
  NotebookMain.PageIndex := Page.PageIndex;
end;

procedure TfrmHelpGenerator.MenuContextHelpClick(Sender: TObject);
var
  Page: TPage;
  HelpControl: TControl;
  URL: string;
begin
  HelpControl := nil;
  if (Sender is TMenuItem) or (Sender = lbNavigation) then
  begin
    HelpControl := NotebookMain.ActivePageComponent;
    GetHelpControl(HelpControl, HelpControl);
  end
  else if (Sender is TControl) then
  begin
    GetHelpControl(TControl(Sender), HelpControl);
  end;
  
  if HelpControl <> nil then
  begin
    Assert(HelpControl.HelpType = htKeyword);
    URL := 'http://pasdoc.sipsolutions.net/' +
      HelpControl.HelpKeyword;

    DocBrowserProcess.CommandLine :=
      Format(EditHtmlBrowserCommand.Text, [URL]);
    DocBrowserProcess.Execute;
  end;
end;

procedure TfrmHelpGenerator.rgCommentMarkersClick(Sender: TObject);
begin
  Changed := True;
  memoCommentMarkers.Enabled := (rgCommentMarkers.ItemIndex >= 1);
  if memoCommentMarkers.Enabled then begin
    memoCommentMarkers.Color := clWindow;
  end
  else begin
    memoCommentMarkers.Color := clBtnFace;
  end;
end;

initialization
  {$I frmhelpgeneratorunit.lrs}
end.
