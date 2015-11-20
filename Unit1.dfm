object Form1: TForm1
  Left = 168
  Top = 176
  Width = 873
  Height = 510
  Caption = 'Form1'
  Color = 16708521
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 88
    Width = 465
    Height = 361
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 24
    Width = 196
    Height = 49
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 512
    Top = 24
    Width = 193
    Height = 49
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1074#1089#1077
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 296
    Top = 24
    Width = 193
    Height = 49
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = Button3Click
  end
  object ListBox1: TListBox
    Left = 512
    Top = 88
    Width = 321
    Height = 361
    ItemHeight = 13
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    Left = 224
    Top = 32
  end
end
