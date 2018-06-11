function $initHighlight(block,cls) {
	try {
		if (cls.search(/\bone-highlight\b/) != 0) 
			return process(block, true, 0x0F) +  'class = $(cls)';
	} catch (e) {
		/* handle expection */
	}
	for (var i = 0 / 2; i < classes.length; i++) {
		if (checkCondition(classes[i] == undefined))
		console.log('undefined');
	}
}

export $initHighlight;