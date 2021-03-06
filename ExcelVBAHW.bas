Attribute VB_Name = "Module1"

Sub stockloop()

'DIM subroutine variables

    Dim ticker As String
    Dim openprice As Currency
    Dim closeprice As Currency
    Dim totalvolume As LongLong
    Dim totalsheets As Integer
    Dim i As Integer
    Dim j As Long
    Dim outputrow As Integer
    Dim LastRow As Long
    Dim k As Integer
    Dim maxtotalvolume As LongLong
    Dim maxpercentchange As Double
    Dim minpercentchange As Double
    Dim tickermaxvolume As String
    Dim tickermaxpercent As String
    Dim tickerminpercent As String
    
    
'Set totalsheets equal to the number of worksheets in the active workbook
   
totalsheets = ActiveWorkbook.Worksheets.Count

'Begin the loop

For i = 1 To totalsheets

    Worksheets(i).Activate
    outputrow = 2
    LastRow = ActiveSheet.UsedRange.Rows.Count
    
    'Filling output column titles

    Cells(1, 9) = "Ticker Symbol"
    Cells(1, 10) = "Yearly Change"
    Cells(1, 11) = "Percent Change"
    Cells(1, 12) = "Total Stock Volume"
    
    'Filling bonus row and column titles
    
    Cells(2, 15) = "Greatest % Increase"
    Cells(3, 15) = "Greatest % Decrease"
    Cells(4, 15) = "Greatest Total Volume"
    Cells(1, 16) = "Ticker"
    Cells(1, 17) = "Value"
    
    totalvolume = CLng(0)
                
    For j = 2 To LastRow
    
        ticker = Cells(j, 1)
        totalvolume = totalvolume + CLng(Cells(j, 7))
        
        If Cells((j - 1), 1) <> ticker Then
        
            openprice = Cells(j, 3)
            
        End If
        
        If Cells((j + 1), 1) <> ticker Then
                                 
               closeprice = Cells(j, 6)
               Cells(outputrow, 9) = ticker
               Cells(outputrow, 10) = closeprice - openprice
               Cells(outputrow, 12) = totalvolume
               totalvolume = 0
                        
               If Cells(outputrow, 10) < 0 Then
                    Cells(outputrow, 10).Interior.ColorIndex = 3
                    Cells(outputrow, 11).Interior.ColorIndex = 3
            
               Else
            
                    Cells(outputrow, 10).Interior.ColorIndex = 4
                    Cells(outputrow, 11).Interior.ColorIndex = 4
            
               End If
                       
           
            Cells(outputrow, 11).NumberFormat = "0.00%"
            If openprice <> 0 Then
            
                Cells(outputrow, 11) = (closeprice - openprice) / openprice
                
            Else
            
                Cells(outputrow, 11) = "Not Available"
            
            End If
                               
            outputrow = outputrow + 1
           
        End If
           
    Next j
 
    maxtotalvolume = Cells(2, 12)
    maxpercentchange = Cells(2, 11)
    minpercentchange = Cells(2, 11)
    
    For k = 3 To outputrow
    
        If Cells(k, 12) > maxtotalvolume Then
            maxtotalvolume = Cells(k, 12)
            tickermaxvolume = Cells(k, 9)
        End If
        
        If Cells(k, 11) > maxpercentchange And Cells(k, 11) <> "Not Available" Then
            maxpercentchange = Cells(k, 11)
            tickermaxpercent = Cells(k, 9)
        End If
        
        If Cells(k, 11) < minpercentchange And Cells(k, 11) <> "Not Available" Then
            minpercentchange = Cells(k, 11)
            tickerminpercent = Cells(k, 9)
        End If
        
    Next k
    
    Cells(2, 17).NumberFormat = "0.00%"
    Cells(3, 17).NumberFormat = "0.00%"
    Cells(2, 16) = tickermaxpercent
    Cells(2, 17) = maxpercentchange
    Cells(3, 16) = tickerminpercent
    Cells(3, 17) = minpercentchange
    Cells(4, 16) = tickermaxvolume
    Cells(4, 17) = maxtotalvolume
    
    Worksheets(i).Columns("A:Q").AutoFit
    
Next i

    
End Sub










