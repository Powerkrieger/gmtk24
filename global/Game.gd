extends Node


var win_condition = false
var waitTime = 10
var gold = 31
var housing_space = 0
var people = 1
const paytime = 10
var tax_rate = 0


var smallHouse = {
	"housing_space": 8,
	"cost": 15,
	"tax_per_sec":1
}
var bigHouse = {
	"housing_space": 16,
	"cost": 45,
	"tax_per_sec":1
}
var shopHouse = {
	"housing_space": 0,
	"cost": 15,
	"tax_per_sec":20
}
var carHouse = {
	"housing_space": 1000,
	"cost": 150000,
	"tax_per_sec": 1000
}
