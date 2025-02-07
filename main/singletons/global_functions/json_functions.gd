class_name JSONFunctions
extends Resource

#Pack to JSON String
func pack_json(object : Object) -> String:
	var json_string : String = JSON.stringify(object)
	return json_string

#Unpack from JSON String
func unpack_json(json_string : String) -> Object:
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		return data_received
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return null
