
extends Panel

var enteredNumber = 0
var operator = ""
var isNumberEntered = false
var isOperationDone = false

func _ready():
	# link button events
	get_node("Button0").connect("pressed", self, "_onClickButton0")
	get_node("Button1").connect("pressed", self, "_onClickButton1")
	get_node("Button2").connect("pressed", self, "_onClickButton2")
	get_node("Button3").connect("pressed", self, "_onClickButton3")
	get_node("Button4").connect("pressed", self, "_onClickButton4")
	get_node("Button5").connect("pressed", self, "_onClickButton5")
	get_node("Button6").connect("pressed", self, "_onClickButton6")
	get_node("Button7").connect("pressed", self, "_onClickButton7")
	get_node("Button8").connect("pressed", self, "_onClickButton8")
	get_node("Button9").connect("pressed", self, "_onClickButton9")
	get_node("ButtonAdd").connect("pressed", self, "_onClickButtonAdd")
	get_node("ButtonSubtract").connect("pressed", self, "_onClickButtonSubtract")
	get_node("ButtonDivision").connect("pressed", self, "_onClickButtonDivision")
	get_node("ButtonMultiply").connect("pressed", self, "_onClickButtonMultiply")
	get_node("ButtonMode").connect("pressed", self, "_onClickButtonMode")
	get_node("ButtonDot").connect("pressed", self, "_onClickButtonDot")
	get_node("ButtonClear").connect("pressed", self, "_onClickButtonClear")
	get_node("ButtonEqual").connect("pressed", self, "_onClickButtonEqual")
	
# @brief function that returns float or integer variable according to parameter type
# @return float or integer correspondence of string
func toNumber( text ):
	if text.find( "." ) != -1:
		return float( text )
	return int( text )

# @brief function is called when the user enter a number
# @param num - number the user entered
# @return -
func enterNumber( num ):
	var text = get_node("Label").get_text()

	# if the zero is entered only, delete it and write entered number on label
	if text.length() == 1 and int( text ) == 0:
		get_node("Label").set_text( num )
	# if the label had already right number, push back new number after it
	else:
		if isOperationDone:
			isOperationDone = false
			get_node("Label").set_text( num )
		else:
			get_node("Label").set_text( get_node("Label").get_text() + num )
		
# @brief function is called when the user enters any operator
# @param op - user operator
# @return -
func enterOperator( op ):
	var text = get_node("Label").get_text()
	
	# if the label has 0. or nothing, do nothing
	if text.length() == 0 || text == "0.":
		return
	
	# add operator
	if "+" == op:
		if !isNumberEntered:
			enteredNumber = toNumber( text )
			get_node("Label").set_text("")
			
			isNumberEntered = true
			operator = "+"
		else:
			enteredNumber += toNumber( text )
			get_node("Label").set_text( str( enteredNumber ) )
			
			isOperationDone = true
	# subtract operator
	elif "-" == op:
		if !isNumberEntered:
			enteredNumber = toNumber( text )
			get_node("Label").set_text("")
			
			isNumberEntered = true
			operator = "-"
		else:
			enteredNumber -= toNumber( text )
			get_node("Label").set_text( str( enteredNumber ) )
			
			isOperationDone = true
	# multiply operator
	elif "*" == op:
		if !isNumberEntered:
			enteredNumber = toNumber( text )
			get_node("Label").set_text("")
			
			isNumberEntered = true
			operator = "*"
		else:
			enteredNumber *= toNumber( text )
			get_node("Label").set_text( str( enteredNumber ) )
			
			isOperationDone = true
	# division operator	
	elif "/" == op:
		if !isNumberEntered:
			enteredNumber = toNumber( text )
			get_node("Label").set_text("")
			
			isNumberEntered = true
			operator = "/"
		# prevent the zero divider
		# @todo: improve zero division
		elif text != "0":
			enteredNumber /= toNumber( text )
			get_node("Label").set_text( str( enteredNumber ) )
			
			isOperationDone = true
	# mode operator	
	elif "%" == op:
		if text.find( "." ) == -1:
			if !isNumberEntered:
				enteredNumber = int( text )
				get_node("Label").set_text("")
				
				isNumberEntered = true
				operator = "%"
			# prevent the zero mode
			else:
				if text != "0":
					enteredNumber = enteredNumber % int( text )
					get_node("Label").set_text( str( enteredNumber ) )
					
					isOperationDone = true
	# calculate operator	
	elif "=" == op:
		# if the first number was already entered, call function with entered operator recursively
		if isNumberEntered:
			enterOperator( operator )
		
# @brief The zero button event function
# @return -
func _onClickButton0():
	var num = get_node("Label").get_text()
	
	# if the zero was already entered, write zero only
	if num.length() == 1 and int( num ) == 0:
		get_node("Label").set_text( "0" )
	else:
		get_node("Label").set_text( get_node("Label").get_text() + "0" )
		
# @brief The one button event function
# @return -
func _onClickButton1():
	enterNumber( "1" )
		
# @brief The two button event function
# @return -
func _onClickButton2():
	enterNumber( "2" )
	
# @brief The three button event function
# @return -
func _onClickButton3():
	enterNumber( "3" )
	
# @brief The four button event function
# @return -
func _onClickButton4():
	enterNumber( "4" )
	
# @brief The five button event function
# @return -
func _onClickButton5():
	enterNumber( "5" )
	
# @brief The six button event function
# @return -
func _onClickButton6():
	enterNumber( "6" )
	
# @brief The seven button event function
# @return -
func _onClickButton7():
	enterNumber( "7" )
	
# @brief The eight button event function
# @return -
func _onClickButton8():
	enterNumber( "8" )
	
# @brief The nine button event function
# @return -
func _onClickButton9():
	enterNumber( "9" )
	
# @brief The dot button event function
# @return -
func _onClickButtonDot():
	var text = get_node("Label").get_text()
	
	# if the label is empty, write 0.
	if text.length() == 0:
		get_node("Label").set_text( get_node("Label").get_text() + "0." )
	elif text.length() > 0 && text.find(".") == -1:
		get_node("Label").set_text( text + "." )

# @brief function that clears label and set isNumberEntered with false
# @return -
func _onClickButtonClear():
	get_node("Label").set_text( "" )
	isNumberEntered = false
	
# @brief The add button event function
# @return -
func _onClickButtonAdd():
	enterOperator( "+" )
	
# @brief The subtract button event function
# @return -
func _onClickButtonSubtract():
	enterOperator( "-" )
	
# @brief The multiply button event function
# @return -
func _onClickButtonMultiply():
	enterOperator( "*" )
	
# @brief The division button event function
# @return -
func _onClickButtonDivision():
	enterOperator( "/" )
	
# @brief The mode button event function
# @return -
func _onClickButtonMode():
	enterOperator( "%" )
	
# @brief The calculate button event function
# @return -
func _onClickButtonEqual():
	enterOperator( "=" )
	isNumberEntered = false