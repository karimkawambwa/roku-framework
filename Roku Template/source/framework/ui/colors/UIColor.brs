'@param opacity
' 100 	: FF
' 95 	: F2
' 90 	: E6
' 85 	: D9
' 80 	: CC
' 75 	: BF
' 70 	: B3
' 65 	: A6
' 60 	: 99
' 55 	: 8C
' 50 	: 80
' 45 	: 73
' 40 	: 66
' 35 	: 59
' 30 	: 4D
' 25 	: 40
' 20 	: 33
' 15 	: 26
' 10 	: 1A
' 5 	: 0D
' 0 	: 00
function UIColorWithName(name, opacity = "FF" as String) as Integer
    app = GetApp()
    if app.colorNames <> invalid
        hex = app.colorNames[name]
        return HexToInteger(hex + opacity)
    end if
    return UIColorWithName("black")
end function

function UIColorOpacity()
	return {
		PERCENT_100	: "FF"
		PERCENT_95	: "F2"
		PERCENT_90	: "E6"
		PERCENT_85	: "D9"
		PERCENT_80	: "CC"
		PERCENT_75	: "BF"
		PERCENT_70	: "B3"
		PERCENT_65	: "A6"
		PERCENT_60	: "99"
		PERCENT_55	: "8C"
		PERCENT_50	: "80"
		PERCENT_45	: "73"
		PERCENT_40	: "66"
		PERCENT_35	: "59"
		PERCENT_30	: "4D"
		PERCENT_25	: "40"
		PERCENT_20	: "33"
		PERCENT_15	: "26"
		PERCENT_10	: "1A"
		PERCENT_5	: "0D"
		PERCENT_0	: "00"
	}
end function