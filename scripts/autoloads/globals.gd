extends Node

enum STAT {
	NONE,
	MUSCLE,
	BRAINS,
	LUCK,
	ZOOM,
	ENERGY,
	BOREDOM,
	AFFECTION,
	HUNGER,
}

var current_buddies: Array[BuddyResource] = [
	preload("res://assets/resources/sloth_buddy.tres"),
	preload("res://assets/resources/dog_buddy.tres")]
