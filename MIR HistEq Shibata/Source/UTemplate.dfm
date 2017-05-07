object FTemplate: TFTemplate
  Left = 319
  Top = 98
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Konfigurasi Template'
  ClientHeight = 479
  ClientWidth = 535
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btLandmark1: TSpeedButton
    Tag = 1
    Left = 16
    Top = 56
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Down = True
    Caption = 'Porion'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 1993170
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark2: TSpeedButton
    Tag = 2
    Left = 16
    Top = 96
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Gnation'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark3: TSpeedButton
    Tag = 3
    Left = 16
    Top = 136
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Gonion'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark4: TSpeedButton
    Tag = 4
    Left = 16
    Top = 176
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Menton'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark5: TSpeedButton
    Tag = 5
    Left = 16
    Top = 216
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Nasion'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark6: TSpeedButton
    Tag = 6
    Left = 16
    Top = 256
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Orbital'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark7: TSpeedButton
    Tag = 7
    Left = 16
    Top = 296
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Pogonion'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark8: TSpeedButton
    Tag = 8
    Left = 16
    Top = 336
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Point A'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark9: TSpeedButton
    Tag = 9
    Left = 16
    Top = 376
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Point B'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object btLandmark10: TSpeedButton
    Tag = 10
    Left = 16
    Top = 416
    Width = 169
    Height = 33
    Cursor = crHandPoint
    GroupIndex = 1
    Caption = 'Sella'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2042685
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = btLandmark1Click
  end
  object pnJudul: TPanel
    Left = 208
    Top = 16
    Width = 305
    Height = 35
    BevelInner = bvLowered
    Caption = 'Daftar Template'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3681838
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Panel3: TPanel
    Left = 208
    Top = 56
    Width = 305
    Height = 400
    BevelInner = bvLowered
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      305
      400)
    object gridTemplate: TDrawGrid
      Left = 2
      Top = 2
      Width = 302
      Height = 397
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      Color = clWhite
      ColCount = 3
      Ctl3D = True
      DefaultColWidth = 10
      DefaultRowHeight = 20
      DefaultDrawing = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      PopupMenu = popTemplate
      TabOrder = 0
      OnDrawCell = gridTemplateDrawCell
      OnMouseDown = gridTemplateMouseDown
    end
  end
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 169
    Height = 35
    BevelInner = bvLowered
    Caption = 'Landmark'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3681838
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object popTemplate: TPopupMenu
    OnPopup = popTemplatePopup
    Left = 496
    Top = 64
    object Refresh1: TMenuItem
      Caption = 'Refresh'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ambahTemplate1: TMenuItem
      Caption = 'Tambah Template'
      OnClick = ambahTemplate1Click
    end
    object HapusTemplate1: TMenuItem
      Caption = 'Hapus Template'
      OnClick = HapusTemplate1Click
    end
    object HapusSemuaTemplate1: TMenuItem
      Caption = 'Hapus Semua Template'
      OnClick = HapusSemuaTemplate1Click
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 480
    Top = 8
  end
end
