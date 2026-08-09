left	=InputPressed(INPUT_VERB.LEFT);
right	=InputPressed(INPUT_VERB.RIGHT);
up		=InputPressed(INPUT_VERB.UP);
down	=InputPressed(INPUT_VERB.DOWN);
akey	=(InputPressed(INPUT_VERB.A) || InputPressed(INPUT_VERB.ENTER));
bkey	=InputPressed(INPUT_VERB.B)
ckey	=InputPressed(INPUT_VERB.C)

// vars so you don't copy and paste the same shit over and over
var _RowCount=_charCount div _rowLimit, // number of rows
	_curRow=_select div _rowLimit, // current row (y)
	_curPos=_select % _rowLimit, // current position (x)
	_topRowLimit=_charCount % _rowLimit, // how many cards are on the top row
	_beyondTopLimit=(_select+(_rowLimit-_topRowLimit)); // check to see if going up will go beyond the amount of cards at the top

if (akey) {
	if (instance_exists(oMainMenu))
		var i = 0;
		repeat(4) {
		    global.lives[i]=5
			i++
		}
		
		FadeTransition(0.5, function() {
			room_goto(rGame);
		});
		global._playerChars = [oGlobals._charmList[_select]];
	instance_destroy();
}

if (bkey) {
	if (instance_exists(oMainMenu)) {
		with (oMainMenu) {
			//backAmenu("levelselectm");
			optionLock=0;
		}
	}
	instance_destroy();
}

if (left) {
	_select -= 1;
	
	if (_RowCount=_curRow) and (_select<_rowLimit*_curRow)
		_select = _rowLimit*(_curRow+1)-1-(_rowLimit-_topRowLimit);
	else if (_select<_rowLimit*_curRow)
		_select = _rowLimit*(_curRow+1)-1;
}

if (right) {
	_select += 1;
		
	if (_RowCount=_curRow) and (_select>_rowLimit*(_curRow+1)-1-(_rowLimit-_topRowLimit))
		_select = _rowLimit*(_curRow);
	else if (_select>_rowLimit*(_curRow+1)-1)
		_select = _rowLimit*(_curRow);
}

if (down) {
	_select += _rowLimit;
	if (_select>_charCount-1)
		_select = _curPos;
}

if (up) {
	_select -= _rowLimit;
	
	if (_select<0) {
		if (_beyondTopLimit >= _rowLimit) {
			_select = _charCount-(_rowLimit-_curPos)+1+(_rowLimit-(_topRowLimit+1))-_rowLimit;
		} else {
			_select = _charCount-(_rowLimit-_curPos)+1+(_rowLimit-(_topRowLimit+1));
		}
	}
}