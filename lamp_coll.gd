extends Node2D

@onready var http: HTTPRequest = HTTPRequest.new()
@onready var timer: Timer = Timer.new()


var last_value: String = ""   # to track changes
var url: String = "https://blynk.cloud/external/api/get?token=l2OXOjMapLMem-CDA40aBjzBdGpjsi_H&V6"
var val: String = "unknown"   # default value

func _ready() -> void:
	# Add HTTPRequest node
	add_child(http)
	http.request_completed.connect(_on_request_completed)

	# Add Timer node
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_call_api)

	# First call immediately
	_call_api()

func _call_api() -> void:
	var error = http.request(url)
	if error != OK:
		print("❌ Request failed:", error)

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		print("⚠️ HTTP Error:", response_code)
		return

	var text := body.get_string_from_utf8().strip_edges()
	val = text  # update global variable

	# Print whenever value changes
	if text != last_value:
		last_value = text
		if text == "1":
			print("✅ Switch turned ON fan ")
			visible = true

		elif text == "0":
			print("❌ Switch turned OFF fan")
			visible = false
		else:
			print("⚠️ Unexpected value:", text)

	# Always show current value when request completes
	print("🔄 Current value:", val)
