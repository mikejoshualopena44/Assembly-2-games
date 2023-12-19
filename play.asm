;Mike Joshua Lopena
IDEAL
MODEL small
STACK 100h
DATASEG
; Public string variables{
	; --------------------------
	; Home For 2 games
	; --------------------------

	;booleanExit
		closeProgram db 0 ; a boolean like variable that tells if the user wants to exit the PROGRAM
		ExitingProgram db 0 ; a boolean like variable that tells if the user wants to exit the game or not.

	;HomeTexts-------------------------------------------------------------------------------------

		TextHomeTitle db '--------- Main Menu ---------$' ; the title of the main menu screen
		TextHomePlayChonker  db '     PRESS 1 TO PLAY CHONKER$' ; the text shown telling the user to press 1 to go play chonker;edited
		TextHomePlayPong  db '     PRESS 2 TO PLAY PONG$' ; the text shown telling the user to press 1 to go play chonker;edited
		TextHomeEditor db '       (CPE 412 - FINAL PROJECT)', 0Ah,, 0Ah,'    PREPARED BY: MIKE JOSHUA LOPENA$' ; the text shown telling the user to press T to go to the tutorial
		TextHomeExitProgram db '     PRESS ESC TO EXIT PROGRAM$' ; message shown telling the user what to do in order to exit the game
	
	; 2 Games Home Texts--------------------------------------------------------------
		TextMainMenuTitle db '--------- Pong Game ---------$$' ; the title of the main menu screen
		TextMainMenuSingleplayer db '       PRESS 1 TO PLAY PVE$' ; message shown describing the user what to do in order to play single player
		TextMainMenuMultiplayer db '       PRESS 2 TO PLAY PVP$' ; message shown describing the user what to do in order to play multi player
		TextMainMenuTitleChonker db '--------- Chonker Game ---------$' ; the title of the main menu screen
		TextMainMenuPlayChonker  db '       PRESS 1 TO PLAY CHONKER$' ; the text shown telling the user to press 1 to go play chonker;edited
		TextChonkerTutorial db  0Ah,, 0Ah,'     In Chonker game', 0Ah,, 0Ah,'     The player must avoid the rocks', 0Ah, , 0Ah, '     Press (A) to move left', 0Ah,, 0Ah, '     Press (D) to move right', 0Ah,, 0Ah, '     Press (Q) to quit the game.$' ; the text explaining the PVE mode
		TextMainMenuTutorial db '       PRESS T FOR TOTURIAL.$' ; the text shown telling the user to press T to go to the tutorial

	; --------------------------
	;  variables here
	; --------------------------
	;	For the game itself
		ScreenBounds dw 3 ; used to check collisions early
		BallX dw 11 ; current X position of the ball
		BallY dw 11 ; current Y position of the ball
		ResettedBallPositionXIfPlayer1Won dw 30 ; the resetted X value of the ball if player 1 won the previous round
		ResettedBallPositionYIfPlayer1Won dw 11 ; the resetted Y value of the ball if player 1 won the previous round
		ResettedBallPositionXIfPlayer2Won dw 290 ; the resetted X value of the ball if player 2 won the previous round
		ResettedBallPositionYIfPlayer2Won dw 11 ; the resetted Y value of the ball if player 2 won the previous round
		BallSize dw 4 ; size of the ball - both X and Y
		BallVelocityX dw 5 ; X (horizontal) velocity of the ball
		BallVelocityY dw 2 ; Y (vertical) velocity of the ball
		PaddleLeftX dw 10 ; current X position of the left paddle
		PaddleLeftY dw 10 ; current Y position of the left paddle
		PaddleRightX dw 304 ; current X position of the right paddle
		PaddleRightY dw 10 ; current Y position of the right paddle
		PaddlesWidth dw 5 ; the width of both paddles
		PaddlesHeight dw 31 ; the height of both paddles
		PaddlesVelocity dw 6 ; the velocity of both paddles
	;	User Interface
		LeftPaddlePlayerScore db 0 ; current points of the left player
		RightPaddlePlayerScore db 0 ; current points of the right player
		Player1 db 'Player 1:$' ; the text "Player 1:"
		Player2 db 'Player 2:$' ; the text "Player 2:"
		Computer db 'Computer:$' ; the text "Computer:"
		WinnerNumber db ? ; the number of the player who won. Left player is player 1 and the right player is player 2.
		Player db 'Player:$' ; text shown in the UI if the chosen mode is PVE.
	;	Boolean variables
		IsPVEorPVP db ? ; a boolean like variable that tells if the chosen mode is PVE or PVP. 1 means PVE and 2 means PVP.
		Player1WonRound db ? ; a boolean like variable that tells if player 1 won the previous round
		StartOfGame db ? ; a boolean like variable that determines whether the game has just started or not
		VersusComputerDifficulty dw ? ; a boolean like variable that determines what the difficulty against the computer will be. 1 means easy, 2 means hard and 3 means IMPOSSIBLE.
		GameActive db 1 ; if the game is active then GameActive is 1. Else, it's 0. like a boolean variable
		RightPaddleControlledByAI db 0 ; a boolean like variable that tells if the right paddle is controlled by the AI.
		CurrentScene db 0 ; 0 means the main menu and 1 means the game. Boolean
		IsPVEEasyOrNot db ? ; 0 means that the chosen mode is NOT PVP Easy. 1 means the chosen mode IS PVP Easy.
	;-------------------------------------------------------------------------------------------------------
		TextLeftPaddlePlayerScore db '0$' ; displayed text of left paddle player's score
		TextRightPaddlePlayerScore db '0$' ; displayed text of right paddle player's score
		TextGameOverTitle db 'Game Over!$' ; the game over title
		TextGameOverWinnerPVP db 'Player 1 Won!$' ; shows which player won in PVP
		TextGameOverWinnerPVEComputer db 'The Computer Won!$' ; shown if the computer has won
		TextGameOverWinnerPVEPlayer db 'The Player Won!$' ; shown if the player has won
		TextGameOverPlayAgain db 'Press Enter to play again.$' ; message shown asking if the players want to play again
		TextGameOverMainMenu db 'Press ESC to exit to main menu.$' ; contains the text shown on the game over screen asking if the player would like to go to the main menu.
	;------------------------------------------------------------------------------------------------------------
		TextMainMenuExitProgram db 'Select another game press ESC.$' ; message shown telling the user what to do in order to exit the game
		TextTutorialMenuTitle db 'Tutorial:$'; the title shown in the tutorial menu
		TextTutorialMenuPVE db 'In PVE, the computer handles the', 0Ah, '     right paddle and the user handles', 0Ah, '     the left paddle.', 0Ah, '     Press W to move the paddle up',0Ah, '     and S to move it down.$' ; the text explaining the PVE mode
		TextTutorialMenuPVP db 'In PVP, there are two users.', 0Ah, '     If you are Player 1, the buttons', 0Ah, '     are the same as PVE.', 0Ah, '     For Player 2, in order to move', 0Ah, '     the paddle up press the up arrow', 0Ah, '     and to move it down press the', 0Ah, '     down arrow.$' ; the text explaining the PVP mode
		TextBackToMainMenu db 'Return to main menu press ESC.$' ; telling the user that if he wants to go back to the main menu he needs to press ESC
		TextMessage1 db 'Game Paused$' ; the first part of the text displayed on the screen when the message is shown
		TextMessage2 db 'Are you sure you want$' ; the second part of the text displayed on the screen when the message is shown
		TextMessage3 db 'to quit the game?$' ; the third part of the text displayed on the screen when the message is shown
		TextMessage4 db 'Press Y/Enter to quit.$' ; the fourth part of the text displayed on the screen when the message is shown
		TextMessage5 db 'Press N/ESC to continue playing.$' ; the fifth part of the text displayed on the screen when the message is shown
		Text1DifficultyLevelScreen db 'Choose difficulty level:$' ; telling the user what this screen is for
		Text2DifficultyLevelScreen db ' - Easy: press 1.$' ; telling the user to press 3 if he prefers easy difficulty
		Text3DifficultyLevelScreen db ' - Hard: press 2.$' ; telling the user to press 2 if he prefers hard difficulty
		Text4DifficultyLevelScreen db ' - IMPOSSIBLE: press 3.$' ; telling the user to press 1 if he prefers impossible difficulty
	;	Variables used as parameters
		ChosenInitialX dw ? ; The initial X parameter given to the procedures: PrintChosenRectangle & PrintChosenFrame
		ChosenInitialY	dw ? ; The initial Y parameter given to the procedures: PrintChosenRectangle & PrintChosenFrame
		ChosenHeight dw ? ; The height parameter given to the procedures: PrintChosenRectangle & PrintChosenFrame
		ChosenWidth dw ? ; The width parameter given to the procedures: PrintChosenRectangle & PrintChosenFrame
		ChosenColor db ? ; The color parameter given to the procedures: PrintChosenRectangle & PrintChosenFrame
		ChosenThickness dw ? ; The thickness parameter given to the procedure: PrintChosenFrame
		ChosenTextRow db ? ; The row parameter given to the procedure: PrintChosenText
		ChosenTextColumn db ? ; The column parameter given to the procedure: PrintChosenText
		ChosenTextOffset dw ? ; The offset parameter given to the procedure: PrintChosenText
	; Others
		TimeAux db 0 ; used when checking if time has passed
;}
CODESEG
;----------------------
; Procedures start here
;----------------------
; Public Procedures{
	proc ClearScreen ; Credits to my friend for giving me this procedure
		mov ah, 2h
		xor dx, dx
		xor bh, bh
		int 10h
		mov cx, 18h
	ClearScreen_1:
		push cx
		mov cx, 28h
	ClearScreen_2:
		mov dl, ' '
		mov ah, 2h
		int 21h
		loop ClearScreen_2
		pop cx
		mov dl, 0Ah
		mov ah, 2h
		int 21h
		loop ClearScreen_1
		ret
	endp ClearScreen
;}
; Private Pong Procedures{
	proc DrawBall
		mov ax, [BallX]
		mov [ChosenInitialX], ax
		mov ax, [BallY]
		mov [ChosenInitialY], ax
		mov ax, [BallSize]
		mov [ChosenHeight], ax
		mov [ChosenWidth], ax
		mov [ChosenColor], 0Fh
		call PrintChosenRectangle
		ret
	endp DrawBall
	proc PaintLeftPaddleBlack
		mov ax, [PaddleLeftX]
		mov [ChosenInitialX], ax
		mov ax, [PaddleLeftY]
		mov [ChosenInitialY], ax
		mov ax, [PaddlesHeight]
		mov [ChosenHeight], ax
		mov ax, [PaddlesWidth]
		mov [ChosenWidth], ax
		mov [ChosenColor], 0
		call PrintChosenRectangle
		ret
	endp PaintLeftPaddleBlack
	proc PaintRightPaddleBlack
		mov ax, [PaddleRightX]
		mov [ChosenInitialX], ax
		mov ax, [PaddleRightY]
		mov [ChosenInitialY], ax
		mov ax, [PaddlesHeight]
		mov [ChosenHeight], ax
		mov ax, [PaddlesWidth]
		mov [ChosenWidth], ax
		mov [ChosenColor], 0
		call PrintChosenRectangle
		ret
	endp PaintRightPaddleBlack
	proc PaintBallBlack
		mov ax, [BallX]
		mov [ChosenInitialX], ax
		mov ax, [BallY]
		mov [ChosenInitialY], ax
		mov ax, [BallSize]
		mov [ChosenHeight], ax
		mov [ChosenWidth], ax
		mov [ChosenColor], 0
		call PrintChosenRectangle
		ret
	endp PaintBallBlack
	proc MoveBall
	;	All the next lines until the label comtinue are to check if the ball is where the bug occures
		mov ax, [PaddleLeftX]
		add ax, [PaddlesWidth]
		inc ax
		cmp [BallX], ax
		jb test1
		jmp Comtinue
	test1:
		mov ax, [ScreenBounds]
	;	inc ax
		cmp [BallY], ax
		jb test2
		jmp Comtinue
	test2:
		mov ax, 1
	Comtinue:
		mov ax, [BallVelocityX]
		add [BallX], ax ; move the ball horizontally
		mov ax, [PaddleLeftX]
		add ax, [PaddlesWidth]
		cmp [BallX], ax
		jl JumpToAddAPointToRightPlayerAndResetPosition
		mov ax, [PaddleRightX]
		sub ax, [BallSize]
		cmp [BallX], ax
		jg JumpToAddAPointToLeftPlayerAndResetPosition
		mov ax, [BallVelocityY]
		add [BallY], ax ; move the ball vertically
		mov ax, [ScreenBounds]
		cmp [BallY], ax
		jl JumpToNegVelocityY
		mov ax, 200
		sub ax, [BallSize]
		sub ax, [ScreenBounds]
		cmp [BallY], ax
		jg JumpToNegVelocityY
		jmp FirstCondition
	JumpToAddAPointToLeftPlayerAndResetPosition:
		jmp AddAPointToLeftPlayerAndResetPosition
	JumpToAddAPointToRightPlayerAndResetPosition:
		jmp AddAPointToRightPlayerAndResetPosition
	JumpToNegVelocityY:
		jmp NegVelocityY
	;	Checking if the ball is colliding with the right paddle
	;	The conditions:
	;	BallX + BallSize > PaddleRightX && BallX < PaddleRightX + PaddlesWidth
	;	&& BallY + BallSize > PaddleRightY && BallY < PaddleRightY + PaddlesHeight
	FirstCondition:
		mov ax, [BallX]
		add ax, [BallSize]
		cmp ax, [PaddleRightX] ; if there is no collision
		jl CheckCollisionWithLeftPaddle ; check for the left paddle collisions
	;Second condition:
		mov ax, [PaddleRightX]
		add ax, [PaddlesWidth]
		cmp [BallX], ax ; if there is no collision
		jg CheckCollisionWithLeftPaddle ; check for the left paddle collisions
	;Third condition:
		mov ax, [BallY]
		add ax, [BallSize]
		cmp ax, [PaddleRightY] ; if there is no collision
		jl CheckCollisionWithLeftPaddle ; check for the left paddle collisions
	;Forth condition:
		mov ax, [PaddleRightY]
		add ax, [PaddlesHeight]
		cmp [BallY], ax ; if there is no collision
		jg CheckCollisionWithLeftPaddle ; check for the left paddle collisions
	;	if it reaches this point, the ball is colliding with the right paddle.
		neg [BallVelocityX] ; reverses the horizontal velocity of the ball
		ret
	;	Checking if the ball is colliding with the left paddle
	CheckCollisionWithLeftPaddle:
	;	The conditions:
	;	BallX + BallSize > PaddleLeftX && BallX < PaddleLeftX + PaddlesWidth
	;	&& BallY + BallSize > PaddleLeftY && BallY < PaddleLeftY + PaddlesHeight
	;First condition:
		mov ax, [BallX]
		add ax, [BallSize]
		cmp ax, [PaddleLeftX] ; if there is no collision
		jl JumpToExitProcedure ; exit the procedure
	;Second condition:
		mov ax, [PaddleLeftX]
		add ax, [PaddlesWidth]
		cmp [BallX], ax ; if there is no collision
		jg JumpToExitProcedure ; exit the procedure
	;Third condition:
		mov ax, [BallY]
		add ax, [BallSize]
		cmp ax, [PaddleLeftY] ; if there is no collision
		jl JumpToExitProcedure ; exit the procedure
	;Forth condition:
		mov ax, [PaddleLeftY]
		add ax, [PaddlesHeight]
		cmp [BallY], ax ; if there is no collision
		jg JumpToExitProcedure ; exit the procedure
	;	if it reaches this point, the ball is colliding with the left paddle.
		neg [BallVelocityX] ; reverses the horizontal velocity of the ball
		ret
	JumpToExitProcedure:
		jmp ExitProcedure
	AddAPointToLeftPlayerAndResetPosition:
		inc [LeftPaddlePlayerScore]
		mov [Player1WonRound], 1
		call ResetBallPosition
		call UpdateLeftPaddlePlayerScore ; updating the score displayed of the left paddle player's score
		cmp [LeftPaddlePlayerScore], 5 ; checking if the left paddle player's score is 5
		je GameOver ; if it is 5 or more, jump to GameOver
		ret
	AddAPointToRightPlayerAndResetPosition:
		inc [RightPaddlePlayerScore]
		mov [Player1WonRound], 0
		call ResetBallPosition
		call UpdateRightPaddlePlayerScore ; updating the score displayed of the right paddle player's score
		cmp [RightPaddlePlayerScore], 5 ; checking if the right paddle player's score is 5
		je GameOver ; if it is 5 or more, jump to GameOver
		ret
	GameOver: ; setting the scores to zero
		cmp [LeftPaddlePlayerScore], 5 ; Checking which player has won
		je Player1Won
		jmp Player2Won
	Player1Won:
		mov [WinnerNumber], 1
		jmp ContinueGameOver
	Player2Won:
		mov [WinnerNumber], 2
	ContinueGameOver:
		call NewGame
		mov [GameActive], 0 ; GameActive is 0 which means the game is not active (over)
		ret
	NegVelocityY:
		neg [BallVelocityY]
	ExitProcedure:
		ret
	endp MoveBall
	proc ResetBallPosition
		cmp [StartOfGame], 0
		je MiddleGame
	; Start of game
		mov [BallVelocityX], 5
		mov [BallVelocityY], 2
		mov ax, [ResettedBallPositionXIfPlayer1Won]
		mov [BallX], ax
		mov ax, [ResettedBallPositionYIfPlayer1Won]
		mov [BallY], ax
		ret
	MiddleGame:
		cmp [Player1WonRound], 0
		je RightPlayerWonRound
	; Left player won round
		mov [BallVelocityX], 5
		mov [BallVelocityY], 2
		mov ax, [ResettedBallPositionXIfPlayer1Won]
		mov [BallX], ax
		mov ax, [ResettedBallPositionYIfPlayer1Won]
		mov [BallY], ax
		ret
	RightPlayerWonRound:
		mov [BallVelocityX], -5
		mov [BallVelocityY], 2
		mov ax, [ResettedBallPositionXIfPlayer2Won]
		mov [BallX], ax
		mov ax, [ResettedBallPositionYIfPlayer2Won]
		mov [BallY], ax
		ret
	endp ResetBallPosition
	proc ResetPaddlesPosition
		mov [PaddleLeftY], 85
		mov [PaddleRightY], 85
		ret
	endp ResetPaddlesPosition
	proc NewGame
		mov [LeftPaddlePlayerScore], 0 ; setting the left paddle player's scores to zero
		mov [RightPaddlePlayerScore], 0 ; setting the right paddle player's scores to zero
		call UpdateLeftPaddlePlayerScore
		call UpdateRightPaddlePlayerScore
		call ResetBallPosition
		call ResetPaddlesPosition
		ret
	endp NewGame
	proc DrawPaddles
	; Paddle left
		mov ax, [PaddleLeftX]
		mov [ChosenInitialX], ax
		mov ax, [PaddleLeftY]
		mov [ChosenInitialY], ax
		mov ax, [PaddlesHeight]
		mov [ChosenHeight], ax
		mov ax, [PaddlesWidth]
		mov [ChosenWidth], ax
		mov [ChosenColor], 0Fh
		call PrintChosenRectangle
	; Paddle right
		mov ax, [PaddleRightX]
		mov [ChosenInitialX], ax
		mov ax, [PaddleRightY]
		mov [ChosenInitialY], ax
		mov ax, [PaddlesHeight]
		mov [ChosenHeight], ax
		mov ax, [PaddlesWidth]
		mov [ChosenWidth], ax
		mov [ChosenColor], 0Fh
		call PrintChosenRectangle
		ret
	endp DrawPaddles
	proc MovePaddles
	; Left paddle
	; Checking if any key is pressed. If not, we check the other paddle.
		mov ah, 1
		int 16h
		jz CheckRightPaddleMovement
	; Checking which key is pressed. al = ascii character
		xor ah, ah
		int 16h
		cmp al, 'w'
		je MoveLeftPaddleUp
		cmp al, 'W'
		je MoveLeftPaddleUp
		cmp al, 's'
		je MoveLeftPaddleDown
		cmp al, 'S'
		je MoveLeftPaddleDown
		cmp al, 01Bh
		je JumpToMessageAskingIfQuit
		jmp CheckRightPaddleMovement
	JumpToMessageAskingIfQuit:
		jmp MessageAskingIfQuit
	MoveLeftPaddleUp:
		call FlushBuffer
		call PaintLeftPaddleBlack
		mov ax, [PaddlesVelocity]
		sub [PaddleLeftY], ax
		mov ax, [ScreenBounds]
		cmp [PaddleLeftY], ax
		jl FixPaddleLeftTopPosition
		jmp CheckRightPaddleMovement
	FixPaddleLeftTopPosition:
		mov ax, [ScreenBounds]
		mov [PaddleLeftY], ax
		jmp CheckRightPaddleMovement
	MoveLeftPaddleDown:
		call FlushBuffer
		call PaintLeftPaddleBlack
		mov ax, [PaddlesVelocity]
		add [PaddleLeftY], ax
		mov ax, 200
		sub ax, [ScreenBounds]
		sub ax, [PaddlesHeight]
		cmp [PaddleLeftY], ax
		jg FixPaddleLeftBottomPosition
		jmp CheckRightPaddleMovement
	FixPaddleLeftBottomPosition:
		mov [PaddleLeftY], ax
	; Right paddle
	CheckRightPaddleMovement:
		cmp [RightPaddleControlledByAI], 1
		je AIControlsRightPaddle
	; when the paddle is controlled by the user pressing a key
		cmp ah, 048h ; up arrow
		je JumpToMoveRightPaddleUp ; if it is up arrow, move up.
		cmp ah, 050h ; down arrow
		je JumpToMoveRightPaddleDown ; if it is down arrow, move down.
		ret
	JumpToMoveRightPaddleUp:
		jmp MoveRightPaddleUp
	JumpToMoveRightPaddleDown:
		jmp MoveRightPaddleDown
	AIControlsRightPaddle: ; When the right paddle is controlled by the AI
		cmp [VersusComputerDifficulty], 3
		je InvincibleComputer
	; Easily beaten computer
	; Checking if the ball is above the paddle.
		mov ax, [BallY]
		add ax, [BallSize]
		cmp ax, [PaddleRightY]
		jl JumpToMoveRightPaddleUp
	; Checking if the ball is below the paddle.
		mov ax, [PaddleRightY]
		add ax, [PaddlesHeight]
		cmp ax, [BallY]
		jl JumpToMoveRightPaddleDown
		ret
	InvincibleComputer:
		call PaintRightPaddleBlack
		mov ax, 3
		mov cx, 14
		Cases:
			cmp ax, [BallY]
			ja Done
			add ax, 13
			loop Cases
		Done:
		sub ax, 15
		mov [PaddleRightY], ax
		ret
	JumpToMoveLeftPaddleUp:
		jmp MoveLeftPaddleUp
	JumpToMoveLeftPaddleDown:
		jmp MoveLeftPaddleDown
	JumpToMoveRightPaddleDown2:
		jmp MoveRightPaddleDown
	MoveRightPaddleUp:
		call FlushBuffer
		call PaintRightPaddleBlack
		mov ax, [PaddlesVelocity]
		sub [PaddleRightY], ax
		cmp [IsPVEorPVP], 1
		je IsPVE1
		jmp ContinueToCheckings1
	IsPVE1:
		cmp [IsPVEEasyOrNot], 1
		je IsPVEEasy1
		jmp IsPVEHard1
	IsPVEEasy1:
		sub [PaddleRightY], 2
		jmp ContinueToCheckings1
	IsPVEHard1:
		sub [PaddleRightY], 5
	ContinueToCheckings1:
		mov ax, [ScreenBounds]
		cmp [PaddleRightY], ax
		jl FixPaddleRightTopPosition
		ret
	FixPaddleRightTopPosition:
		mov ax, [ScreenBounds]
		mov [PaddleRightY], ax
		ret
	MoveRightPaddleDown:
		call FlushBuffer
		call PaintRightPaddleBlack
		mov ax, [PaddlesVelocity]
		add [PaddleRightY], ax
		cmp [IsPVEorPVP], 1
		je IsPVE2
		jmp ContinueToCheckings2
	IsPVE2:
		cmp [IsPVEEasyOrNot], 1
		je IsPVEEasy2
		jmp IsPVEHard2
	IsPVEEasy2:
		add [PaddleRightY], 2
		jmp ContinueToCheckings2
	IsPVEHard2:
		add [PaddleRightY], 6
	ContinueToCheckings2:
		add [PaddleRightY], 2
		mov ax, 200
		sub ax, [ScreenBounds]
		sub ax, [PaddlesHeight]
		cmp [PaddleRightY], ax
		jg FixPaddleRightBottomPosition
		ret
	FixPaddleRightBottomPosition:
		mov [PaddleRightY], ax
		ret
	MessageAskingIfQuit:
		call ClearScreen
		mov [ChosenInitialX], 20
		mov [ChosenInitialY], 50
		mov [ChosenColor], 4
		mov [ChosenHeight], 100
		mov [ChosenWidth], 280
		mov [ChosenThickness], 4
		call PrintChosenFrame
		mov ax, [ChosenThickness]
		add [ChosenInitialX], ax
		add [ChosenInitialY], ax
		mov [ChosenColor], 8
		sub [ChosenHeight], ax
		sub [ChosenHeight], ax
		sub [ChosenWidth], ax
		sub [ChosenWidth], ax
		call PrintChosenRectangle
	; Part 1 of the sentence:
		mov [ChosenTextRow], 7
		mov [ChosenTextColumn], 14
		mov [ChosenTextOffset], offset TextMessage1
		call PrintChosenText
	; Part 2 of the sentence:
		mov [ChosenTextRow], 10
		mov [ChosenTextColumn], 9
		mov [ChosenTextOffset], offset TextMessage2
		call PrintChosenText
	; Part 3 of the sentence:
		mov [ChosenTextRow], 12
		mov [ChosenTextColumn], 11
		mov [ChosenTextOffset], offset TextMessage3
		call PrintChosenText
	; Part 4 of the sentence:
		mov [ChosenTextRow], 14
		mov [ChosenTextColumn], 8
		mov [ChosenTextOffset], offset TextMessage4
		call PrintChosenText
	; Part 5 of the sentence:
		mov [ChosenTextRow], 16
		mov [ChosenTextColumn], 4
		mov [ChosenTextOffset], offset TextMessage5
		call PrintChosenText
	InputFromKeyboard1:
		xor ah, ah
		int 16h
	; Checking which key was pressed
		cmp al, 'Y'
		je ExitToMainMenu
		cmp al, 'y'
		je ExitToMainMenu
		cmp ah, 01Ch
		je ExitToMainMenu
		cmp al, 'N'
		je ExitProcedure2
		cmp al, 'n'
		je ExitProcedure2
		cmp al, 01Bh
		je ExitProcedure2
		jmp InputFromKeyboard1
	ExitToMainMenu:
		call PrintMainMenu
		ret
	ExitProcedure2:
		call ClearScreen
		ret
	endp MovePaddles
	proc UI
		cmp [IsPVEorPVP], 1
		je PVE
		jmp PVP
	PVE:
	; Printing player
		mov [ChosenTextRow], 1
		mov [ChosenTextColumn], 8
		mov [ChosenTextOffset], offset Player
		call PrintChosenText
	; Printing computer
		mov [ChosenTextRow], 1
		mov [ChosenTextColumn], 25
		mov [ChosenTextOffset], offset Computer
		call PrintChosenText
		jmp TheScores
	PVP:
	; Printing player 1
		mov [ChosenTextRow], 1
		mov [ChosenTextColumn], 7
		mov [ChosenTextOffset], offset Player1
		call PrintChosenText
	; Printing player 2
		mov [ChosenTextRow], 1
		mov [ChosenTextColumn], 25
		mov [ChosenTextOffset], offset Player2
		call PrintChosenText
	TheScores:
	; Left player
		mov [ChosenTextRow], 3
		mov [ChosenTextColumn], 11
		mov [ChosenTextOffset], offset TextLeftPaddlePlayerScore
		call PrintChosenText
	; Right player
		mov [ChosenTextRow], 3
		mov [ChosenTextColumn], 29
		mov [ChosenTextOffset], offset TextRightPaddlePlayerScore
		call PrintChosenText
		ret
	endp UI
	proc UpdateLeftPaddlePlayerScore
		mov al, [LeftPaddlePlayerScore]
		add al, 30h
		mov [TextLeftPaddlePlayerScore], al
		ret
	endp UpdateLeftPaddlePlayerScore
	proc UpdateRightPaddlePlayerScore
		mov al, [RightPaddlePlayerScore]
		add al, 30h
		mov [TextRightPaddlePlayerScore], al
		ret
	endp UpdateRightPaddlePlayerScore
	proc PrintGameOverScreen
		call ClearScreen
	; Printing title
		mov [ChosenTextRow], 4
		mov [ChosenTextColumn], 15
		mov [ChosenTextOffset], offset TextGameOverTitle
		call PrintChosenText
	; Showing which player won:
		cmp [IsPVEorPVP], 1
		je PVECase2
		jmp PVPCase2
	PVECase2:
		cmp [WinnerNumber], 1
		je PlayerWon
		jmp ComputerWon
	PlayerWon:
		mov [ChosenTextRow], 11
		mov [ChosenTextColumn], 13
		mov [ChosenTextOffset], offset TextGameOverWinnerPVEPlayer
		call PrintChosenText
		jmp DisplayingThePlayAgainMessage
	ComputerWon:
		mov [ChosenTextRow], 11
		mov [ChosenTextColumn], 12
		mov [ChosenTextOffset], offset TextGameOverWinnerPVEComputer
		call PrintChosenText
		jmp DisplayingThePlayAgainMessage
	PVPCase2:
		call UpdateWinnerText
		mov [ChosenTextRow], 11
		mov [ChosenTextColumn], 14
		mov [ChosenTextOffset], offset TextGameOverWinnerPVP
		call PrintChosenText
	DisplayingThePlayAgainMessage:
		mov [ChosenTextRow], 14
		mov [ChosenTextColumn], 7
		mov [ChosenTextOffset], offset TextGameOverPlayAgain
		call PrintChosenText
	; Showing the go to main menu message:
		mov [ChosenTextRow], 16
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextGameOverMainMenu
		call PrintChosenText
	; Waiting for a key to be pressed
	InputFromKeyboard2:
		xor ah, ah
		int 16h
		cmp ah, 01Ch ; if the key that was pressed is Enter
		je RestartGame ; then restart the game
		cmp al, 01Bh ; if the key that was pressed is ESC
		je GoToMainMenu ; then go to the main menu
		jmp InputFromKeyboard2
	RestartGame:
		mov [StartOfGame], 1
		mov [GameActive], 1
		call NewGame
		call ClearScreen
		ret
	GoToMainMenu:
		mov [GameActive], 0
		mov [CurrentScene], 0
		ret
	endp PrintGameOverScreen
	proc UpdateWinnerText
		mov al, [WinnerNumber]
		add al, 30h
		mov [TextGameOverWinnerPVP + 7], al
		ret
	endp UpdateWinnerText
	proc PrintMainMenu
		call ClearScreen
	; Showing the main menu screen texts:
	; Displaying the title
		mov [ChosenTextRow], 3
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextMainMenuTitle
		call PrintChosenText
	; Displaying the single player option:
		mov [ChosenTextRow], 7
		mov [ChosenTextColumn], 2
		mov [ChosenTextOffset], offset TextMainMenuSingleplayer
		call PrintChosenText
	; Displaying the multi player option:
		mov [ChosenTextRow], 10
		mov [ChosenTextColumn], 2
		mov [ChosenTextOffset], offset TextMainMenuMultiplayer
		call PrintChosenText
	; Displaying the Tutorial screen option:
		mov [ChosenTextRow], 13
		mov [ChosenTextColumn], 2
		mov [ChosenTextOffset], offset TextMainMenuTutorial
		call PrintChosenText
	; Displaying the exit game option:
		mov [ChosenTextRow], 20
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextMainMenuExitProgram
		call PrintChosenText
	InputFromKeyboard3:
		xor ah, ah
		int 16h
	; Single player
		cmp al, 31h ; if the key that was pressed is 1
		je SinglePlayer ; then start the single player mode
	; Multi player
		cmp al, 32h ; if the key that was pressed is 2
		je MultiPLayer ; then start the multi player mode
	; Tutorial
		cmp al, 't'  ; if the key that was pressed is t
		je Tutorial ; then go to tutorial
		cmp al, 'T'  ; if the key that was pressed is T
		je Tutorial ; then go to tutorial
	; Exit
		cmp al, 01Bh ; if the key that was pressed is ESC
		je ExitGame ; then exit
		jmp InputFromKeyboard3
	SinglePlayer:
		mov [IsPVEorPVP], 1
		mov [StartOfGame], 1
		mov [CurrentScene], 1
		mov [RightPaddleControlledByAI], 1
		call NewGame
		mov [StartOfGame], 0
		call DifficultyLevelScreen
		call ClearScreen
		ret
	MultiPLayer:
		mov [IsPVEorPVP], 2
		mov [StartOfGame], 1
		mov [CurrentScene], 1
		mov [GameActive], 1
		mov [RightPaddleControlledByAI], 0
		call NewGame
		mov [StartOfGame], 0
		call ClearScreen
		ret
	Tutorial:
		call PrintTutorialMenu
		ret

	
	ExitProgramPong:
		mov [ExitingProgram], 1
		ret
	endp PrintMainMenu
	ExitGame:
		call ConcludeExitProgramChonker
		ret

	;Exit Options 

	proc ConcludeExitProgram
		call PrintHome
	endp ConcludeExitProgram

	proc FullClose
		mov ax, 2
		int 10h
		mov ah, 04Ch ; terminate program
		int 21h
	endp FullClose


	proc DifficultyLevelScreen
		call ClearScreen
	; Printing the texts:
	; Title
		mov [ChosenTextRow], 3
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset Text1DifficultyLevelScreen
		call PrintChosenText
	; easy
		mov [ChosenTextRow], 7
		mov [ChosenTextColumn], 2
		mov [ChosenTextOffset], offset Text2DifficultyLevelScreen
		call PrintChosenText
	; Hard
		mov [ChosenTextRow], 10
		mov [ChosenTextColumn], 2
		mov [ChosenTextOffset], offset Text3DifficultyLevelScreen
		call PrintChosenText
	; IMPOSSIBLE
		mov [ChosenTextRow], 13
		mov [ChosenTextColumn], 2
		mov [ChosenTextOffset], offset Text4DifficultyLevelScreen
		call PrintChosenText
	; Back to main menu
		mov [ChosenTextRow], 20
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextBackToMainMenu
		call PrintChosenText
	InputFromKeyboard4:
		xor ah, ah
		int 16h
		cmp al, 31h
		je EasyDifficulty
		cmp al, 32h
		je HardDifficulty
		cmp al, 33h
		je ImpossibleDifficulty
		cmp al, 01Bh
		je BackToMainMenu1
		jmp InputFromKeyboard4
	EasyDifficulty:
		mov [StartOfGame], 1
		mov [GameActive], 1
		mov [VersusComputerDifficulty], 1
		mov [IsPVEEasyOrNot], 1
		call NewGame
		mov [StartOfGame], 0
		ret
	HardDifficulty:
		mov [StartOfGame], 1
		mov [GameActive], 1
		mov [VersusComputerDifficulty], 2
		mov [IsPVEEasyOrNot], 0
		call NewGame
		mov [StartOfGame], 0
		ret
	ImpossibleDifficulty:
		mov [StartOfGame], 1
		mov [GameActive], 1
		mov [VersusComputerDifficulty], 3
		mov [IsPVEEasyOrNot], 0
		call NewGame
		mov [StartOfGame], 0
		ret
	BackToMainMenu1:
		call PrintMainMenu
		ret
	endp DifficultyLevelScreen
	proc PrintTutorialMenu
		call ClearScreen
	; Printing the texts:
	; Title
		mov [ChosenTextRow], 3
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextTutorialMenuTitle
		call PrintChosenText
	; Explanations
	; PVE
		mov [ChosenTextRow], 5
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextTutorialMenuPVE
		call PrintChosenText
	; PVP
		mov [ChosenTextRow], 11
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextTutorialMenuPVP
		call PrintChosenText
	; Back to main menu
		mov [ChosenTextRow], 20
		mov [ChosenTextColumn], 5
		mov [ChosenTextOffset], offset TextBackToMainMenu
		call PrintChosenText
	InputFromKeyboard5:
		xor ah, ah
		int 16h
		cmp al, 01Bh
		je BackToMainMenu2
		jmp InputFromKeyboard5
	BackToMainMenu2:
		call PrintMainMenu
		ret
	endp PrintTutorialMenu
	proc PrintChosenRectangle
		mov cx, [ChosenInitialX]
		mov dx, [ChosenInitialY]
	Rectangle:
		mov ah, 0Ch
		mov al, [ChosenColor]
		xor bh, bh
		int 10h
		inc cx
		mov ax, [ChosenInitialX]
		add ax, [ChosenWidth]
		cmp cx, ax
		jb Rectangle
		mov cx, [ChosenInitialX]
		inc dx
		mov ax, [ChosenInitialY]
		add ax, [ChosenHeight]
		cmp dx, ax
		jb Rectangle
		ret
	endp PrintChosenRectangle
	proc PrintChosenFrame
	; Left side
		mov cx, [ChosenInitialX]
		mov dx, [ChosenInitialY]
	Frame1:
		mov ah, 0Ch
		mov al, [ChosenColor]
		xor bh, bh
		int 10h
		inc cx
		mov ax, [ChosenInitialX]
		add ax, [ChosenThickness]
		cmp cx, ax
		jb Frame1
		inc dx
		mov cx, [ChosenInitialX]
		mov ax, [ChosenInitialY]
		add ax, [ChosenHeight]
		cmp dx, ax
		jb Frame1
	; Right side
		mov cx, [ChosenInitialX]
		add cx, [ChosenWidth]
		sub cx, [ChosenThickness]
		mov dx, [ChosenInitialY]
	Frame2:
		mov ah, 0Ch
		mov al, [ChosenColor]
		xor bh, bh
		int 10h
		inc cx
		mov ax, [ChosenInitialX]
		add ax, [ChosenWidth]
		cmp cx, ax
		jb Frame2
		mov cx, [ChosenInitialX]
		add cx, [ChosenWidth]
		sub cx, [ChosenThickness]
		inc dx
		mov ax, [ChosenInitialY]
		add ax, [ChosenHeight]
		cmp dx, ax
		jb Frame2
	; Upper side
		mov cx, [ChosenInitialX]
		add cx, [ChosenThickness]
		mov dx, [ChosenInitialY]
	Frame3:
		mov ah, 0Ch
		mov al, [ChosenColor]
		xor bh, bh
		int 10h
		inc cx
		mov ax, [ChosenInitialX]
		add ax, [ChosenWidth]
		sub ax, [ChosenThickness]
		cmp cx, ax
		jb Frame3
		mov cx, [ChosenInitialX]
		add cx, [ChosenThickness]
		inc dx
		mov ax, [ChosenInitialY]
		add ax, [ChosenThickness]
		cmp dx, ax
		jb Frame3
	; Lower side
		mov cx, [ChosenInitialX]
		add cx, [ChosenThickness]
		mov dx, [ChosenInitialY]
		add dx, [ChosenHeight]
		sub dx, [ChosenThickness]
	Frame4:
		mov ah, 0Ch
		mov al, [ChosenColor]
		xor bh, bh
		int 10h
		inc cx
		mov ax, [ChosenInitialX]
		add ax, [ChosenWidth]
		sub ax, [ChosenThickness]
		cmp cx, ax
		jb Frame4
		mov cx, [ChosenInitialX]
		add cx, [ChosenThickness]
		inc dx
		mov ax, [ChosenInitialY]
		add ax, [ChosenHeight]
		cmp dx, ax
		jb Frame4
		ret
	endp PrintChosenFrame
	proc FlushBuffer
		mov ax, 0C00h
		int 21h
		ret
	endp FlushBuffer
	proc PrintChosenText
		mov ah, 2
		xor bh, bh
		mov dh, [ChosenTextRow]
		mov dl, [ChosenTextColumn]
		int 10h
		mov ah, 9
		mov dx, [ChosenTextOffset]
		int 21h
		ret
	endp PrintChosenText
;}
; Private Chonker Procedures{
	
	; --------------------------
	;  Chonker Set paremeters
	; --------------------------
		
		xpos DB 20h            ; chonker x-position
		ypos DB 8h			   ; not used in this code. Maybe later.

		seed dw 11             ; Default initial seed of 11   

	;------------------------ End set chonker paremeter
  
		
		proc delay
			MOV CX, 01h		; 0186A0h = 100000d = .1s delay
			MOV DX, 86A0h
			MOV AH, 86h
			INT 15h	; 0.1 seconds delay	
			RET
		ENDP delay

		; This procedure places the cursor where we specify.
		proc set_cursor
			mov  ah, 2h                 
			mov  bh, 0h                  
			int  10h                   
			RET
		endp set_cursor 


		proc rand2num1to10
			push dx
			push bx
			xor dx,dx           ; Compute randval(DX) mod 10 to get num
			mov bx,10           ;     between 0 and 9
			div bx
			inc dx              ; DX = modulo from division
								;     Add 1 to give us # between 1 and 10 (not 0 to 9)
			mov ax,dx
			pop bx
			pop dx
			ret
		endp rand2num1to10

		; Set LCG PRNG seed to system timer ticks
		;
		; Inputs:   AX = seed
		; Modifies: AX 
		; Return:   nothing 

		proc srandsystime
			push cx
			push dx
			xor ax, ax          ; Int 1Ah/AH=0 to get system timer in CX:DX 
			int 1ah
			mov [seed], dx      ; seed = 16-bit value from DX
			pop dx
			pop cx
			ret
		endp srandsystime

		; Updates seed for next iteration
		;     seed = (multiplier * seed + increment) mod 65536
		;     multiplier = 25173, increment = 13849
		;
		; Inputs: none
		; Return: (AX) random value

		proc rand 
			push dx
			mov ax, 25173       ; LCG Multiplier
			mul [word ptr seed] ; DX:AX = LCG multiplier * *seed
			add ax, 13849       ; Add LCG increment value
			mov [seed], ax      ; Update seed
			; AX = (multiplier * seed + increment) mod 65536
			pop dx
			ret
		endp rand 

	; --------------------------
	; Chonker Set procedures
	; --------------------------

	proc PrintMainMenuChonker
		mov ah,00h ;set video mode
		mov al,13h
		int 10h

		call ClearScreen
		; Showing the main menu screen texts:
		; Displaying the title
			mov [ChosenTextRow], 3
			mov [ChosenTextColumn], 5
			mov [ChosenTextOffset], offset TextMainMenuTitleChonker
			call PrintChosenTextChonker
		; Displaying the playChonkerGame option:
			mov [ChosenTextRow], 7
			mov [ChosenTextColumn], 2
			mov [ChosenTextOffset], offset TextMainMenuPlayChonker
			call PrintChosenTextChonker
		; Displaying the Tutorial screen option:
			mov [ChosenTextRow], 10
			mov [ChosenTextColumn], 2
			mov [ChosenTextOffset], offset TextMainMenuTutorial
			call PrintChosenTextChonker
		; Displaying the exit game option:
			mov [ChosenTextRow], 20
			mov [ChosenTextColumn], 5
			mov [ChosenTextOffset], offset TextMainMenuExitProgram
			call PrintChosenTextChonker
		InputFromKeyboard9:
			xor ah, ah
			int 16h
		; Play chonker 
			cmp al, 31h ; if the key that was pressed is 1
			je playChonkerGame ; then start chonker game
		; Tutorial2
			cmp al, 't'  ; if the key that was pressed is t
			je Tutorial2 ; then go to tutorial
			cmp al, 'T'  ; if the key that was pressed is T
			je Tutorial2 ; then go to tutorial
		; Exit
			cmp al, 01Bh ; if the key that was pressed is ESC
			je ExitProgramChonker
			jmp InputFromKeyboard9

		Tutorial2:
			call PrintTutorialMenuChonker
			ret
		ExitChonkerGame:
			mov [ExitingProgram], 1
			ret
	endp PrintMainMenuChonker

	ExitProgramChonker:
		call ConcludeExitProgramChonker
		ret

	proc playChonkerGame	
		call ClearScreen

		mov ah,00h ;set video mode
		mov al,00h
		int 10h

		; Next set-up the random number generator	
			call srandsystime   ; Seed PRNG with system time, call once only 

		; This is the start of the loop that will run continuously
		OuterLoop:	

		; draw some rocks
			mov CX, 10         ; CX holds the number of rocks to draw each loop.

		drawRocks:
			push CX
			call rand           ; Get a random number in AX
		;   call rand2num1to10  ; Convert AX to num between 1 and 10 (not used for now).
		; I let the set_cursor call deal with the out of range cursor positions
		; instead of normalizing the random position.

		; draw a rock at a random location on the bottom of the screen
			mov  dl, AL      ; AL is the low byte of AX which contains the random number  
			mov  dh, 18h     ; 18h = 24 decimal which is the bottom row of the screen        
			call set_cursor  ; place the cursor at the random position on the bottom row
			mov AL, 'O'      ; prepare to print an "O"
			mov BH, 0		 ; page 0
			mov BL, 0Ch		 ; color, 3=cyan
			mov CX,1         ; number of characters to print
			mov AH,09h		 ; we want the 09H (print with attribute software int)
			INT 10H			 ; do the software interrupt

		; draw the next rock until they are all drawn.
			pop CX			 ; get the counter back from the stack
			LOOP drawRocks	 ; CX=CX-1, if CX>0 then loop back to drawRocks

		; scroll the screen
			mov CH,0h		 ; set the scrolling window to the upper-left corner
			mov CL,0h
			mov DH,18h		 	
			mov DL,4Fh		 ; down to the lower right corner.
			mov AL,1h		 ; set the number of lines to scroll to one
			mov AH,06H		 ; this is the int type (scroll)
			INT 10h			 ; call the software interrupt

		; see if a rock hit the chonker
			mov  dl, [xpos]    ; set the cursor position x-coordinate to the xpos of the chonker
			mov  dh, 11h     ; in this version the chonker is always at ypos 11h        
			call set_cursor  ; move the cursor to the chonker's position
			mov BH,0         ; choose page zero
			mov AH,08h       ; we do a 08h call which reads the character at the cursor position
			int 10h			 ; do the software interrupt
			cmp AL,'O'       ; AL contains the ascii code for the character at the chonker location.
			je terminate     ; if there is an "R" at the chonker location, the chonker is terminated
			
		; if chonker is safe and position conditions are adequate, print chonker  
			cmp [xpos], 0H 		; if chonker is at left edge of screen (0h) 
			je draw_tunnel		; then dont print chonker as he/she has not moved & skip to printing just the tunnel
			cmp [xpos], 4FH		; if chonker is at right edge of screen (4fh)
			je draw_tunnel		; then dont print chonker as he/she has not moved & skip to printing just the tunnel
			JMP draw_chonker	; if chonker is not at edges, print the chonker

		; if chonker is at wall already then dont print the chonker #, print the tunnel X
		draw_tunnel:
			mov  dl, [xpos]    	; if the chonker didn't move we'll draw an "X" for the tunnel behind him
			mov  dh, 10h     	; draw the tunnel at chonker ypos 11h-1 = 10h row position so the chonker cursor is not overridden         
			call set_cursor  	; place the cursor
			mov AL, 'H'      	; we'll print an "H"
			mov BH, 0		 	; page
			mov BL, 0Ah		 	; color=white
			mov CX,1		 	; 1 copy of "X"
			mov AH,09h		 	; print char with attribute call
			INT 10H			 	; video INT
			JMP draw_chonker 	; draw the chonker cursor now

		; if chonker is safe & not on wall edges, draw the chonker
		draw_chonker:
			mov  dl, [xpos]   	; set the cursor position x-coordinate to the xpos of the chonker
			mov  dh, 11h     	; in this version the chonker is always at ypos 11h           
			call set_cursor  	; move the cursor to the chonker's position
			mov AL, '#'		 	; we'll print "#" for the chonker character
			mov BH, 0		 	; use page 0
			mov BL, 7		 	; use white as the color
			mov CX,1		 	; just one chonker
			mov AH,09h		 	; AH=09h will print a character
			INT 10H			 	; do the software interrupt
			JMP continue		; continue with OuterLoop execution

		terminate:
			call PrintGameOverScreenChonker

		; after dealing with the chonker cursor and adequate wall conditions, continue with code
		continue:	

		; We wait 0.1 second.	
			CALL delay		 ; delay 0.1 s

		; If the "q" is pressed, end the program otherwise loop through the code again.

		;CHECK IF KEY WAS PRESSED.
			mov ah, 0bh  ; int type 0bh will see if a key was pressed
			int 21h      ; RETURNS AL=0 : NO KEY PRESSED, AL!=0 : KEY PRESSED.
			cmp al, 0
			je  noKey

		;PROCESS KEY.        
			mov ah, 0	 	; AH=0 will call 
			int 16h      	; GET THE KEY.
			cmp AL, 'q'     ; terminate if 'q' key has pressed     
			je terminate
			cmp AL, 'a'  	; key pressed was "a"?
			je checkleft    ; check x position (if at left edge) and act accordingly
			cmp AL, 'd'  	; key pressed was "d"?
			je checkright   ; check x position (if at right edge) and act accordingly

		noKey:
			mov  dl, [xpos]    ; if the chonker didn't move we'll draw an "X" for the tunnel behind him
			mov  dh, 11h     ; row position        
			call set_cursor  ; place the cursor
			mov AL, 'H'      ; we'll print an "X"
			mov BH, 0		 ; page
			mov BL, 02h		 ; color=white
			mov CX,1		 ; 1 copy of "X"
			mov AH,09h		 ; print char with attribute call
			INT 10H			 ; video INT
			
			JMP OuterLoop	 ; continue the game

		; is chonker at the LEFT edge of the screen
		checkleft:
			cmp [xpos], 0H	 ; see if chonker x coordinate equals that of left screen limit
			jne moveleft	 ; if not equal to 0H, move left
			JMP OuterLoop    ; else continue the game without moving left or right

		moveleft:
			mov  dl, [xpos]    ; move chonker xpos to the column
			mov  dh, 11h     ; keep the chonker on row 11h        
			call set_cursor  ; place the cursor at the chonker position
			mov AL, 'H'      ; draw the tunnel as an "X"
			mov BH, 0        ; page 0
			mov BL, 0Ah     ; 7=white
			mov CX,1         ; one character will print
			mov AH,09h       ; print char with attribute
			INT 10H          ; print the char
			DEC [xpos]        ; move left

			JMP OuterLoop

		; is chonker at the RIGHT edge of the screen 
		checkright:
			cmp [xpos], 4FH	 ; see if chonker x coordinate equals that of right screen limit
			jne moveright	 ; if equal to 4FH, move right
			JMP OuterLoop    ; else continue the game without moving left or right

		moveright:
			mov  dl, [xpos]    ; move chonker xpos to the column   
			mov  dh, 11h     ; keep the chonker on row 11h             
			call set_cursor  ; place the cursor at the chonker position
			mov AL, 'H'      ; draw the tunnel as an "X"
			mov BH, 0        ; page 0
			mov BL, 0Ah        ; 7=white
			mov CX,1         ; one character will print
			mov AH,09h       ; print char with attribute
			INT 10H          ; print the char
			INC [xpos]        ; move right

			JMP OuterLoop    ; continue the game	

	endp playChonkerGame

	proc PrintGameOverScreenChonker
			mov ah,00h ;set video mode
			mov al,13h
			int 10h

		call ClearScreen
		; Printing title
			mov [ChosenTextRow], 4
			mov [ChosenTextColumn], 15
			mov [ChosenTextOffset], offset TextGameOverTitle
			call PrintChosenTextChonker
		DisplayingThePlayAgainMessageChonker:
			mov [ChosenTextRow], 14
			mov [ChosenTextColumn], 7
			mov [ChosenTextOffset], offset TextGameOverPlayAgain
			call PrintChosenTextChonker
		; Showing the go to main menu message:
			mov [ChosenTextRow], 16
			mov [ChosenTextColumn], 5
			mov [ChosenTextOffset], offset TextGameOverMainMenu
			call PrintChosenTextChonker
		; Waiting for a key to be pressed
		InputFromKeyboard7:
			xor ah, ah
			int 16h
			cmp ah, 01Ch ; if the key that was pressed is Enter
			je RestartChonkerGame ; then restart the game
			cmp al, 01Bh ; if the key that was pressed is ESC
			je GoToMainMenuChonker ; then go to the main menu
			jmp InputFromKeyboard7
		RestartChonkerGame:
			call playChonkerGame ; then play again
			ret
		GoToMainMenuChonker:
			call PrintMainMenuChonker ; then go to the main menu
			ret
	endp PrintGameOverScreenChonker

	
	proc PrintTutorialMenuChonker
		call ClearScreen
		; Printing the texts:
		; Title
			mov [ChosenTextRow], 3
			mov [ChosenTextColumn], 5
			mov [ChosenTextOffset], offset TextTutorialMenuTitle
			call PrintChosenTextChonker
		; Explanations
		; Body
			mov [ChosenTextRow], 5
			mov [ChosenTextColumn], 5
			mov [ChosenTextOffset], offset TextChonkerTutorial
			call PrintChosenTextChonker
		; Back to main menu
			mov [ChosenTextRow], 20
			mov [ChosenTextColumn], 5
			mov [ChosenTextOffset], offset TextBackToMainMenu
			call PrintChosenTextChonker
		InputFromKeyboard8:
			xor ah, ah
			int 16h
			cmp al, 01Bh
			je BackToMainMenu4
			jmp InputFromKeyboard8
		BackToMainMenu4:
			call PrintMainMenuChonker
			ret
	endp PrintTutorialMenuChonker


	proc ConcludeExitProgramChonker
		call PrintHome
	endp ConcludeExitProgramChonker


	proc PrintChosenTextChonker
		mov ah, 2
		xor bh, bh
		mov dh, [ChosenTextRow]
		mov dl, [ChosenTextColumn]
		int 10h
		mov ah, 9
		mov dx, [ChosenTextOffset]
		int 21h
		ret
	endp PrintChosenTextChonker
;}
;----------------------
; Main Code Start here
;----------------------
start:
	mov ax, @data ; Fetch data segment above
	mov ds, ax
; DISPLAY 2 GAMES SELECTION {

	proc PrintHome
		mov ah,00h ;set video mode
		mov al,13h
		int 10h

		call ClearScreen
		; Showing the Home menu screen texts:
		; Displaying the title
			mov [ChosenTextRow], 3
			mov [ChosenTextColumn], 5
			mov [ChosenTextOffset], offset TextHomeTitle
			call PrintChosenText
		; Displaying the playChonkerGame option:
			mov [ChosenTextRow], 7
			mov [ChosenTextColumn], 2
			mov [ChosenTextOffset], offset TextHomePlayChonker
			call PrintChosenText
		; Displaying the Tutorial screen option:
			mov [ChosenTextRow], 10
			mov [ChosenTextColumn], 2
			mov [ChosenTextOffset], offset TextHomePlayPong
			call PrintChosenText
		; Displaying the exit game option:
			mov [ChosenTextRow], 13
			mov [ChosenTextColumn], 2
			mov [ChosenTextOffset], offset TextHomeExitProgram
			call PrintChosenText
		; Displaying the Tutorial screen option:
			mov [ChosenTextRow], 21
			mov [ChosenTextColumn], 0
			mov [ChosenTextOffset], offset TextHomeEditor
			call PrintChosenText

		InputFromKeyboard6:
			xor ah, ah
			int 16h

		; Play chonker 
			cmp al, 31h ; if the key that was pressed is 1
			je MainPlayChonker ; then start chonker game
		; Play pong
			cmp al, 32h ; if the key that was pressed is 2
			je MainPlayPong ; then start pong game
		; Exit
			cmp al, 01Bh ; if the key that was pressed is ESC
			je closeTheGame
			jmp InputFromKeyboard6

		closeTheGame:
			call ConcludeClose
			ret
			
		closeTheMainGame:
			mov [closeProgram], 1
			ret

	endp PrintHome

	proc ConcludeClose
		mov ax, 2
		int 10h
		mov ah, 04Ch ; terminate program
		int 21h
	endp ConcludeClose
;}
; Chonker main code here{

	proc MainPlayChonker 

		;Main Menu
			call PrintMainMenuChonker
		;Game Over
			call PrintGameOverScreenChonker
		;Exitt chonker
			call ConcludeExitProgramChonker
		;chonker toturial
			call PrintTutorialMenu
		;chosen input
			call PrintChosenTextChonker
			ret

	endp MainPlayChonker	
;}
; Pong main code here{

	proc MainPlayPong
		
		; Graphic mode
			mov ax, 13h
			int 10h

		;Main Menu
			call PrintMainMenu

		CheckTime: ; Time checking loop
			cmp [ExitingProgram], 1
			je ExitProgram
			cmp [CurrentScene], 0
			je GoToMainMenuProcedure
			cmp [GameActive], 0
			je GameOverScreen
			mov ah, 2Ch ; system time
			int 21h
			cmp dl, [TimeAux]
			je CheckTime ; if time (milliseconds) has not passed, check again
		;	if time (milliseconds) has passed, then continue.
			mov [TimeAux], dl ; updating time
			call MovePaddles
			call DrawPaddles
			call PaintBallBlack
			call MoveBall
			call DrawBall
			mov [ChosenInitialX], 0
			mov [ChosenInitialY], 2
			mov [ChosenHeight], 196
			mov [ChosenWidth], 320
			mov [ChosenColor], 15
			mov [ChosenThickness], 1
			call PrintChosenFrame
			call UI
		;	The next four lines are doing 60 FPS.
			mov ah, 086h
			xor cx, cx
			mov dx, 0411Ah
			int 15h
			jmp CheckTime ; after everything, checks time again
		GameOverScreen:
			call PrintGameOverScreen
			jmp CheckTime
		GoToMainMenuProcedure:
			call PrintMainMenu
			jmp CheckTime

		ExitProgram:
			call ConcludeExitProgram
			ret

	endp MainPlayPong
;}
exit:
	mov ax, 4c00h
	int 21h	
END start
  

