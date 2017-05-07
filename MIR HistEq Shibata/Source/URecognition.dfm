object FRecognition: TFRecognition
  Left = 202
  Top = 138
  Width = 777
  Height = 524
  Caption = 'Image Recognition'
  Color = clWhite
  Constraints.MinHeight = 524
  Constraints.MinWidth = 636
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    769
    490)
  PixelsPerInch = 96
  TextHeight = 13
  object shpLandmark1: TShape
    Tag = 1
    Left = 216
    Top = 62
    Width = 20
    Height = 20
    Brush.Color = clMaroon
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark2: TShape
    Tag = 2
    Left = 216
    Top = 94
    Width = 20
    Height = 20
    Brush.Color = clGreen
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark3: TShape
    Tag = 3
    Left = 216
    Top = 126
    Width = 20
    Height = 20
    Brush.Color = clOlive
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark4: TShape
    Tag = 4
    Left = 216
    Top = 158
    Width = 20
    Height = 20
    Brush.Color = clNavy
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark5: TShape
    Tag = 5
    Left = 216
    Top = 190
    Width = 20
    Height = 20
    Brush.Color = clPurple
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark6: TShape
    Tag = 6
    Left = 216
    Top = 222
    Width = 20
    Height = 20
    Brush.Color = clRed
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark7: TShape
    Tag = 7
    Left = 216
    Top = 254
    Width = 20
    Height = 20
    Brush.Color = clYellow
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark8: TShape
    Tag = 8
    Left = 216
    Top = 286
    Width = 20
    Height = 20
    Brush.Color = clFuchsia
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark9: TShape
    Tag = 9
    Left = 216
    Top = 318
    Width = 20
    Height = 20
    Brush.Color = clAqua
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object shpLandmark10: TShape
    Tag = 10
    Left = 216
    Top = 350
    Width = 20
    Height = 20
    Brush.Color = clLime
    Pen.Color = 9470064
    Shape = stCircle
    OnMouseUp = shpLandmark1MouseUp
  end
  object lbScanProgres: TLabel
    Left = 288
    Top = 448
    Width = 4
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 930321
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 24
    Top = 16
    Width = 217
    Height = 35
    BevelInner = bvLowered
    Caption = 'Tampilan Landmark'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3681838
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object pnQueryJudul: TPanel
    Left = 296
    Top = 16
    Width = 449
    Height = 35
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    Caption = 'Image Query'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3681838
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object Panel4: TPanel
    Left = 296
    Top = 62
    Width = 449
    Height = 385
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      449
      385)
    object imgQuery: TImage
      Left = 2
      Top = 2
      Width = 445
      Height = 381
      Anchors = [akLeft, akTop, akRight, akBottom]
      Center = True
      PopupMenu = popQuery
      Proportional = True
      Stretch = True
    end
  end
  object ckLandmark1: TCheckBox
    Left = 28
    Top = 64
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Porion'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 3
    OnClick = ckLandmark1Click
  end
  object ckLandmark2: TCheckBox
    Left = 28
    Top = 96
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Gnation'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 4
    OnClick = ckLandmark1Click
  end
  object ckLandmark3: TCheckBox
    Left = 28
    Top = 128
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Gonion'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 5
    OnClick = ckLandmark1Click
  end
  object ckLandmark4: TCheckBox
    Left = 28
    Top = 160
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Menton'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 6
    OnClick = ckLandmark1Click
  end
  object ckLandmark5: TCheckBox
    Left = 28
    Top = 192
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Nasion'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 7
    OnClick = ckLandmark1Click
  end
  object ckLandmark6: TCheckBox
    Left = 28
    Top = 224
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Orbital'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 8
    OnClick = ckLandmark1Click
  end
  object ckLandmark7: TCheckBox
    Left = 28
    Top = 256
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Pogonion'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 9
    OnClick = ckLandmark1Click
  end
  object ckLandmark8: TCheckBox
    Left = 28
    Top = 288
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Point A'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 10
    OnClick = ckLandmark1Click
  end
  object ckLandmark9: TCheckBox
    Left = 28
    Top = 320
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Point B'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 11
    OnClick = ckLandmark1Click
  end
  object ckLandmark10: TCheckBox
    Left = 28
    Top = 352
    Width = 181
    Height = 17
    Cursor = crHandPoint
    Caption = 'Sella'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 12
    OnClick = ckLandmark1Click
  end
  object popQuery: TPopupMenu
    OnPopup = popQueryPopup
    Left = 696
    Top = 64
    object LoadImage1: TMenuItem
      Caption = 'Load Image'
      OnClick = LoadImage1Click
    end
    object Recognize1: TMenuItem
      Caption = 'Recognize'
      OnClick = Recognize1Click
    end
    object Rescale1: TMenuItem
      Caption = 'Rescale'
      OnClick = Rescale1Click
    end
    object EnhanceContrast1: TMenuItem
      Caption = 'Enhance Contrast'
      OnClick = EnhanceContrast1Click
    end
    object ConvertColorMode1: TMenuItem
      Caption = 'Convert Color Mode'
      OnClick = ConvertColorMode1Click
    end
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = Save1Click
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 656
    Top = 96
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 696
    Top = 96
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 624
    Top = 190
  end
end
