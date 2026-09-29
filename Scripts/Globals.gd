extends Node

var levels = [
	"res://Scenes/levels/level_1.tscn",
	"res://Scenes/levels/tutorial2.tscn",
	"res://Scenes/levels/JackM_level_1.tscn",
	"res://Scenes/levels/level_hayden_1.tscn",
]

var current_level = 0
var highestUnlockedLevel = 0

# Resource path, then decibels
var sounds: Dictionary[String, Array] = {
	"lose": ["res://assets/sounds/prison-cell-door.mp3", 0],
	"rewind": ["res://assets/sounds/tape-rewind.mp3", 0],
	"win": ["res://assets/sounds/truck-engine-start.mp3", -4],
	"jump": ["res://assets/sounds/grunt_2_processed.mp3", 0],
	"pickup": ["res://assets/sounds/rolling-bag-out-processed.mp3", 0]
}

var loadedSounds: Dictionary[String, AudioStreamPlayer] = {}

var music: Dictionary[String, Array] = {
	"main": ["res://assets/sounds/MainLevelTheme.mp3", -5]
}

var loadedMusic: Dictionary[String, AudioStreamPlayer] = {}

var currSong: String = ""

var debugMode: bool = false

enum States {NIGHT, DAY}

var current_state
var times_swapped: int = 0
var clickSFX: AudioStreamPlayer
var swappingDisabled: bool = false

signal NightSwapped
signal DaySwapped

signal KeyHitDoor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (debugMode):
		highestUnlockedLevel = len(levels)
	current_state = States.DAY
	DaySwapped.emit()
	for sound in sounds.keys():
		var player = AudioStreamPlayer.new()
		print("Loading sound: " + sound)
		player.stream = load(sounds[sound][0])
		player.volume_db = sounds[sound][1]
		add_child(player)
		player.max_polyphony = 5
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		loadedSounds[sound] = player
	
	for song in music.keys():
		var player = AudioStreamPlayer.new()
		print("Loading sound: " + song)
		player.stream = load(music[song][0])
		player.volume_db = music[song][1]
		add_child(player)
		loadedMusic[song] = player
		
	clickSFX = AudioStreamPlayer.new()
	clickSFX.stream = AudioStreamMP3.load_from_file("res://assets/sounds/click.mp3")
	add_child(clickSFX)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("SwapTime") and not swappingDisabled:
		swapState()

func next_level():
	current_level += 1
	if (current_level >= len(levels)):
		current_level = 0
		get_tree().change_scene_to_file("res://Scenes/game_win_screen.tscn")
		return
	get_tree().change_scene_to_file(levels[current_level])

func swapState():
	playSound("rewind", .34, 1.25)
	times_swapped += 1
	if current_state == States.NIGHT:
		current_state = States.DAY
		DaySwapped.emit()
	elif current_state == States.DAY:
		current_state = States.NIGHT
		NightSwapped.emit()

func setDayNight(targetState: States):
	if (current_state != targetState):
		current_state = targetState
		if (targetState == States.DAY):
			DaySwapped.emit()
		else:
			NightSwapped.emit()

func playClickSFX():
	clickSFX.pitch_scale = randf_range(0.8,1.2)
	clickSFX.play()

func playSound(soundname: String, time: float = 0, maxTime: float = 0):
	if (soundname in loadedSounds.keys()):
		print("Playing sound: " + soundname)
		loadedSounds[soundname].pitch_scale = randf_range(0.8,1.2)
		loadedSounds[soundname].play(time)
		if (maxTime != 0):
			get_tree().create_timer(maxTime - time).timeout.connect(func(): loadedSounds[soundname].stop())
	else:
		push_warning("Attempt to play non-loaded sound: " + soundname)

func playMusic(songName: String):
	stopMusic()
	if (songName in loadedMusic.keys()):
		print("Playing song: " + songName)
		loadedMusic[songName].play()
		currSong = songName
	else:
		push_warning("Attempt to play non-loaded song: " + songName)

func stopMusic():
	if (currSong):
		loadedMusic[currSong].stop()
		currSong = ""

func saveGame():
	if (debugMode): return
	var save_file = FileAccess.open("user://savegame.txt", FileAccess.WRITE)
	save_file.store_line(str(highestUnlockedLevel))

func loadGame():
	if (debugMode): return len(levels)
	var save_file = FileAccess.open("user://savegame.txt", FileAccess.READ)
	if (not save_file):
		highestUnlockedLevel = 0
	else:
		highestUnlockedLevel = save_file.get_line().to_int()
