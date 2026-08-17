extends AudioStreamPlayer

const NORMAL_DB := 0.0
const DUCKED_DB := -15.0

func duck() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), DUCKED_DB)
	
func normal() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), NORMAL_DB)
