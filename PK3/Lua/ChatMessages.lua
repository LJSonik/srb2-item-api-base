freeslot(
	"SPR_IFN1",
	"SPR_IFN2",
	"SPR_IFN3",
	"SPR_IFN4"
)


itemapi.addSpriteFont("normal", {
	width = 8,
	height = 8,
	lineGap = 2,

	characters = {
		["A"] = "IFN1:A",
		["B"] = "IFN1:B",
		["C"] = "IFN1:C",
		["D"] = "IFN1:D",
		["E"] = "IFN1:E",
		["F"] = "IFN1:F",
		["G"] = "IFN1:G",
		["H"] = "IFN1:H",
		["I"] = "IFN1:I",
		["J"] = "IFN1:J",
		["K"] = "IFN1:K",
		["L"] = "IFN1:L",
		["M"] = "IFN1:M",
		["N"] = "IFN1:N",
		["O"] = "IFN1:O",
		["P"] = "IFN1:P",
		["Q"] = "IFN1:Q",
		["R"] = "IFN1:R",
		["S"] = "IFN1:S",
		["T"] = "IFN1:T",
		["U"] = "IFN1:U",
		["V"] = "IFN1:V",
		["W"] = "IFN1:W",
		["X"] = "IFN1:X",
		["Y"] = "IFN1:Y",
		["Z"] = "IFN1:Z",

		["a"] = "IFN2:A",
		["b"] = "IFN2:B",
		["c"] = "IFN2:C",
		["d"] = "IFN2:D",
		["e"] = "IFN2:E",
		["f"] = "IFN2:F",
		["g"] = "IFN2:G",
		["h"] = "IFN2:H",
		["i"] = "IFN2:I",
		["j"] = "IFN2:J",
		["k"] = "IFN2:K",
		["l"] = "IFN2:L",
		["m"] = "IFN2:M",
		["n"] = "IFN2:N",
		["o"] = "IFN2:O",
		["p"] = "IFN2:P",
		["q"] = "IFN2:Q",
		["r"] = "IFN2:R",
		["s"] = "IFN2:S",
		["t"] = "IFN2:T",
		["u"] = "IFN2:U",
		["v"] = "IFN2:V",
		["w"] = "IFN2:W",
		["x"] = "IFN2:X",
		["y"] = "IFN2:Y",
		["z"] = "IFN2:Z",

		["0"] = "IFN3:A",
		["1"] = "IFN3:B",
		["2"] = "IFN3:C",
		["3"] = "IFN3:D",
		["4"] = "IFN3:E",
		["5"] = "IFN3:F",
		["6"] = "IFN3:G",
		["7"] = "IFN3:H",
		["8"] = "IFN3:I",
		["9"] = "IFN3:J",

		["'"] = "IFN3:K",
		["."] = "IFN3:L",
		["?"] = "IFN3:M",
		["!"] = "IFN3:N",
		[","] = "IFN3:O",
		[":"] = "IFN3:P",
		["+"] = "IFN3:Q",
		["-"] = "IFN3:R",
		["*"] = "IFN3:S",
		["/"] = "IFN3:T",
		["%"] = "IFN3:U",
		["^"] = "IFN3:V",
		["("] = "IFN3:W",
		[")"] = "IFN3:X",
		["="] = "IFN3:Y",
		["<"] = "IFN3:Z",
		[">"] = "IFN4:A",
		["_"] = "IFN4:B",
		["#"] = "IFN4:C",
		["$"] = "IFN4:D",
		["&"] = "IFN4:E",
		["@"] = "IFN4:F",
		[";"] = "IFN4:G",
		["["] = "IFN4:H",
		["]"] = "IFN4:I",
		["{"] = "IFN4:J",
		["}"] = "IFN4:K",
		[" "] = "NULL:0",
	}
})


---@param source player_t
---@param msgType integer
---@param msg string
addHook("PlayerMsg", function(source, msgType, _, msg)
	if msgType ~= 0 then return end -- Only normal messages
	if not source.itemapi_infoBubbles then return end

	-- Only one chat bubble at a time
	local oldBubble = source.itemapi_infoBubbles["chat"]
	if oldBubble then
		itemapi.stopInfoBubble(source, oldBubble)
	end

	local fontDef = itemapi.spriteFontDefs["normal"]

	msg = itemapi.wordWrapSpriteText(msg, fontDef, 256*FU)

	itemapi.startInfoBubble(source, {
		id = "chat",
		text = msg,
		duration = 10*TICRATE + #msg * TICRATE / 20
	})
end)
